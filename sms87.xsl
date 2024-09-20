<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
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
                        display: block;
                    }
                    .received {
                        color: pink;
                        text-align: left;
                        display: block;
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
                                    <div class="sent">
                                        <span class="character">Kevin (<xsl:value-of select="@readable_date"/>) :</span>
                                        <span class="message">
                                            <xsl:call-template name="process-message">
                                                <xsl:with-param name="text" select="@body"/>
                                            </xsl:call-template>
                                        </span>
                                    </div>
                                </xsl:when>
                                <xsl:when test="@type = 1">
                                    <div class="received">
                                        <span class="character">
                                            <xsl:value-of select="@contact_name"/> 
                                            (<xsl:value-of select="@readable_date"/>) :
                                        </span>
                                        <span class="message">
                                            <xsl:call-template name="process-message">
                                                <xsl:with-param name="text" select="@body"/>
                                            </xsl:call-template>
                                        </span>
                                    </div>
                                </xsl:when>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Template pour le traitement des messages -->
    <xsl:template name="process-message">
        <xsl:param name="text" />
        <xsl:variable name="with-line-breaks">
            <!-- Remplacer chaque saut de ligne par un élément HTML <br/> -->
            <xsl:call-template name="replace-line-breaks">
                <xsl:with-param name="text" select="$text"/>
            </xsl:call-template>
        </xsl:variable>
        <!-- Gérer les emojis dans le texte -->
        <xsl:variable name="converted-text">
            <xsl:call-template name="replace-emojis">
                <xsl:with-param name="text" select="$with-line-breaks"/>
            </xsl:call-template>
        </xsl:variable>
        <!-- Restituer le texte avec les sauts de ligne et emojis -->
        <xsl:value-of select="$converted-text" disable-output-escaping="yes"/>
    </xsl:template>

    <!-- Template pour remplacer les sauts de ligne par <br/> -->
    <xsl:template name="replace-line-breaks">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="contains($text, '&#10;')">
                <xsl:value-of select="substring-before($text, '&#10;')"/>
                <br/>
                <xsl:call-template name="replace-line-breaks">
                    <xsl:with-param name="text" select="substring-after($text, '&#10;')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template pour remplacer les emojis dans le texte -->
    <xsl:template name="replace-emojis">
        <xsl:param name="text"/>
        <xsl:choose>
            <!-- 😊 Smiling face -->
            <xsl:when test="contains($text, '😊')">
                <xsl:value-of select="substring-before($text, '😊')"/>
                <xsl:text>&#128522;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, '😊')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- ❤️ Heart -->
            <xsl:when test="contains($text, '❤️')">
                <xsl:value-of select="substring-before($text, '❤️')"/>
                <xsl:text>&#10084;&#65039;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, '❤️')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- 👍 Thumbs up -->
            <xsl:when test="contains($text, '👍')">
                <xsl:value-of select="substring-before($text, '👍')"/>
                <xsl:text>&#128077;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, '👍')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- 😜 Winking face with tongue -->
            <xsl:when test="contains($text, '😜')">
                <xsl:value-of select="substring-before($text, '😜')"/>
                <xsl:text>&#128540;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, '😜')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- 😇 Smiling face with halo -->
            <xsl:when test="contains($text, 'O:)')">
                <xsl:value-of select="substring-before($text, 'O:)')"/>
                <xsl:text>&#128519;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, 'O:)')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- 😁 Grinning face with smiling eyes -->
            <xsl:when test="contains($text, ':-D') or contains($text, ':D')">
                <xsl:value-of select="substring-before($text, ':-D')"/>
                <xsl:text>&#128513;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, ':-D')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- 😲 Astonished face -->
            <xsl:when test="contains($text, ':-o') or contains($text, ':O')">
                <xsl:value-of select="substring-before($text, ':-o')"/>
                <xsl:text>&#128562;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, ':-o')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- ☹️ Slightly frowning face -->
            <xsl:when test="contains($text, ':(') or contains($text, ':-(')">
                <xsl:value-of select="substring-before($text, ':(')"/>
                <xsl:text>&#9785;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, ':(')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- 😘 Face blowing a kiss -->
            <xsl:when test="contains($text, ':-*')">
                <xsl:value-of select="substring-before($text, ':-*')"/>
                <xsl:text>&#128536;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, ':-*')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- 😉 Winking face -->
            <xsl:when test="contains($text, ';)')">
                <xsl:value-of select="substring-before($text, ';)')"/>
                <xsl:text>&#128521;</xsl:text>
                <xsl:call-template name="replace-emojis">
                    <xsl:with-param name="text" select="substring-after($text, ';)')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- Autre texte sans emoji -->
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
