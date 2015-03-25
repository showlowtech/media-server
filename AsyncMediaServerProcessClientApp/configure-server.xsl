<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes"/>

	<xsl:param name="ADMIN_SECRET" />
	<xsl:param name="async_process_location" />
	<xsl:param name="PARTNER_ID" />

	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	 <!-- 
           workaround for absent replace function in XSLT1.0.
             Caution: it is not intended for huge replacements since it is recursive!!! 
         -->
	<xsl:template name="string-replace-all">
		<xsl:param name="text" />
		<xsl:param name="replace" />
		<xsl:param name="by" />
		<xsl:choose>
			<xsl:when test="contains($text, $replace)">
				<xsl:value-of select="substring-before($text,$replace)" />
				<xsl:value-of select="$by" />
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="substring-after($text,$replace)" />
					<xsl:with-param name="replace" select="$replace" />
					<xsl:with-param name="by" select="$by" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Server.xml -->
	<xsl:template match="/Root/Server/Properties">
		<xsl:element name="Properties">
    			<xsl:for-each select="Property">
    				<Property>
					<Name>
						<xsl:value-of select="Name"/>
					</Name>
				<xsl:choose>
					<xsl:when test=" Name = 'KalturaServerManagers' ">
						<xsl:variable name="result" >
							<xsl:call-template name="string-replace-all">
								<xsl:with-param name="text" select="Value" />
								<xsl:with-param name="replace" select="'com.kaltura.media.server.wowza.StatusManager,'" />
								<xsl:with-param name="by" select="' '" />
							</xsl:call-template>
						</xsl:variable>
							<Value>
								<xsl:value-of select="$result" />
							</Value>
					</xsl:when>
					<xsl:when test="Name = 'KalturaServerAdminSecret' ">
						 <Value>
					              <xsl:value-of select="$ADMIN_SECRET"/>
				                 </Value>
					</xsl:when>
					<xsl:when test="Name = 'KalturaIsLiveRegistrationMinBufferTime' ">
						 <Value>60</Value>
					</xsl:when>
					<xsl:when test="Name = 'KalturaLiveStreamMaxDvrWindow' ">
						<Value>86400</Value>
					</xsl:when>
					<xsl:when test="Name = 'KalturaPartnerId' ">
						 <Value>   
						         <xsl:value-of select="$PARTNER_ID"/>
						 </Value>
					         <Type>Integer</Type>
					 </xsl:when>
					<xsl:when test="Name = 'uploadXMLSavePath' ">
					        <Value>
							<xsl:value-of select="$async_process_location"/>
						</Value>
					</xsl:when>
					<xsl:otherwise>
						<Value>
							<xsl:value-of select="Value" />
						</Value>
					</xsl:otherwise>
				</xsl:choose>
					</Property>
			</xsl:for-each>
		      <xsl:if test="Property/Name != 'KalturaPartnerId'">
              			<Property>
                        		<Name>KalturaPartnerId</Name>
                                  	<Value>
                                              <xsl:value-of select="$PARTNER_ID"/>
                                        </Value>
                                        <Type>Integer</Type>
                                </Property>
                       </xsl:if>
		      <xsl:if test="Property/Name != 'KalturaWorkMode'">
       				   <Property>
			                <Name>KalturaWorkMode</Name>
                  			 <Value>remote</Value>
	                          </Property>
                      </xsl:if>
			<xsl:if test="Property/Name != 'uploadXMLSavePath'">
			          <Property>
		        	        <Name>uploadXMLSavePath</Name>
                	      		<Value>
        	                   		 <xsl:value-of select="$async_process_location"/>
	                                 </Value>
                                   </Property>
                        </xsl:if>
                 </xsl:element>
	</xsl:template>
</xsl:stylesheet>
