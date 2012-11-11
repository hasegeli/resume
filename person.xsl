<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
 
    <xsl:template match="/person">
        <html>
            <head>
                <title><xsl:value-of select="@name"/></title>
            </head>

            <body>
                <h2><xsl:value-of select="@name"/></h2>

                <blockquote>
                    <p>
                        <a><xsl:attribute name="href">mailto:<xsl:value-of select="@mail"/></xsl:attribute>
                            <xsl:value-of select="@mail"/>
                        </a>
                    </p>
                </blockquote>

                <table border="1">
                    <tr>
                        <td>Skills</td>
                        <td>
                            <xsl:for-each select="skills">
                                <h4><xsl:value-of select="@about"/></h4>

                                <ul>
                                    <xsl:for-each select="skill">
                                        <li><xsl:value-of select="@name"/></li>
                                    </xsl:for-each>
                                </ul>
                            </xsl:for-each>
                        </td>
                    </tr>

                    <tr>
                        <td>Experience</td>
                        <td>
                            <xsl:for-each select="experience">
                                <xsl:value-of select="@time"/>
                                <h4><xsl:value-of select="company/@name"/></h4>

                                <blockquote>
                                    <p>
                                        <a><xsl:attribute name="href">http://<xsl:value-of select="company/@address"/></xsl:attribute>
                                            <xsl:value-of select="company/@address"/>
                                        </a>
                                    </p>

                                    <p><xsl:value-of select="@title"/></p>
                                </blockquote>

                                <ul>
                                    <xsl:for-each select="skill">
                                        <li><xsl:value-of select="@name"/></li>
                                    </xsl:for-each>
                                </ul>
                            </xsl:for-each>
                        </td>
                    </tr>

                    <tr>
                        <td>Education</td>
                        <td>
                            <xsl:for-each select="education">
                                <xsl:value-of select="@time"/>
                                <xsl:value-of select="@status"/>
                                <h4><xsl:value-of select="school/@name"/></h4>

                                <blockquote>
                                    <p>
                                        <a><xsl:attribute name="href">http://<xsl:value-of select="school/@address"/></xsl:attribute>
                                            <xsl:value-of select="school/@address"/>
                                        </a>
                                    </p>

                                    <h6><xsl:value-of select="school/faculty/@name"/></h6>
                                    <p><xsl:value-of select="school/faculty/@department"/></p>
                                </blockquote>

                                <xsl:for-each select="project">
                                    <h6><xsl:value-of select="@title"/></h6>
                                    <p><xsl:value-of select="organization/@name"/></p>
                                    <p>
                                        <a><xsl:attribute name="href">http://<xsl:value-of select="organization/@address"/></xsl:attribute>
                                            <xsl:value-of select="organization/@address"/>
                                        </a>
                                    </p>
                                </xsl:for-each>

                                <xsl:if test="internship">
                                    <h5>Internship</h5>

                                    <ul>
                                        <xsl:for-each select="internship">
                                            <li><xsl:value-of select="organization/@name"/></li>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:if>
                            </xsl:for-each>
                        </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

