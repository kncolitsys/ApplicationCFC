<cfcomponent output="false">

	<cfsetting showdebugoutput="false"/>

	<cfset this.name = hash(getCurrentTemplatePath())>
	<cfset this.sessionmanagement = true>
	<cfset this.sessiontimeout = createTimespan(0,1,0,0)>
	<cfset this.applicationtimeout = createTimespan(1,0,0,0)>

</cfcomponent>
