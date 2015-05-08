<cfcomponent output="false">

	<cffunction name="init" access="public" returntype="TagWriter" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="writeTemplate" access="public" output="false" returntype="any">
		<cfargument name="destination" type="string" required="true" />
		<cfargument name="template" type="string" required="true" />
		<cfargument name="input" type="struct" required="true" />
		<cfset var file = "" />

		<cfscript>
		    var temp = fileOpen(arguments.template, "read");
		    var out = fileOpen(arguments.destination, "write");

		    while(!FileIsEOF(temp)) {
		        x = FileReadLine(temp);
				data = processLine(x,arguments.input);
				if(len(trim(data))) {
					fileWriteLine(out,data);
				}
		    }

		    fileClose(temp);
		    fileClose(out);
		</cfscript>

		<cffile action="read" file="#arguments.destination#" variable="file">

		<!--- remove any functions that the user wants to exclude--->
		<cfset file = removeMethods(file,arguments.input)>
		<!--- do cleanup --->
		<cfset file = cleanup(file)>

		<cfreturn file>
	</cffunction>

	<cffunction name="processLine" access="public" returntype="string" output="false">
		<cfargument name="line" type="string" required="true">
		<cfargument name="input" type="struct" required="true" />
		<cfset var file = arguments.line>
		<cfset var newline = chr(13) & chr(10)>

		<cfif findNoCase(":cfcomponent",file)>
			<cfset file = reReplaceNoCase(file, '{displayname}', arguments.input.displayname) />
			<cfset file = reReplaceNoCase(file, '{hint}', arguments.input.hint) />
			<cfif len(arguments.input.extends)>
				<cfset file = reReplaceNoCase(file, '{extends}', arguments.input.extends) />
			<cfelse>
				<cfset file = reReplaceNoCase(file, 'extends="{extends}" ',"") />
			</cfif>
			<cfset file = reReplaceNoCase(file,'{output}', arguments.input.output) />
			<cfset file = file & newline>
		</cfif>

		<cfif findNoCase(":cfset",file)>
			<cfif findNoCase("ormsettings",file)>
				<cfset file = replaceORMSettings(file,arguments.input)>
			<cfelse>
				<cfset var property = rematch("{[^{]+}",file)[1]>
				<cfset property = replace(property,"{","")>
				<cfset property = replace(property,"}","")>
				<cfset file = replaceProperty(file,'#property#',arguments.input[property])>
			</cfif>

		</cfif>

		<cfif findNoCase(":cffunction",file)>

			<!--- format new lines after the end of a function --->
			<cfif findNoCase(":cffunction>",file)>
				<cfset file = replace(file,":cffunction>",":cffunction>" & newline)>
			</cfif>

		</cfif>

		<cfif findNoCase("	<!-- orm settings -->",file)>
			<cfset file = newline & "	<!-- orm settings -->">
		</cfif>
		<cfif findNoCase("	<!-- methods -->",file)>
			<cfset file = newline & "	<!-- methods -->">
		</cfif>

		<cfreturn file>
	</cffunction>

	<cffunction name="replaceProperty" access="private" returntype="any" output="true">
		<cfargument name="file" type="string" required="true">
		<cfargument name="property" type="string" required="true">
		<cfargument name="value" type="any" required="true">

		<cfif len(trim(arguments.value))>
			<cfif isSimpleValue(arguments.value)>
				<cfset arguments.file = reReplaceNoCase(arguments.file, '{#arguments.property#}','#arguments.value#') />
			<cfelse>
				<cfset arguments.file = reReplaceNoCase(arguments.file, '{#arguments.property#}','#arguments.value#') />
			</cfif>
		<cfelse>
			<cfset file = reReplaceNoCase(file, '<:cfset this.#arguments.property# = {#arguments.property#}>',"") />
		</cfif>

		<cfreturn file>
	</cffunction>

	<cffunction name="replaceORMSettings" access="private" returntype="any" output="true">
		<cfargument name="file" type="string" required="true">
		<cfargument name="input" type="struct" required="true">
		<cfset var settings = arguments.file>
		<cfset var property = "">
		<cfset var value = "">
		<cfset var properties = rematch("{[^{]+}",settings)>

		<cfloop array="#properties#" index="i">

			<cfset property = replace(i,"{","")>
			<cfset property = replace(property,"}","","all")>
			<cfset value = arguments.input[property]>
			<cfset value = replace(value,",","")>

			<cfif len(value)>
				<cfif isBoolean(value)>
					<cfset settings = reReplaceNoCase(settings, '{#property#}',value) />
				<cfelse>
					<cfset settings = reReplaceNoCase(settings, '{#property#}','"#value#"') />
				</cfif>
			<cfelse>
				<cfset settings = reReplaceNoCase(settings,'#property#={#property#},',"") />
				<cfset settings = reReplaceNoCase(settings,'#property#={#property#}',"") />
			</cfif>

		</cfloop>

		<cfreturn settings>
	</cffunction>


	<cffunction name="removeMethods" access="private" returntype="string" output="false">
		<cfargument name="f" type="string" required="true">
		<cfargument name="input" type="struct" required="true">
		<cfset var file = arguments.f>
		<cfset var methods = "onapplicationstart,onapplicationend,onsessionstart,onsessionend,onrequest,onrequeststart,onrequestend,onerror,onmissingtemplate">

		<cfloop list="#methods#" index="method">
			<cfif NOT structKeyExists(arguments.input,"#method#")>
				<cfset file = reReplaceNoCase(file,'<:cffunction name="#method#"[^>]+>(.*?)</:cffunction>',"")>
			</cfif>
		</cfloop>

		<cfreturn file>
	</cffunction>

	<cffunction name="cleanup" access="private" returntype="string" output="false">
		<cfargument name="thefile" type="string" required="true">
		<cfset var file = arguments.thefile>

		<!---- parse cf prefix ---->
		<cfset file = reReplaceNoCase(file, ':cf', 'cf', 'all') />
		<!---- convert comments ---->
		<cfset file = reReplaceNoCase(file, '<!--', '<!---', 'all') />
		<cfset file = reReplaceNoCase(file, '-->', '--->', 'all') />
		<!---- remove double linebreaks ---->
		<cfset file = reReplaceNoCase(file, chr(10) & chr(10),chr(10), 'all') />

		<cfreturn file>
	</cffunction>

</cfcomponent>
