<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="ISO-8859-1" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

  <xsl:template name="formatDate">
    <xsl:param name="timestamp"/>
    <xsl:variable name="date" select="number($timestamp) div 1000"/>
    <xsl:variable name="day" select="format-number((($date div 86400) mod 30) + 1, '00')"/>
    <xsl:variable name="month" select="format-number((($date div 2629743) mod 12) + 1, '00')"/>
    <xsl:variable name="year" select="format-number(($date div 31556926) + 1970, '00')"/>
    <xsl:variable name="hour" select="format-number(($date mod 86400) div 3600, '00')"/>
    <xsl:variable name="minute" select="format-number((($date mod 3600) div 60), '00')"/>
    <xsl:value-of select="concat('Le ', $day, '/', $month, '/', $year, ' à ', $hour, ':', $minute)"/>
  </xsl:template>

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
                  <span class="character sent">Kevin (<xsl:call-template name="formatDate"><xsl:with-param name="timestamp" select="@date"/></xsl:call-template>) :</span>
                  <span class="sent message"><xsl:value-of select="@body"/></span>
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
