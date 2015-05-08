<cfsetting showdebugoutput="false"/>
<cfif structKeyExists(form,"submit")>

	<cfset templateWriter = createObject("component","org.colitsys.cfbuilder.TemplateWriter")>
	<cfset templateWriter.writeTemplate(form.savetoLocation & "/Application.cfc","#expandPath('templates/#form.syntax_type#.cfm')#",form,form.syntax_type)>
	<cffile action="read" file="#form.savetoLocation#/Application.cfc" variable="generatedFile"/>

</cfif>

<cfif isDefined("generatedFile")>
	<cfset coldfish = createObject("component","org.delmore.coldfish").init()/>
	<cfset coldfish.setStyle("cfcomment","color:gray;background-color:white")/>
	<div class="code"><cfoutput>#coldfish.formatString(generatedFile)#</cfoutput></div>
<cfelse>
<html>
<head>
	<title>Application CFC Generator</title>

	<link href="../css/jquery-ui/excite-bike/jquery-ui.css" type="text/css" rel="stylesheet">
	<link href="../css/style.css" type="text/css" rel="stylesheet">

	<script type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
	<script type="text/javascript" src="../js/jquery-ui-1.7.2.min.js"></script>
	<script type="text/javascript" src="../js/jquery.simpletip-1.3.1.min.js"></script>

	<script>
	$(document).ready(function(){
		$("#tabs").tabs();
		$("#btnUseHash").click(useHash);

		$(".help").click(function(){
			var helpcontent = $(this).attr("title");
			var title = helpcontent.split("|")[0];
			var content = helpcontent.split("|")[1];
			$("#help-dialog").html(content);
			$("#help-dialog").dialog({
				width:400,
				title:title,
				modal:true,
				close:function(ev, ui){$(this).dialog("destroy");}
			});
		});

	});
	function useHash(){
		$("#appname").val("#hash(getCurrentTemplatePath())#");
	}
	</script>

	<style>
	</style>
</head>

<body>

	<div id="help-dialog" style="display:none;"></div>

	<form id="appcfcform" method="post">
	<input type="hidden" name="savetoLocation" value="<cfoutput>#application.project.resource.path#</cfoutput>"/>

	<div id="tabs">

		<ul>
			<li><a href="#settings">Component Settings</a></li>
			<li><a href="#application">Application Variables</a></li>
			<li><a href="#orm">ORM Settings</a></li>
			<!---<li><a href="#mappings">Mappings</a></li>--->
			<li><a href="#methods">Methods</a></li>
		</ul>

		<div id="settings">
			<p>
				<label for="syntax_type">Syntax Type</label>
				<input type="radio" id="syntax_type" name="syntax_type" value="tag" checked> Tag Based
				<input type="radio" id="syntax_type" name="syntax_type" value="script"> Script Based
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Syntax Type|The type of syntax that the component will be written in.">
			</p>
			<p>
				<label for="extends">Extends</label>
				<input type="text" id="extends" name="extends" class="text-large" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Extends|Name of parent component from which to inherit methods and properties. You can use the keyword component to specify the default value. ">
			</p>
			<p>
				<label for="name">Display Name</label>
				<input type="text" id="displayname" name="displayname" class="text-large" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Display Name|A string that displays when you use introspection to show information about the CFC. The information appears on the heading, following the component name.">
			</p>
			<p>
				<label for="hint">hint</label>
				<input type="text" id="hint" name="hint" class="text-large" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Hint|Text that displays when you use introspection to show information about the CFC. The hint attribute value appears below the component name heading. Use this attribute to describe the purpose of the parameter.">
			</p>
			<p>
				<label for="output">Output</label>
				<select id="output" name="output">
					<option value="false">False</option>
					<option value="true">True</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Output|Specifies whether constructor code in the component can generate HTML output; does not affect output in the body of cffunction tags in the component.">
			</p>

		</div>

		<div id="application">
			<p>
				<label for="appname">Application Name</label>
				<input type="text" id="appname" name="appname" class="text-large" value="" />
				<input type="button" id="btnUseHash" value="Use Hash"/>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Application Name|The application name. If you do not set this variable, or set it to the empty string, your CFC applies to the unnamed application scope, which is the ColdFusion J2EE servlet context. For more information on unnamed scopes see Integrating JSP and servlets in a ColdFusion application in the ColdFusion Developer’s Guide.">
			</p>
			<p>
				<label for="sessionManagement">Session Management</label>
				<select id="sessionManagement" name="sessionManagement" class="text">
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Session Management|Whether the application supports Session scope variables.">
			</p>
			<p>
				<label for="sessionTimeout">Session Timeout</label>
				<input type="text" id="sessionTimeout" name="sessionTimeout" class="text-small" value="0,0,30,0" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Session Timeout|Life span, as a real number of days, of the user session, including all Session variables. Use the CFML CreateTimeSpan function to generate this variable’s value.">
				<em>days,hours,minutes,seconds</em>
			</p>
			<p>
				<label for="applicationTimeout">Application Timeout</label>
				<input type="text" id="applicationTimeout" name="applicationTimeout" class="text-small" value="0,1,0,0" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="">
				<em>days,hours,minutes,seconds</em>
			</p>
			<p>
				<label for="setClientCookies">Set Client Cookies</label>
				<select id="setClientCookies" name="setClientCookies">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Set Client Cookies|Whether to send CFID and CFTOKEN cookies to the client browser.">
			</p>
			<p>
				<label for="setDomainCookies">Set Domain Cookies</label>
				<select id="setDomainCookies" name="setDomainCookies">
					<option value="">Default Setting</option>
					<option value="false">false</option>
					<option value="true">true</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Set Domain Cookies|Whether to set CFID and CFTOKEN cookies for a domain (not just a host).">
			</p>
			<p>
				<label for="clientStorage">Client Storage</label>
				<select id="clientStorage" name="clientStorage" class="text">
					<option value="">Default Setting</option>
					<option value="cookie">Cookie</option>
					<option value="registry">Registry</option>
					<option value="database">Database</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Client Storage|Where Client variables are stored; can be cookie, registry, or the name of a data source.">
			</p>
			<p>
				<label for="loginStorage">Login Storage</label>
				<select id="loginStorage" name="loginStorage" class="text">
					<option value="">Default Setting</option>
					<option value="cookie">cookie</option>
					<option value="session">session</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Login Storage|Whether to store login information in the Cookie scope or the Session scope.">
			</p>
			<p>
				<label for="scriptProtect">Script Protect</label>
				<select id="scriptProtect" name="scriptProtect" class="text">
					<option value="">Default Setting</option>
					<option value="true">True</option>
					<option value="false">False</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Script Protect|Whether to protect variables from cross-site scripting attacks.">
			</p>
			<p>
				<label for="serverSideFormValidation">Server Side Form Validation</label>
				<select id="serverSideFormValidation" name="serverSideFormValidation" class="text">
					<option value="">Default Setting</option>
					<option value="true">True</option>
					<option value="false">False</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Server Side Form Validation|Whether to enable validation on cfform fields when the form is submitted.">
			</p>
			<p>
				<label for="secureJSON">Secure JSON</label>
				<select id="secureJSON" name="secureJSON" class="text">
					<option value="">Default Setting</option>
					<option value="true">True</option>
					<option value="false">False</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Secure JSON|A Boolean value that specifies whether to add a security prefix in front of the value that a ColdFusion function returns in JSON-format in response to a remote call. ">
			</p>
			<p>
				<label for="secureJSONPrefix">Secure JSON Prefix</label>
				<input type="text" id="secureJSONPrefix" name="secureJSONPrefix" class="text-small" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Secure JSON Prefix|The security prefix to put in front of the value that a ColdFusion function returns in JSON-format in response to a remote call if the secureJSON setting is true. The default value is the value of the Prefix serialized JSON setting in the Administrator Server Settings > Settings page (which defaults to //, the JavaScript comment character).">
			</p>
			<p>
				<label for="smtpserver">SMTP Server</label>
				<input type="text" id="smtpserver" name="smtpserver" class="text-large" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="SMTP Server|Overrides the default administrator settings for SMTP server.">
			</p>
			<p>
				<label for="timeout">Timeout</label>
				<input type="text" id="timeout" name="timeout" class="text-small" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Timeout|Overrides the value for the cfsettings option and the default administrator setting for timeout.">
			</p>
			<p>
				<label for="debugipaddress">Debug IP Address</label>
				<input type="text" id="debugipaddress" name="debugipaddress" class="text-xlarge" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Debug IP Address|A list of ip addresses that need debugging.">
			</p>
			<p>
				<label for="enablerobustexception">Enable Robust Exception</label>
				<input type="text" id="enablerobustexception" name="enablerobustexception" class="text-xlarge" value="" />
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Enable Robust Exception|Overrides the default administrator settings. It does not report compile time exceptions.">
			</p>
		</div>

		<div id="orm">
			<p>
				<label for="datasource">Datasource</label>
				<input type="text" id="datasource" name="datasource" class="text-large"/>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Datasource|Defines the datasource that should be used by ORM.">
			</p>
			<p>
				<label for="ormenabled">ORM Enabled</label>
				<select id="ormenabled" name="ormenabled" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="ORM Enabled|Specifies whether ORM should be used for the ColdFusion application.Set the value to true to use ORM. The default is false.">
			</p>
			<br/>

			<p><strong>ORM Settings</strong><img src="../images/help_icon_64.png" height="16" width="16" class="help" title="ORM Settings|The struct that defines all the ORM settings."></p>
			<p>
				<label for="autogenmap">Automatically Generate Mapping</label>
				<select id="autogenmap" name="autogenmap" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Automatically Generate Mapping|Specifies whether ColdFusion should automatically generate mapping for the persistent CFCs. If autogenmap=false, mapping should be provided in the form of.HBM.XML files.">
			</p>
			<p>
				<label for="cacheconfig">Cache Config</label>
				<input type="text" id="cacheconfig" name="cacheconfig" class="text-large"/>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Cache Config|Specifies the location of the configuration file that should be used by the secondary cache provider.This setting is used only when secondarycacheenabled=true.">
			</p>
			<p>
				<label for="cacheprovider">Cache Provider</label>
				<select id="cacheprovider" name="cacheprovider" class="text">
					<option value="">Default Setting</option>
					<option value="Ehcache">Ehcache</option>
					<option value="JBossCache">JBossCache</option>
					<option value="Hashtable">Hashtable</option>
					<option value="SwarmCache">SwarmCache</option>
					<option value="OSCache">OSCache</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Cache Provider|Specifies the cacheprovider that should be used by ORM as secondary cache.">
			</p>
			<p>
				<label for="catalog">Catalog</label>
				<input type="text" id="catalog" name="catalog" class="text-large"/>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Catalog|Specifies the default Catalog that should be used by ORM.">
			</p>
			<p>
				<label for="cfclocation">CFC Location</label>
				<input type="text" id="cfclocation" name="cfclocation" class="text-large"/>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="CFC Location|

Specifies the directory (or array of directories) that should be used by ColdFusion to search for persistent CFCs to generate the mapping. If cfclocation is set, ColdFusion looks at only the paths specified in it. If it is not set, ColdFusion looks at the application directory, its sub-directories, and its mapped directories to search for persistent CFCs.">
			</p>
			<p>
				<label for="dbcreate">DB Create</label>
				<select id="dbcreate" name="dbcreate" class="text">
					<option value="">Default Setting</option>
					<option value="none">none</option>
					<option value="update">update</option>
					<option value="dropcreate">dropcreate</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="DB Create|ColdFusion ORM can automatically create the tables for your application in the database at when ORM is initialized for the application. This can be enabled by using dbcreate in ormsettings. dbCreate takes the following values:<ul><li>update: Setting this value creates the table if it does not exist or update the table if it exists.</li><li>dropcreate: Setting this value drops the table if it exists and then creates it.</li><li>none (default): Setting this value does not change anything in the database schema.</li></ul>">
			</p>
			<p>
				<label for="dialect">Dialetct</label>
				<select id="dialect" name="dialect" class="text">
					<option value="">Default Setting</option>
					<option value="DB2">DB2</option>
					<option value="DB2AS400">DB2AS400</option>
					<option value="DB2OS390">DB2OS390</option>
					<option value="Derby">Derby</option>
					<option value="PostgreSQL">PostgreSQL	</option>
					<option value="MySQL">MySQL</option>
					<option value="MySQLwithInnoDB">MySQLwithInnoDB</option>
					<option value="MySQLwithMyISAM">MySQLwithMyISAM</option>
					<option value="Oracle8i">Oracle8i</option>
					<option value="Oracle9i">Oracle9i</option>
					<option value="Oracle10g">Oracle10g</option>
					<option value="Sybase">Sybase</option>
					<option value="SybaseAnywhere">SybaseAnywhere</option>
					<option value="MicrosoftSQLServer">MicrosoftSQLServer</option>
					<option value="Informix">Informix</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Dialect|Specifies the dialect. ">
			</p>
			<p>
				<label for="eventhandling">Event Handling</label>
				<select id="eventhandling" name="eventhandling" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Event Handling|Specifies whether ORM Event callbacks should be given.">
			</p>
			<p>
				<label for="flushatrequestend">Flush At Request End</label>
				<select id="flushatrequestend" name="flushatrequestend" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Flush At Request End|Specifies whether ormflush should be called automatically at request end. If flushatrequestend is false, ormflush is not called automatically at request end. ">
			</p>
			<p>
				<label for="logsql">Log SQL</label>
				<select id="logsql" name="logsql" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Log SQL|Specifies whether the SQL queries that are executed by ORM will be logged. If LogSQL=true, the SQL queries are logged to the console. ">
			</p>
			<p>
				<label for="ormconfig">ORM Config</label>
				<input type="text" id="ormconfig" name="ormconfig" class="text-large"/>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="ORM Config|The Hibernate configuration file.<br/><br/>This file contains various configuration parameters like, dialect, cache settings, and mapping files that are required for the application. For more details, see www.hibernate.org/hib_docs/reference/en/html/session-configuration.html.<br/><br/>The settings defined in the ormsettings overrides the settings defined in the Hibernate Configuration XML file.The connection information in the Hibernate Configuration XML file is however ignored because ColdFusion uses its own connection pool.<br/><br/>You will need to use this only when you need to use a hibernate setting that is not available using ormsetting.">
			</p>
			<p>
				<label for="savemapping">Save Mapping</label>
				<select id="savemapping" name="savemapping" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Save Mapping|Specifies whether the generated Hibernate mapping file has to be saved to disk. If you set the value to true, the Hibernate mapping XML file is saved with the filename "CFC name".hbm.xml in the same directory as the CFC.">
			</p>
			<p>
				<label for="schema">Schema</label>
				<input type="text" id="schema" name="schema" class="text-large"/>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Schema|Specifies the default Schema that should be used by ORM.">
			</p>
			<p>
				<label for="secondarycacheenabled">Secondary Cahce Enabled</label>
				<select id="secondarycacheenabled" name="secondarycacheenabled" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Secondary Cache Enabled|Specifies whether secondary caching should be enabled.">
			</p>
			<p>
				<label for="useDBForMapping">USE DB For Mapping</label>
				<select id="useDBForMapping" name="useDBForMapping" class="text">
					<option value="">Default Setting</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="Use DB For Mapping|Specifies whether the database has to be inspected to identify the missing information required to generate the Hibernate mapping. The database is inspected to get the column data type, primary key and foreign key information.">
			</p>
		</div>

		<!---
		<div id="mappings">
			<p>Morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. Duis scelerisque molestie turpis. Sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. Aenean aliquet fringilla sem. Suspendisse sed ligula in ligula suscipit aliquam. Praesent in eros vestibulum mi adipiscing adipiscing. Morbi facilisis. Curabitur ornare consequat nunc. Aenean vel metus. Ut posuere viverra nulla. Aliquam erat volutpat. Pellentesque convallis. Maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. Mauris consectetur tortor et purus.</p>
		</div>
		--->

		<div id="methods">

			<p>Check all of the methods you would like the extension to create for you.</p>

			<p>
				<input type="checkbox" id="onApplicationStart" name="onApplicationStart" value="true" checked="checked"> onApplicationStart
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onApplicationStart|The application first starts: the first request for a page is processed or the first CFC method is invoked by an event gateway instance, or a web services or Flash Remoting CFC. ">
			</p>
			<p>
				<input type="checkbox" id="onApplicationEnd" name="onApplicationEnd" value="true" checked="checked"> onApplicationEnd
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onAppicationEnd|The application ends: the application times out, or the server is stopped">
			</p>
			<p>
				<input type="checkbox" id="onSessionStart" name="onSessionStart" value="true" checked="checked"> onSessionStart
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onSessionStart|A session starts">
			</p>
			<p>
				<input type="checkbox" id="onSessionEnd" name="onSessionEnd" value="true" checked="checked"> onSessionEnd
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onSessionEnd|A session ends">
			</p>
			<p>
				<input type="checkbox" id="onRequest" name="onRequest" value="true" checked="checked"> onRequest
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onRequest|The onRequestStart method finishes.">
			</p>
			<p>
				<input type="checkbox" id="onRequestStart" name="onRequestStart" value="true" checked="checked"> onRequestStart
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onRequestStart|A request starts">
			</p>
			<p>
				<input type="checkbox" id="onRequestEnd" name="onRequestEnd" value="true" checked="checked"> onRequestEnd
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onRequestEnd|A request ends">
			</p>
			<p>
				<input type="checkbox" id="onError" name="onError" value="true" checked="checked"> onError
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onError|An exception occurs that is not caught by a try/catch block.">
			</p>
			<p>
				<input type="checkbox" id="onMissingTemplate" name="onMissingTemplate" value="true" checked="checked"> onMissingTemplate
				<img src="../images/help_icon_64.png" height="16" width="16" class="help" title="onMissingTemplate|ColdFusion received a request for a non-existent page.">
			</p>

		</div>

	</div>

	<p align="right" style="padding:10px 0 10px 0;">
		<input type="submit" id="submit" name="submit" value="Create Application CFC">
	</p>

	</form>

</body>
</html>
</cfif>
