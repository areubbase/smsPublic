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
                                        <span class="character">Kevin (<xsl:value-of select="string(@readable_date)"/>) :</span>
                                        <span class="message">
                                            <xsl:call-template name="process-message">
                                                <xsl:with-param name="text" select="string(@body)"/>
                                            </xsl:call-template>
                                        </span>
                                    </div>
                                </xsl:when>
                                <xsl:when test="@type = 1">
                                    <div class="received">
                                        <span class="character">
                                            <xsl:value-of select="string(@contact_name)"/> 
                                            (<xsl:value-of select="string(@readable_date)"/>) :
                                        </span>
                                        <span class="message">
                                            <xsl:call-template name="process-message">
                                                <xsl:with-param name="text" select="string(@body)"/>
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

    <xsl:template name="process-message">
        <xsl:param name="text" />
        <xsl:variable name="converted-text">
            <xsl:choose>
                <xsl:when test="contains($text, '😊')">
                    <xsl:value-of select="string(substring-before($text, '😊'))"/>
                    <xsl:text>128522; </xsl:text>
                    <xsl:value-of select="string(substring-after($text, '😊'))"/>
                </xsl:when>
                <xsl:when test="contains($text, '❤️')">
                    <xsl:value-of select="string(substring-before($text, '❤️'))"/>
                    <xsl:text>❤️</xsl:text> <!-- Heart emoji -->
                    <xsl:value-of select="string(substring-after($text, '❤️'))"/>
                </xsl:when>
                <xsl:when test="contains($text, '👍')">
                    <xsl:value-of select="string(substring-before($text, '👍'))"/>
                    <xsl:text>128077; </xsl:text>
                    <xsl:value-of select="string(substring-after($text, '👍'))"/>
                </xsl:when>
                <xsl:when test="contains($text, 'O:)')">
                    <xsl:value-of select="string(substring-before($text, 'O:)'))"/>
                    <xsl:text>😇</xsl:text> <!-- Smiling face with halo -->
                    <xsl:value-of select="string(substring-after($text, 'O:)'))"/>
                </xsl:when>
                <xsl:when test="contains($text, '&lt;3')">
                    <xsl:value-of select="string(substring-before($text, '&lt;3'))"/>
                    <xsl:text>❤️</xsl:text> <!-- Heart emoji for &lt;3 -->
                    <xsl:value-of select="string(substring-after($text, '&lt;3'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':-D')">
                    <xsl:value-of select="string(substring-before($text, ':-D'))"/>
                    <xsl:text>😁</xsl:text> <!-- Grinning face with smiling eyes -->
                    <xsl:value-of select="string(substring-after($text, ':-D'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':D')">
                    <xsl:value-of select="string(substring-before($text, ':D'))"/>
                    <xsl:text>😁</xsl:text> <!-- Grinning face with smiling eyes -->
                    <xsl:value-of select="string(substring-after($text, ':D'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':O')">
                    <xsl:value-of select="string(substring-before($text, ':O'))"/>
                    <xsl:text>😲</xsl:text> <!-- Astonished face -->
                    <xsl:value-of select="string(substring-after($text, ':O'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':-o')">
                    <xsl:value-of select="string(substring-before($text, ':-o'))"/>
                    <xsl:text>😲</xsl:text> <!-- Astonished face -->
                    <xsl:value-of select="string(substring-after($text, ':-o'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':)')">
                    <xsl:value-of select="string(substring-before($text, ':)'))"/>
                    <xsl:text>😊</xsl:text> <!-- Smiling face -->
                    <xsl:value-of select="string(substring-after($text, ':)'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':-)')">
                    <xsl:value-of select="string(substring-before($text, ':-)'))"/>
                    <xsl:text>😊</xsl:text> <!-- Smiling face -->
                    <xsl:value-of select="string(substring-after($text, ':-)'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':-P')">
                    <xsl:value-of select="string(substring-before($text, ':-P'))"/>
                    <xsl:text>😜</xsl:text> <!-- Winking face with tongue -->
                    <xsl:value-of select="string(substring-after($text, ':-P'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':P')">
                    <xsl:value-of select="string(substring-before($text, ':P'))"/>
                    <xsl:text>😜</xsl:text> <!-- Winking face with tongue -->
                    <xsl:value-of select="string(substring-after($text, ':P'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':p')">
                    <xsl:value-of select="string(substring-before($text, ':p'))"/>
                    <xsl:text>😜</xsl:text> <!-- Winking face with tongue -->
                    <xsl:value-of select="string(substring-after($text, ':p'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':(')">
                    <xsl:value-of select="string(substring-before($text, ':('))"/>
                    <xsl:text>☹️</xsl:text> <!-- Slightly frowning face -->
                    <xsl:value-of select="string(substring-after($text, ':('))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':-(')">
                    <xsl:value-of select="string(substring-before($text, ':-('))"/>
                    <xsl:text>☹️</xsl:text> <!-- Slightly frowning face -->
                    <xsl:value-of select="string(substring-after($text, ':-('))"/>
                </xsl:when>
                <xsl:when test="contains($text, ':-*')">
                    <xsl:value-of select="string(substring-before($text, ':-*'))"/>
                    <xsl:text>😘</xsl:text> <!-- Face blowing a kiss -->
                    <xsl:value-of select="string(substring-after($text, ':-*'))"/>
                </xsl:when>
                <xsl:when test="contains($text, ';)')">
                    <xsl:value-of select="string(substring-before($text, ';)'))"/>
                    <xsl:text>😉</xsl:text> <!-- Winking face -->
                    <xsl:value-of select="string(substring-after($text, ';)'))"/>
                </xsl:when>
				<xsl:when test="contains($text, ':\'(')">
					<xsl:value-of select="string(substring-before($text, ':\'('))"/>
					<xsl:text>😢</xsl:text> <!-- Smiley avec une larme -->
					<xsl:value-of select="string(substring-after($text, ':\'('))"/>
				</xsl:when>
				<xsl:when test="contains($text, ':-/')">
					<xsl:value-of select="string(substring-before($text, ':-/'))"/>
					<xsl:text>😕</xsl:text> <!-- Smiley bouche en travers -->
					<xsl:value-of select="string(substring-after($text, ':-/'))"/>
				</xsl:when>
				<xsl:when test="contains($text, ':/')">
					<xsl:value-of select="string(substring-before($text, ':/'))"/>
					<xsl:text>😕</xsl:text> <!-- Smiley bouche en travers -->
					<xsl:value-of select="string(substring-after($text, ':/'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56332;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56332;'))"/>
					<xsl:text>🐌</xsl:text> <!-- Smiley Snail -->
					<xsl:value-of select="string(substring-after($text, '55357; 56332;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56832;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56832;'))"/>
					<xsl:text>😀</xsl:text> <!-- Smiley Grinning Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56832;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56833;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56833;'))"/>
					<xsl:text>😁</xsl:text> <!-- Smiley qui sourit en montrant ses dents -->
					<xsl:value-of select="string(substring-after($text, '55357; 56833;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56836;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56836;'))"/>
					<xsl:text>😊</xsl:text> <!-- Smiley Smiling Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56836;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56841;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56841;'))"/>
					<xsl:text>😉</xsl:text> <!-- Smiley clin d'œil -->
					<xsl:value-of select="string(substring-after($text, '55357; 56841;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56843;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56843;'))"/>
					<xsl:text>😋</xsl:text> <!-- Smiley Face Savouring Delicious Food -->
					<xsl:value-of select="string(substring-after($text, '55357; 56843;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56845;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56845;'))"/>
					<xsl:text>😍</xsl:text> <!-- Smiley Smiling Face with Heart-Eyes -->
					<xsl:value-of select="string(substring-after($text, '55357; 56845;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56448;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56448;'))"/>
					<xsl:text>💀</xsl:text> <!-- Smiley Skull -->
					<xsl:value-of select="string(substring-after($text, '55357; 56448;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56853;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56853;'))"/>
					<xsl:text>😕</xsl:text> <!-- Smiley Confused Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56853;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56855;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56855;'))"/>
					<xsl:text>😘</xsl:text> <!-- Smiley Kissing Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56855;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56856;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56856;'))"/>
					<xsl:text>😗</xsl:text> <!-- Smiley Face Blowing A Kiss -->
					<xsl:value-of select="string(substring-after($text, '55357; 56856;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56859;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56859;'))"/>
					<xsl:text>😝</xsl:text> <!-- Smiley Face with Stuck-Out Tongue -->
					<xsl:value-of select="string(substring-after($text, '55357; 56859;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56860;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56860;'))"/>
					<xsl:text>😜</xsl:text> <!-- Smiley Face with Stuck-Out Tongue and Winking Eye -->
					<xsl:value-of select="string(substring-after($text, '55357; 56860;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56365;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56365;'))"/>
					<xsl:text>🐭</xsl:text> <!-- Smiley Mouse Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56365;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56867;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56867;'))"/>
					<xsl:text>😓</xsl:text> <!-- Smiley Persevering Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56867;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56868;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56868;'))"/>
					<xsl:text>😤</xsl:text> <!-- Smiley Face with Steam from Nose -->
					<xsl:value-of select="string(substring-after($text, '55357; 56868;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56469;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56469;'))"/>
					<xsl:text>💕</xsl:text> <!-- Smiley Two Hearts -->
					<xsl:value-of select="string(substring-after($text, '55357; 56469;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56376;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56376;'))"/>
					<xsl:text>🐸</xsl:text> <!-- Smiley Frog Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56376;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56380;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56380;'))"/>
					<xsl:text>🐼</xsl:text> <!-- Smiley Panda Face -->
					<xsl:value-of select="string(substring-after($text, '55357; 56380;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 57020;')">
					<xsl:value-of select="string(substring-before($text, '55357; 57020;'))"/>
					<xsl:text>👶</xsl:text> <!-- Smiley Baby Symbol -->
					<xsl:value-of select="string(substring-after($text, '55357; 57020;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56890;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56890;'))"/>
					<xsl:text>😺</xsl:text> <!-- Smiley Smiling Cat Face with Open Mouth -->
					<xsl:value-of select="string(substring-after($text, '55357; 56890;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, '55357; 56396;')">
					<xsl:value-of select="string(substring-before($text, '55357; 56396;'))"/>
					<xsl:text>👌</xsl:text> <!-- Smiley OK Hand -->
					<xsl:value-of select="string(substring-after($text, '55357; 56396;'))"/>
				</xsl:when>
				<xsl:when test="contains($text, ':-*')">
					<xsl:value-of select="string(substring-before($text, ':-*'))"/>
					<xsl:text>😘</xsl:text> <!-- Smiley Kissing Face -->
					<xsl:value-of select="string(substring-after($text, ':-*'))"/>
				</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$text"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Remplacer les "10;" par des sauts de ligne -->
        <xsl:variable name="final-text" select="translate($converted-text, '10;', '&#xA;')"/>
        <xsl:value-of select="$final-text"/>
    </xsl:template>

</xsl:stylesheet>
