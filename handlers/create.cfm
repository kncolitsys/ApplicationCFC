<cfsetting showdebugoutput="false"/>
<cfparam name="IDEEventInfo">

<cfset eventParser = createObject("component","org.colitsys.cfbuilder.EventInfoParser").init()>
<cfset adobeUtil = createObject("component","com.adobe.util")>
<cfset application.eventInfo = eventParser.parseEventInfo(ideEventInfo)>
<cfset application.project = application.eventInfo.project>

<cfheader name="Content-Type" value="text/xml">
<cfoutput>
	<response showresponse="true">
		<ide url="#adobeUtil.generateURL('wizard.cfm')#">
			<dialog width="800" height="600" />
		</ide>
	</response>
</cfoutput>
