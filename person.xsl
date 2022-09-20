<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
 
    <xsl:param name="current-year" select="2022"/>

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

                    <h3>Education</h3>

                    <blockquote>
                        <xsl:for-each select="education">
                            <p class="time"><xsl:value-of select="@time"/></p>
                            <p><xsl:value-of select="@department"/></p>
                            <xsl:apply-templates select="organization"/>

                            <xsl:if test="internship">
                                <p>Internships:</p>
                                <blockquote><xsl:apply-templates select="internship"/></blockquote>
                            </xsl:if>

                            <xsl:if test="project">
                                <p>Projects:</p>
                                <blockquote><xsl:apply-templates select="project"/></blockquote>
                            </xsl:if>
                        </xsl:for-each>
                    </blockquote>

                    <h3>Experience</h3>

                    <blockquote>
                        <xsl:for-each select="experience">
                            <p class="time"><xsl:value-of select="@time"/></p>
                            <p><xsl:value-of select="@title"/></p>
                            <xsl:apply-templates select="organization"/>

                            <ul>
                                <xsl:for-each select="accomplishment">
                                    <li><xsl:value-of select="@description"/></li>
                                </xsl:for-each>
                            </ul>

                            <xsl:if test="project">
                                <p>Projects:</p>
                                <blockquote><xsl:apply-templates select="project"/></blockquote>
                            </xsl:if>
                        </xsl:for-each>
                    </blockquote>

                    <xsl:for-each select="knowledge">
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

                            <xsl:if test="certificate">
                                <h4>Certificates</h4>
                                <blockquote><xsl:apply-templates select="certificate"/></blockquote>
                            </xsl:if>

                            <xsl:if test="contribution">
                                <h4>Contributions</h4>
                                <blockquote><xsl:apply-templates select="contribution"/></blockquote>
                            </xsl:if>
                        </blockquote>
                    </xsl:for-each>

                    <h3>Participated Events</h3>
                    <blockquote><xsl:apply-templates select="participation"/></blockquote>
                </blockquote>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="certificate | internship | job | member">
        <p class="time"><xsl:value-of select="@time"/></p>

        <xsl:if test="@title">
            <p><xsl:value-of select="@title"/></p>
        </xsl:if>

        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="talk">
        <blockquote>
            <p>Given talk: <i><xsl:value-of select="@description"/></i></p>

            <xsl:if test="@slides">
                <blockquote>
                    <p>
                        <a>
                            <xsl:attribute name="href"><xsl:value-of select="@slides"/></xsl:attribute>
                            Slides
                        </a>
                    </p>
                </blockquote>
            </xsl:if>
        </blockquote>
    </xsl:template>

    <xsl:template match="contribution">
        <p><i> <xsl:value-of select="@product"/>: </i> <xsl:value-of select="@description"/></p>

        <blockquote>
            <p>
                <a>
                    <xsl:attribute name="href">http://<xsl:value-of select="@address"/></xsl:attribute>
                    <xsl:value-of select="@address"/>
                </a>
            </p>
        </blockquote>
    </xsl:template>

    <xsl:template match="event | organization | project">
        <h5><xsl:value-of select="@name"/></h5>

        <blockquote>
            <xsl:if test="@location">
                <p class="location">
                    <xsl:value-of select="@location"/>
                    <xsl:if test="@remote"> (remote)</xsl:if>
                </p>
            </xsl:if>

            <p><xsl:value-of select="@description"/></p>

            <p>
                <a>
                    <xsl:attribute name="href">http://<xsl:value-of select="@address"/></xsl:attribute>
                    <xsl:value-of select="@address"/>
                </a>
            </p>
        </blockquote>
    </xsl:template>
</xsl:stylesheet>
