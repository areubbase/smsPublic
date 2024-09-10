<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
  ~ Copyright (c) 2010 - 2016 Carbonite. All Rights Reserved.
  -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:user="http://android.riteshsahu.com">
<xsl:output method="html" encoding="ISO-8859-1" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

<xsl:template name="formatDate">
    <xsl:param name="timestamp"/>
    <xsl:variable name="date" select="msxsl:node-set(user:format-date($timestamp))"/>
    <xsl:value-of select="concat('Le ', substring($date, 9, 2), '/', substring($date, 6, 2), '/', substring($date, 3, 2), ' à ', substring($date, 12, 5))"/>
</xsl:template>

<xsl:template match="/">
  <html>
	  <head>
		  <style type="text/css">
		  body 
		  {
			font-family: 'Times New Roman', serif;
			color:#000;
			font-size:16px;
			line-height:1.5;
			margin: 40px;
		  }
		  .dialogue {
			margin-bottom: 20px;
		  }
		  .character {
			font-weight: bold;
			display: block;
			margin-bottom: 5px;
		  }
		  .message {
			text-align: left;
			margin-left: 20px;
		  }
		  .sent {
			color: blue;
			text-align: right;
		  }
		  .received {
			color: pink;
			text-align: left;
		  }
		  </style>
	  </head>
	  <body>
	  <h2>SMS Messages</h2>
	  <div class="dialogues">
		<xsl:for-each select="smses/sms[@address='+33645356023' or @address='+33 6 45 35 60 23']">
			<xsl:sort select="@date" data-type="number" order="ascending"/>
			<div class="dialogue">
				<xsl:choose>
					<xsl:when test="@type = 2">
						<span class="character sent">Kevin (<xsl:call-template name="formatDate"><xsl:with-param name="timestamp" select="@date"/></xsl:call-template>) :</span>
						<span class="message sent"><xsl:value-of select="@body"/></span>
					</xsl:when>
					<xsl:when test="@type = 1">
						<span class="character received"><xsl:value-of select="@contact_name"/> (<xsl:call-template name="formatDate"><xsl:with-param name="timestamp" select="@date"/></xsl:call-template>) :</span>
						<span class="message received"><xsl:value-of select="@body"/></span>
					</xsl:when>
				</xsl:choose>
			</div>
		</xsl:for-each>
	  </div>
	  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
