$MyOPMLFile= '.\simple-talk.opml' #change this to the name of your OPML file
$DaysBack=[int]-20 #the number of days back you want articles from

function truncate([string]$value, [int]$MaxLength)
{#can you believe there is no powershell built-in way of doing this?
    if ($value.Length -gt $MaxLength) { $value.Substring(0, $MaxLength) }
    else { $value }
}

[xml]$opml= Get-Content $MyOPMLFile # grab the OPML file of feeds
[xml]$Output=$opml.opml.body.outline.outline | 
   select @{name="Title"; Expression={$_.title}},
			 @{name="Feed"; Expression={$_.xmlUrl}},
			 @{name="PageURL"; Expression={$_.htmlUrl}},
          @{name="Publication"; Expression={$_.ParentNode.text}} |
foreach-object { 
	$successful=$true #assume the best
	try {
      Invoke-WebRequest $_.Feed -outfile '.\tempXML'
      [xml]$xml = Get-Content '.\tempXML'}
		catch{$successful=$false} #filter out 404s, malformed items  and bad links
   $Publication=$_.Publication
	$Stream=$_.Title
	$PageURL=$_.PageURL
	$FeedName=$xml.rss.channel.title #makes sure there is something in it
	If ($successful)
	 {
    $xml.rss.channel.item | # flag if an error happened

<# Each <item> within a feed represents an article. The <item> must include at least the following elements:
    <link>: The canonical URL for the article.
    <content:encoded>: The full HTML content of the article.
But you are also likely to find ..
    <title>: The article's headline. If it isn't there, you'd need to find it in the content
    <pubDate>: The date of the article's publication, in RFC822 format.
    <description>: A short, summary or abstract of the article.
    <dc:creator>: Name of the person who wrote the article. 
    <media:content> and <media:group>: URLs and metadata for image, video, and audio assets. 
#>
     Select @{name="Feed"; Expression={$FeedName}}, 
		@{name="Title"; Expression = {try {$_.title} catch {'Unknown title'}}}, 
      @{name="Description"; # this isn't manatory, but you can get the content
         Expression ={try { if ($_.SelectSingleNode('description') -eq $null) 
                                 { truncate ($_.encoded.'#cdata-section' -replace "<.*?>") 500} 
                            elseif ( $_.description.ToString() -eq 'description') 
                                 {truncate ($_.description.'#cdata-section'  -replace "<.*?>") 500 } 
                            else {truncate ($_.description  -replace "<.*?>") 500 }} 
                      catch {'error'}}},
      @{name="Publication"; Expression={$Publication}},
      @{name="Stream"; Expression={$Stream}},
      @{name="PageURL"; Expression={$PageURL}},
      @{name="PubDate"; Expression = {try {get-date ($_.PubDate -replace  "UT")} # force it into a PS date  
                                       catch {Get-Date '01 January 2006 00:00:00'}}}, 
      @{name="author"; Expression = {try {if ( $_.author.length -eq 0) {$_.creator} 
                                           else {$_.author}} 
                                      catch{'Unknown Author'}}},
        link | #we already checked for a link!
			 where-object {$_.Pubdate -gt  (Get-Date).AddDays($DaysBack)}
				# we only get the fresh news from the last couple of days.
    }
  else #we couldn't get the feed so write error
	{
	write-error " $_ didn't respond"
   }
  }|sort-object PubDate -descending |ConvertTo-XML #sort by date and convert to XML
$Output.Save('LatestStories.XML')
'All done, master'

