<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
 
    <xsl:param name="current-year" select="2018"/>

    <xsl:template match="/person">
        <html>
            <head>
                <title><xsl:value-of select="@name"/></title>
                <link rel="stylesheet" type="text/css" href="common.css"/>
            </head>

            <body>
                <h2><xsl:value-of select="@name"/></h2>

                <blockquote>
                    <p>
                        <a>
                            <xsl:attribute name="href">mailto:<xsl:value-of select="@mail"/></xsl:attribute>
                            <xsl:value-of select="@mail"/>
                        </a>
                    </p>

                    <xsl:apply-templates/>
                </blockquote>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="education">
        <h3>Education</h3>

        <blockquote>
            <xsl:for-each select="school">
                <p class="time"><xsl:value-of select="@time"/></p>
                <p><xsl:value-of select="@department"/></p>
                <h5><xsl:value-of select="@name"/></h5>

                <blockquote>
                    <p class="location"><xsl:value-of select="@location"/></p>

                    <p>
                        <a>
                            <xsl:attribute name="href">http://<xsl:value-of select="@address"/></xsl:attribute>
                            <xsl:value-of select="@address"/>
                        </a>
                    </p>

                    <xsl:if test="internship">
                        <p>Internships:</p>

                        <blockquote>
                            <xsl:for-each select="internship">
                                <p><xsl:value-of select="@title"/></p>
                                <xsl:apply-templates/>
                            </xsl:for-each>
                        </blockquote>
                    </xsl:if>
                </blockquote>
            </xsl:for-each>
        </blockquote>
    </xsl:template>

    <xsl:template match="experience">
        <h3>Experience</h3>

        <blockquote>
            <xsl:for-each select="job">
                <p class="time"><xsl:value-of select="@time"/></p>
                <p><xsl:value-of select="@title"/></p>
                <blockquote><xsl:apply-templates/></blockquote>
            </xsl:for-each>
        </blockquote>
    </xsl:template>

    <xsl:template match="knowledge">
        <h3><xsl:value-of select="@about"/></h3>

        <blockquote>
            <table>
                <tr>
                    <th></th>
                    <xsl:for-each select="item[1]/usage"><th><xsl:value-of select="@name"/></th></xsl:for-each>
                    <th>Experience</th>
                </tr>

                <xsl:for-each select="item">
                    <tr>
                        <td><xsl:value-of select="@name"/></td>
                        <xsl:for-each select="usage"><td><xsl:value-of select="@level"/></td></xsl:for-each>

                        <xsl:variable name="year">
                            <xsl:choose>
                                <xsl:when test="@end-year">
                                    <xsl:value-of select="@end-year - @start-year + 1"/>
                                </xsl:when>

                                <xsl:otherwise>
                                    <xsl:value-of select="$current-year - @start-year + 1"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>

                        <td><xsl:value-of select="$year"/> year<xsl:if test="$year > 1">s </xsl:if></td>
                    </tr>
                </xsl:for-each>
            </table>

            <xsl:if test="license">
                <h4>Licenses</h4>

                <ul>
                    <xsl:for-each select="license">
                        <li><xsl:value-of select="@name"/></li>
                    </xsl:for-each>
                </ul>
            </xsl:if>

            <xsl:if test="course">
                <h4>Courses:</h4>

                <blockquote>
                    <xsl:for-each select="course">
                        <p><xsl:value-of select="@name"/></p>
                        <xsl:apply-templates/>
                    </xsl:for-each>
                </blockquote>
            </xsl:if>

            <xsl:if test="contribution">
                <h4>Contributions</h4>

                <blockquote>
                    <xsl:for-each select="contribution">
                        <p><i> <xsl:value-of select="@product"/>: </i> <xsl:value-of select="@description"/></p>

                        <blockquote>
                            <p>
                                <a>
                                    <xsl:attribute name="href">http://<xsl:value-of select="@address"/></xsl:attribute>
                                    <xsl:value-of select="@address"/>
                                </a>
                            </p>
                        </blockquote>
                    </xsl:for-each>
                </blockquote>
            </xsl:if>
        </blockquote>
    </xsl:template>

    <xsl:template match="project">
        <h5><xsl:value-of select="@name"/></h5>

        <blockquote>
            <p><xsl:value-of select="@description"/></p>

            <p>
                <a>
                    <xsl:attribute name="href">http://<xsl:value-of select="@address"/></xsl:attribute>
                    <xsl:value-of select="@address"/>
                </a>
            </p>

            <xsl:if test="accomplishment">
                <p>Accomplishments:</p>

                <ul>
                    <xsl:for-each select="accomplishment">
                        <li><xsl:value-of select="@description"/></li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
        </blockquote>
    </xsl:template>

    <xsl:template match="organization">
        <h5><xsl:value-of select="@name"/></h5>

        <blockquote>
            <p class="location"><xsl:value-of select="@location"/></p>
            <p><xsl:value-of select="@description"/></p>

            <p>
                <a>
                    <xsl:attribute name="href">http://<xsl:value-of select="@address"/></xsl:attribute>
                    <xsl:value-of select="@address"/>
                </a>
            </p>
        </blockquote>
    </xsl:template>

    <xsl:template match="voluntariness">
        <h3>Voluntarines</h3>

        <blockquote>
            <xsl:for-each select="member">
                <p class="time"><xsl:value-of select="@time"/></p>
                <blockquote><xsl:apply-templates/></blockquote>
            </xsl:for-each>
        </blockquote>
    </xsl:template>
</xsl:stylesheet>
