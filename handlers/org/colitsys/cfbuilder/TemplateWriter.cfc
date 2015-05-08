<cfcomponent output="false">

	<cffunction name="writeTemplate" access="public" returntype="void" output="false">
		<cfargument name="destination" type="string" required="true" />
		<cfargument name="template" type="string" required="true" />
		<cfargument name="input" type="struct" required="true" />
		<cfargument name="syntax" type="string" required="true" hint="Tag|Script"/>
		<cfset var file = "" />

		<cfswitch expression="#arguments.syntax#">
			<cfcase value="tag">
				<cfset tw = createObject("component","TagWriter").init()>
				<cfset file = tw.writeTemplate(arguments.destination,arguments.template,arguments.input)>
			</cfcase>
			<cfcase value="script">
				<cfset tw = createObject("component","ScriptWriter").init()>
				<cfset file = tw.writeTemplate(arguments.destination,arguments.template,arguments.input)>
			</cfcase>
		</cfswitch>

		<!---- write to disk --->
		<cffile action="write" output="#file#" file="#arguments.destination#" fixnewline="yes" />

	</cffunction>

</cfcomponent>
