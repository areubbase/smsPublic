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
                    }
                    .received {
                        color: pink;
                        text-align: left;
                    }
                </style>
            </head>
            <body>
                <h2>SMS Messages</h2>
					<div class="dialogue">
						<xsl:choose>
							<xsl:when test="@type = 2">
								<div class="sent">
									<span class="character">Kevin (<xsl:value-of select="@readable_date"/>) :</span>
									<span class="message">
										<xsl:value-of select="@body"/>
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
										<xsl:value-of select="@body"/>
									</span>
								</div>
							</xsl:when>
						</xsl:choose>
					</div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
