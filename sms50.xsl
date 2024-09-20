<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

    <!-- Template pour formater les timestamps en XSLT 1.0 avec gestion des mois -->
    <xsl:template name="formatDate">
        <xsl:param name="timestamp"/>
        <xsl:variable name="dateInSeconds" select="number($timestamp) div 1000"/>

        <!-- Calcul des années -->
        <xsl:variable name="year" select="1970 + floor($dateInSeconds div 31556926)"/>

        <!-- Calcul du jour de l'année (reste des secondes après les années) -->
        <xsl:variable name="remainingDaysInSeconds" select="$dateInSeconds mod 31556926"/>
        <xsl:variable name="daysOfYear" select="floor($remainingDaysInSeconds div 86400)"/>

        <!-- Variables pour calculer si l'année est bissextile -->
        <xsl:variable name="isLeapYear" select="($year mod 4 = 0 and $year mod 100 != 0) or ($year mod 400 = 0)"/>

        <!-- Tableau des jours par mois, avec gestion de l'année bissextile -->
        <xsl:variable name="daysInMonth">
            <xsl:choose>
                <xsl:when test="$isLeapYear">
                    <!-- Année bissextile -->
                    <xsl:value-of select="'31,29,31,30,31,30,31,31,30,31,30,31'"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Année normale -->
                    <xsl:value-of select="'31,28,31,30,31,30,31,31,30,31,30,31'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Détermination du mois en fonction du nombre de jours cumulés -->
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

        <!-- Calcul du jour dans le mois -->
        <xsl:variable name="day">
            <xsl:choose>
                <xsl:when test="$month = 1">floor($daysOfYear + 1)</xsl:when>
                <xsl:when test="$month = 2">floor($daysOfYear - 31 + 1)</xsl:when>
                <xsl:when test="$month = 3">floor($daysOfYear - 59 + 1)</xsl:when>
                <xsl:when test="$month = 4">floor($daysOfYear - 90 + 1)</xsl:when>
                <xsl:when test="$month = 5">floor($daysOfYear - 120 + 1)</xsl:when>
                <xsl:when test="$month = 6">floor($daysOfYear - 151 + 1)</xsl:when>
                <xsl:when test="$month = 7">floor($daysOfYear - 181 + 1)</xsl:when>
                <xsl:when test="$month = 8">floor($daysOfYear - 212 + 1)</xsl:when>
                <xsl:when test="$month = 9">floor($daysOfYear - 243 + 1)</xsl:when>
                <xsl:when test="$month = 10">floor($daysOfYear - 273 + 1)</xsl:when>
                <xsl:when test="$month = 11">floor($daysOfYear - 304 + 1)</xsl:when>
                <xsl:otherwise>floor($daysOfYear - 334 + 1)</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Calcul des heures, minutes et secondes -->
        <xsl:variable name="hour" select="format-number((($remainingDaysInSeconds mod 86400) div 3600), '00')"/>
        <xsl:variable name="minute" select="format-number((($remainingDaysInSeconds mod 3600) div 60), '00')"/>
        <xsl:variable name="second" select="format-number(($remainingDaysInSeconds mod 60), '00')"/>

        <!-- Construction de la date formatée -->
        <xsl:variable name="formattedDate" select="concat('Le ', $day, '/', format-number($month, '00'), '/', substring($year, 3, 2), ' à ', $hour, ':', $minute, ':', $second)"/>

        <!-- Affichage de la date formatée -->
        <xsl:value-of select="$formattedDate"/>
    </xsl:template>

    <!-- Template pour remplacer les codes par des sauts de ligne -->
    <xsl:template name="replaceCodes">
        <xsl:param name="text"/>
        <xsl:variable name="newlineReplaced" select="translate($text, '10;', '&#10;')"/>
        <xsl:value-of select="$newlineReplaced"/>
    </xsl:template>

    <!-- Modèle principal pour l'affichage des SMS -->
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
                                    <span class="character sent">Kevin (<xsl:call-template name="formatDate">
                                        <xsl:with-param name="timestamp" select="@date"/>
                                    </xsl:call-template>) :</span>
                                    <span class="message sent">
                                        <xsl:call-template name="replaceCodes">
                                            <xsl:with-param name="text" select="@body"/>
                                        </xsl:call-template>
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
                                        <xsl:call-template name="replaceCodes">
                                            <xsl:with-param name="text" select="@body"/>
                                        </xsl:call-template>
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
