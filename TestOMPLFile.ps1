$dir="$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$dir
$MyOPMLFile= "$dir\simple-talk.opml" #change this to the name of your OPML file

[xml]$opml= Get-Content $MyOPMLFile # grab the OPML file of feeds
$opml.opml.body.outline.outline | 
   select @{name="Title"; Expression={$_.title}},
			 @{name="Feed"; Expression={$_.xmlUrl}},
			 @{name="PageURL"; Expression={$_.htmlUrl}},
          @{name="Publication"; Expression={$_.ParentNode.text}} 

'All done, master'
$opml