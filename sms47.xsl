<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

<xsl:template name="formatDate">
    <xsl:param name="timestamp"/>
    <!-- Convertir le timestamp de millisecondes en secondes -->
    <xsl:variable name="dateInSeconds" select="number($timestamp) div 1000"/>
    
    <!-- Utilisation de seconds pour créer une date lisible -->
    <xsl:variable name="dateString" select="concat('1970-01-01T00:00:00Z')"/>
    
    <!-- Ajouter les secondes au format string -->
    <xsl:variable name="formattedDate" select="substring(date:add($dateString, $dateInSeconds), 1, 19)"/>
    
    <xsl:value-of select="$formattedDate"/>
</xsl:template>

<xsl:template name="replaceCodes">
    <xsl:param name="text"/>
    <xsl:variable name="newlineReplaced" select="translate($text, '10;', '
')"/>
    <xsl:value-of select="$newlineReplaced"/>
</xsl:template>

<xsl:template match="/">
  <html>
    <head>
      <style type="text/css">
      body {
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
        text-align: right; /* Aligning sent messages to the right */
        margin-right: 20px; /* Adding margin to the right for better alignment */
      }
      .message.sent {
        text-align: right; /* Aligning the body of sent messages to the right */
        margin-right: 20px; /* Adding margin to the right for better alignment */
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
        <xsl:for-each select="smses/sms[@contact_name='Cindy']">
          <xsl:sort select="@date" data-type="number" order="ascending"/>
          <div class="dialogue">
            <xsl:choose>
              <xsl:when test="@type = 2">
                <span class="character sent">Kevin (<xsl:call-template name="formatDate"><xsl:with-param name="timestamp" select="@date"/></xsl:call-template>) :</span>
                <span class="message sent"><xsl:call-template name="replaceCodes"><xsl:with-param name="text" select="@body"/></xsl:call-template></span>
              </xsl:when>
              <xsl:when test="@type = 1">
                <span class="character received"><xsl:value-of select="@contact_name"/> (<xsl:call-template name="formatDate"><xsl:with-param name="timestamp" select="@date"/></xsl:call-template>) :</span>
                <span class="message received"><xsl:call-template name="replaceCodes"><xsl:with-param name="text" select="@body"/></xsl:call-template></span>
              </xsl:when>
            </xsl:choose>
          </div>
        </xsl:for-each>
      </div>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>