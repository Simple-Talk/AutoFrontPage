
[xml]$xml=@'
<?xml version="1.0" encoding="ISO-8859-1"?>
<Objects>
- <Object Type="System.Management.Automation.PSCustomObject">
  <Property Name="Feed" Type="System.String">SQLServerCentral.com Articles tagged Editorial</Property> 
  <Property Name="Title" Type="System.String">A Better Conference</Property> 
  <Property Name="Description" Type="System.String">Is there a better way to put together a conference or event? Today Steve Jones speculates on how events are run and how we might change things.</Property> 
  <Property Name="Publication" Type="System.String">SQL Server Central</Property> 
  <Property Name="Stream" Type="System.String">Editorials</Property> 
  <Property Name="PageURL" Type="System.String">http://www.sqlservercentral.com/Articles/Editorial</Property> 
  <Property Name="PubDate" Type="System.DateTime">05/07/2013 06:00:00</Property> 
  <Property Name="author" Type="" /> 
  <Property Name="Ago" Type="System.String">18 days ago</Property> 
  <Property Name="link" Type="System.String">http://www.sqlservercentral.com/articles/Editorial/100446/</Property> 
  </Object>
- <Object Type="System.Management.Automation.PSCustomObject">
  <Property Name="Feed" Type="System.String">Simple-Talk blogs</Property> 
  <Property Name="Title" Type="System.String">Comparing Apples and Pairs</Property> 
  <Property Name="Description" Type="System.String">A recent study, High Costs and Negative Value of Pair Programming, by Capers Jones, pulls no punches in its assessment of the costs-to- benefits ratio of pair programming, two programmers working together, at a single computer, rather than separately. He implies that pair programming is a method rushed into production on a wave of enthusiasm [...]</Property> 
  <Property Name="Publication" Type="System.String">simple-talk</Property> 
  <Property Name="Stream" Type="System.String">Blogs</Property> 
  <Property Name="PageURL" Type="System.String">https://www.simple-talk.com/blogs/</Property> 
  <Property Name="PubDate" Type="System.DateTime">04/07/2013 14:09:02</Property> 
  <Property Name="author" Type="System.String">Tony Davis</Property> 
  <Property Name="Ago" Type="System.String">19 days ago</Property> 
  <Property Name="link" Type="System.String">https://www.simple-talk.com/blogs/2013/07/04/comparing-apples-and-pairs/</Property> 
  </Object>
- <Object Type="System.Management.Automation.PSCustomObject">
  <Property Name="Feed" Type="System.String">SQLServerCentral.com Articles tagged Editorial</Property> 
  <Property Name="Title" Type="System.String">Independence Day 2013</Property> 
  <Property Name="Description" Type="System.String">Happy 4th of July in the United States</Property> 
  <Property Name="Publication" Type="System.String">SQL Server Central</Property> 
  <Property Name="Stream" Type="System.String">Editorials</Property> 
  <Property Name="PageURL" Type="System.String">http://www.sqlservercentral.com/Articles/Editorial</Property> 
  <Property Name="PubDate" Type="System.DateTime">04/07/2013 06:00:00</Property> 
  <Property Name="author" Type="" /> 
  <Property Name="Ago" Type="System.String">19 days ago</Property> 
  <Property Name="link" Type="System.String">http://www.sqlservercentral.com/articles/Editorial/100394/</Property> 
  </Object>
  </Objects>
'@ 

[xml]$xsltfile=@'
<?xml version="1.0" encoding="ISO-8859-1"?>
<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
  <body style="font-family:Arial;font-size:11pt;background-color:#EEEEEE">
    <xsl:for-each select="Objects/Object">
      <div style="background-color:teal;color:white;padding:4px">
         <xsl:variable name="linkurl" select="Property[@Name='link']"/>
         <xsl:variable name="pageurl" select="Property[@Name='PageURL']"/>
          <a style="color:white" href="{$linkurl}">
         <span style="font-weight:bold"><xsl:value-of select="Property[@Name='Title']"/></span></a>
         <a style="color:white" href="{$pageurl}">
        <span style="font-weight:Normal;margin-left:20px;font-size:11pt;"><xsl:value-of select="Property[@Name='Publication']"/></span></a>
        <span style="color: silver; font-weight:Normal;margin-left:20px;font-size:11pt;"><xsl:value-of select="Property[@Name='Ago']"/></span>

      </div>
       <div style="background-color:white;color:black;padding:4px">
        <span style="font-weight:normal"><xsl:value-of select="Property[@Name='Description']"/></span>
      </div>
    </xsl:for-each>
  </body>
</html>
'@ 
$xml.Save('XMLList.XML')
$xsltfile.Save('XSLTFile.XML')
$xslt = New-Object System.Xml.Xsl.XslCompiledTransform #crank up the net library to do the job
$xslt.Load('XSLTFile.XML') #heave in the template
$xslt.Transform('XMLList.XML', 'MyHTMLFile.HTML') #and create the HTML
