<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>SMS Messages</title>
            </head>
            <body>
                <h1>SMS Messages</h1>
                <xsl:for-each select="/smses/sms">
                    <div>
                        <h2>Contact: <xsl:value-of select="@contact_name"/></h2>
                        <p>Address: <xsl:value-of select="@address"/></p>
                        <p>Date: <xsl:value-of select="@readable_date"/></p>
                        <p>Message: <xsl:value-of select="@body"/></p>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>