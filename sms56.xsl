<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template name="formatDate">
        <xsl:param name="timestamp"/>
        <xsl:variable name="dateInSeconds" select="number($timestamp) div 1000"/>

        <xsl:variable name="year" select="1970 + floor($dateInSeconds div 31556926)"/>
        <xsl:variable name="remainingDaysInSeconds" select="$dateInSeconds mod 31556926"/>
        <xsl:variable name="daysOfYear" select="floor($remainingDaysInSeconds div 86400)"/>

        <xsl:variable name="isLeapYear" select="($year mod 4 = 0 and $year mod 100 != 0) or ($year mod 400 = 0)"/>
        <xsl:variable name="monthDays" select="concat(if ($isLeapYear) then '31,29,31,30,31,30,31,31,30,31,30,31' else '31,28,31,30,31,30,31,31,30,31,30,31')"/>

        <xsl:variable name="month">
            <xsl:choose>
                <xsl:when test="$daysOfYear &lt; 31">1</xsl:when>
                <xsl:when test="$daysOfYear &lt; 59">2</xsl:when>
                <xsl:when test="$daysOfYear &lt; 90">3</xsl:when>
                <xsl:when test="$daysOfYear &lt; 120">4</xsl:when>
                <xsl:when test="$daysOfYear &lt; 151">5</xsl:when>
                <xsl:when test="$daysOfYear &lt; 181">6</xsl:when>
                <xsl:when test="$daysOfYear &lt; 212">7</xsl:when>
                <xsl:when test="$daysOfYear &lt; 243">8</xsl:when>
                <xsl:when test="$daysOfYear &lt; 273">9</xsl:when>
                <xsl:when test="$daysOfYear &lt; 304">10</xsl:when>
                <xsl:when test="$daysOfYear &lt; 334">11</xsl:when>
                <xsl:otherwise>12</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="day">
            <xsl:choose>
                <xsl:when test="$month = 1"><xsl:value-of select="$daysOfYear + 1"/></xsl:when>
                <xsl:when test="$month = 2"><xsl:value-of select="$daysOfYear - 31 + 1"/></xsl:when>
                <xsl:when test="$month = 3"><xsl:value-of select="$daysOfYear - 59 + 1"/></xsl:when>
                <xsl:when test="$month = 4"><xsl:value-of select="$daysOfYear - 90 + 1"/></xsl:when>
                <xsl:when test="$month = 5"><xsl:value-of select="$daysOfYear - 120 + 1"/></xsl:when>
                <xsl:when test="$month = 6"><xsl:value-of select="$daysOfYear - 151 + 1"/></xsl:when>
                <xsl:when test="$month = 7"><xsl:value-of select="$daysOfYear - 181 + 1"/></xsl:when>
                <xsl:when test="$month = 8"><xsl:value-of select="$daysOfYear - 212 + 1"/></xsl:when>
                <xsl:when test="$month = 9"><xsl:value-of select="$daysOfYear - 243 + 1"/></xsl:when>
                <xsl:when test="$month = 10"><xsl:value-of select="$daysOfYear - 273 + 1"/></xsl:when>
                <xsl:when test="$month = 11"><xsl:value-of select="$daysOfYear - 304 + 1"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="$daysOfYear - 334 + 1"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="hour" select="format-number((($remainingDaysInSeconds mod 86400) div 3600) - 2, '00')"/>
        <xsl:variable name="minute" select="format-number((($remainingDaysInSeconds mod 3600) div 60), '00')"/>
        <xsl:variable name="second" select="format-number(($remainingDaysInSeconds mod 60), '00')"/>

        <xsl:if test="$hour &lt; 0">
            <xsl:variable name="hour" select="$hour + 24"/>
            <xsl:variable name="day" select="number($day) - 1"/>
        </xsl:if>

        <xsl:variable name="formattedDate" select="concat('Le ', $day, '/', format-number($month, '00'), '/', substring($year, 3, 2), ' à ', $hour, ':', $minute, ':', $second)"/>
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
                    <xsl:for-each select="smses/sms[@contact_name='Cindy']">
                        <xsl:sort select="@date" data-type="number" order="ascending"/>
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
