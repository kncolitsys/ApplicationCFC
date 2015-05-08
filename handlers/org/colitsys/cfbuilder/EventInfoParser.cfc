<cfcomponent output="false">

	<cffunction name="init" access="public" output="false" returntype="EventInfoParser">
		<cfreturn this>
	</cffunction>

	<cffunction name="parseEventInfo" access="public" output="false" returntype="struct">
		<cfargument name="eventInfo" type="xml" required="true">
		<cfset var result = structNew()>
		<cfset result.project = parseProjectInfo(arguments.eventInfo)>
		<cfreturn result>
	</cffunction>


	<cffunction name="parseProjectInfo" access="private" output="false" returntype="struct">
		<cfargument name="eventInfo" type="xml" required="true">
		<cfset var projectViewNode = xmlsearch(eventInfo,"/event/ide/projectview")>
		<cfset var project = structNew()>
		<cfset var project.resource = structNew()>
		<cfset var resources = "">

		<cfset project.name = projectViewNode[1].XMLAttributes.projectname>
		<cfset project.path = projectViewNode[1].XMLAttributes.projectlocation>
		<cfset resources = projectViewNode[1].resource>
		<cfset project.resource.path = resources[1].XMLAttributes.path>
		<cfset project.resource.type = resources[1].XMLAttributes.type>

		<cfreturn project>
	</cffunction>
</cfcomponent>
