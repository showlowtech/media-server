<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes"/>


	<xsl:template match="node()|@*">
			<xsl:copy>
						<xsl:apply-templates select="node()|@*"/>
								</xsl:copy>
									</xsl:template>

 <!-- VHost.xml -->
  <xsl:template match="/Root/VHost/HostPortList/HostPort/HTTPProviders">
      <xsl:element name="HTTPProviders">
           <xsl:apply-templates select="*"/>
               <HTTPProvider>
                     <BaseClass>com.wowza.wms.http.HTTPConnectionCountsXML</BaseClass>
                           <RequestFilters>connectioncounts*</RequestFilters>
                                 <AuthenticationMethod>admin-basic</AuthenticationMethod>
                                     </HTTPProvider>
                                         </xsl:element>
                                           </xsl:template>
                                             
</xsl:stylesheet>
