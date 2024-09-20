<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template name="formatDate">
        <xsl:param name="timestamp"/>
        <xsl:variable name="dateInSeconds" select="number($timestamp) div 1000"/>
        
        <xsl:variable name="date" select="ms:format-dateTime($dateInSeconds, 'yyyy-MM-ddTHH:mm:ssZ')"/>
        
        <!-- Extraire l'année, le mois, le jour, l'heure, la minute, et la seconde -->
        <xsl:variable name="year" select="substring($date, 1, 4)"/>
        <xsl:variable name="month" select="substring($date, 6, 2)"/>
        <xsl:variable name="day" select="substring($date, 9, 2)"/>
        <xsl:variable name="hour" select="substring($date, 12, 2)"/>
        <xsl:variable name="minute" select="substring($date, 15, 2)"/>
        <xsl:variable name="second" select="substring($date, 18, 2)"/>

        <!-- Ajustement de l'heure pour le fuseau horaire -->
        <xsl:variable name="adjustedHour" select="number($hour) - 2"/>
        <xsl:if test="$adjustedHour &lt; 0">
            <xsl:variable name="finalHour" select="$adjustedHour + 24"/>
            <xsl:variable name="finalDay" select="number($day) - 1"/>
        </xsl:if>
        <xsl:if test="$adjustedHour &gt;= 0">
            <xsl:variable name="finalHour" select="$adjustedHour"/>
            <xsl:variable name="finalDay" select="$day"/>
        </xsl:if>

        <xsl:variable name="formattedDate" select="concat('Le ', $finalDay, '/', $month, '/', substring($year, 3, 2), ' à ', format-number($finalHour, '00'), ':', format-number($minute, '00'), ':', format-number($second, '00'))"/>
        
        <xsl:value-of select="$formattedDate"/>
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
                <title>SMS Messages</title>
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
                    <xsl:for-each select="smses/sms">
                        <div class="dialogue">
                            <xsl:choose>
                                <xsl:when test="@type = 2">
                                    <span class="character sent">Kevin (<xsl:call-template name="formatDate">
                                        <xsl:with-param name="timestamp" select="@date"/>
                                    </xsl:call-template>) :</span>
                                    <span class="message sent">
                                        <xsl:value-of select="@body"/>
                                    </span>
                                </xsl:when>
                                <xsl:when test="@type = 1">
                                    <span class="character received">
                                        <xsl:value-of select="@contact_name"/> 
                                        (<xsl:call-template name="formatDate">
                                            <xsl:with-param name="timestamp" select="@date"/>
                                        </xsl:call-template>) :
                                    </span>
                                    <span class="message received">
                                        <xsl:value-of select="@body"/>
                                    </span>
                                </xsl:when>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
