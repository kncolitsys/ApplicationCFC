/**
 * @displayname {displayname}
 * @hint {hint}
 * @extends {extends}
 * @output {output}
 */
:component {

	// application variables
	this.name = "{appname}";
	this.sessionManagement = {sessionManagement};
	this.sessionTimeout = createTimeSpan({sessiontimeout});
	this.applicationTimeout = createTimeSpan({applicationtimeout});
	this.setClientCookies = {setClientCookies};
	this.setDomainCookies = {setDomainCookies};
	this.clientStorage = {clientStorage};
	this.loginStorage = {loginStorage};
	this.scriptProtect = {scriptProtect};
	this.serverSideFormValidation = {serverSideFormValidation};
	this.secureJSON = {secureJSON};
	this.secureJSONPrefix = {secureJSONPrefix};
	this.smtpserver = {smtpserver};
	this.timeout = {timeout};
	this.debugipaddress = {debugipaddress};
	this.enablerobustexception = {enablerobustexception};

	// orm settings
	this.datasource = {datasource};
	this.ormenabled = {ormenabled};
	this.ormsettings = {autogenmap={autogenmap},cacheconfig={cacheconfig},cacheprovider={cacheprovider},catalog={catalog},cfclocation={cfclocation},dbcreate={dbcreate},dialect={dialect},eventHandling={eventhandling},flushAtRequestEnd={flushatrequestend},logSQL={logsql},ormConfig={ormconfig},saveMapping={savemapping},schema={schema},secondaryCacheEnabled={secondarycacheenabled},useDBForMapping={usedbformapping}};

	// methods
	public boolean function onApplicationStart(){
		return true;
	}

	public void function onApplicationEnd(struct applicationScope={}){

	}

	public void function onSessionStart(){

	}

	public void function onSessionEnd(Struct sessionScope={},Struct applicationScope={}){

	}

	public void function onRequest(String targetPage){

	}

	public boolean onRequestStart(String targetPage){
		include(targetPage);
		return true;
	}

	public void onRequestEnd(){

	}

	public void function onError(Any exception,String eventName=""){

	}

	public boolean function onMissingTemplate(String targetPage){

	}
}
