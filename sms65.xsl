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
                                            <xsl:call-template name="convert-emojis">
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
                                            <xsl:call-template name="convert-emojis">
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

    <!-- Template for converting emojis and "10;" to UTF-16 decimal codes and line breaks -->
    <xsl:template name="convert-emojis">
        <xsl:param name="text" />
        <xsl:variable name="new-text">
            <xsl:choose>
                <xsl:when test="contains($text, '😊')">
                    <xsl:value-of select="substring-before($text, '😊')"/>
                    <xsl:text>128522; </xsl:text>
                    <xsl:value-of select="substring-after($text, '😊')"/>
                </xsl:when>
                <xsl:when test="contains($text, '❤️')">
                    <xsl:value-of select="substring-before($text, '❤️')"/>
                    <xsl:text>10084; </xsl:text>
                    <xsl:value-of select="substring-after($text, '❤️')"/>
                </xsl:when>
                <xsl:when test="contains($text, '👍')">
                    <xsl:value-of select="substring-before($text, '👍')"/>
                    <xsl:text>128077; </xsl:text>
                    <xsl:value-of select="substring-after($text, '👍')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$text"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- Replace "10;" with newline -->
        <xsl:variable name="final-text">
            <xsl:choose>
                <xsl:when test="contains($new-text, '10;')">
                    <xsl:value-of select="substring-before($new-text, '10;')"/>
                    <xsl:text>&#xA;</xsl:text>
                    <xsl:value-of select="substring-after($new-text, '10;')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$new-text"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:value-of select="$final-text"/>
    </xsl:template>

</xsl:stylesheet>
