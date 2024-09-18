<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="ISO-8859-1" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

  <xsl:template match="/">
    <html>
      <head>
        <style type="text/css">
          body {
            font-family: 'Times New Roman', serif;
            color: #000;
            font-size: 16px;
            line-height: 1.5;
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
            margin-right: 20px;
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
                  <span class="character sent">Kevin (@date) :</span>
                  <span class="message sent"><xsl:value-of select="@body"/></span>
                </xsl:when>
                <xsl:when test="@type = 1">
                  <span class="character received"><xsl:value-of select="@contact_name"/> (@date) :</span>
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
