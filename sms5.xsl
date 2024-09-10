<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
  ~ Copyright (c) 2010 - 2016 Carbonite. All Rights Reserved.
  -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:user="http://android.riteshsahu.com">
<xsl:output method="html" encoding="ISO-8859-1" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
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
		  </style>
	  </head>
	  <body>
	  <h2>SMS Messages</h2>
	  <div class="dialogues">
		<xsl:for-each select="smses/sms[@address='+33645356023']">
			<div class="dialogue">
				<xsl:choose>
					<xsl:when test="@type = 2">
						<span class="character">Kevin:</span>
						<span class="message"><xsl:value-of select="@body"/></span>
					</xsl:when>
					<xsl:when test="@type = 1">
						<span class="character"><xsl:value-of select="@contact_name"/>:</span>
						<span class="message"><xsl:value-of select="@body"/></span>
					</xsl:when>
				</xsl:choose>
			</div>
		</xsl:for-each>
	  </div>
	  </body>
  </html>
</xsl:template>
</xsl:stylesheet>
