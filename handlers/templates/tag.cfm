<:cfcomponent displayname="{displayname}" hint="{hint}" extends="{extends}" output="{output}">

	<!-- application variables -->
	<:cfset this.name = "{appname}">
	<:cfset this.sessionManagement = {sessionmanagement}>
	<:cfset this.sessionTimeout = createTimeSpan({sessiontimeout})>
	<:cfset this.applicationTimeout = createTimeSpan({applicationtimeout})>
	<:cfset this.setClientCookies = {setClientCookies}>
	<:cfset this.setDomainCookies = {setDomainCookies}>
	<:cfset this.clientStorage = {clientStorage}>
	<:cfset this.loginStorage = {loginStorage}>
	<:cfset this.scriptProtect = {scriptProtect}>
	<:cfset this.serverSideFormValidation = {serverSideFormValidation}>
	<:cfset this.secureJSON = {secureJSON}>
	<:cfset this.secureJSONPrefix = {secureJSONPrefix}>
	<:cfset this.smtpserver = {smtpserver}>
	<:cfset this.timeout = {timeout}>
	<:cfset this.debugipaddress = {debugipaddress}>
	<:cfset this.enablerobustexception = {enablerobustexception}>

	<!-- orm settings -->
	<:cfset this.datasource = {datasource}>
	<:cfset this.ormenabled = {ormenabled}>
	<:cfset this.ormsettings = {autogenmap={autogenmap},cacheconfig={cacheconfig},cacheprovider={cacheprovider},catalog={catalog},cfclocation={cfclocation},dbcreate={dbcreate},dialect={dialect},eventHandling={eventhandling},flushAtRequestEnd={flushatrequestend},logSQL={logsql},ormConfig={ormconfig},saveMapping={savemapping},schema={schema},secondaryCacheEnabled={secondarycacheenabled},usedbformapping={usedbformapping}}>

	<!-- methods -->
	<:cffunction name="onApplicationStart" access="public" returntype="boolean" output="false">
		<:cfreturn true />
	</:cffunction>

	<:cffunction name="onApplicationEnd" access="public" returntype="void" output="false">
		<:cfargument name="applicationScope" type="struct" required="false" default="#structNew()#"/>
		<:cfreturn true />
	</:cffunction>

	<:cffunction name="onSessionStart" access="public" returntype="void" output="false">
	</:cffunction>

	<:cffunction name="onSessionEnd" access="public" returntype="void" output="false">
		<:cfargument name="sessionScope" type="struct" required="true">
		<:cfargument name="applicationScope" type="struct" required="false" default="#StructNew()#"/>
	</:cffunction>

	<:cffunction name="onRequest" access="public" returntype="void" output="true">
		<:cfargument name="targetPage" type="string" required="true"/>
		<!-- include the requested page. -->
		<:cfinclude template="#arguments.TargetPage#" />
	</:cffunction>

	<:cffunction name="onRequestStart" access="public" returnType="boolean" output="false">
	    <:cfargument type="String" name="targetPage" required="true"/>
	    <:cfreturn true>
	</:cffunction>

	<:cffunction name="onRequestEnd" access="public" returntype="void" output="true">
	</:cffunction>

	<:cffunction name="onError" access="public" returntype="void" output="true">
		<:cfargument name="exception" type="any" required="true"/>
		<:cfargument name="eventName" type="string" required="false" default=""/>
	</:cffunction>

	<:cffunction name="onMissingTemplate" access="public" returnType="boolean" output="false">
   		<:cfargument type="string" name="targetPage" required=true/>
		<:cfreturn true/>
	</:cffunction>

</:cfcomponent>
