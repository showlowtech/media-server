<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes"/>

		<xsl:param name="PARTNER_ID" />



	<xsl:template match="node()|@*">
			<xsl:copy>
						<xsl:apply-templates select="node()|@*"/>
								</xsl:copy>
									</xsl:template>
									<!-- Application.xml -->
	<xsl:template match="/Root/Application/Transcoder/Templates">
		  <xsl:variable name="url">
		        http://www.kaltura.com/api_v3/index.php/service/wowza_liveConversionProfile/action/serve/partnerId/<xsl:value-of select="$PARTNER_ID"/>/streamName/${SourceStreamName}/f/transcode.xml
		            </xsl:variable>
		                <Templates>
		                      <xsl:value-of select="$url"/>
		                          </Templates>
		                            </xsl:template>
		                            </xsl:stylesheet>
