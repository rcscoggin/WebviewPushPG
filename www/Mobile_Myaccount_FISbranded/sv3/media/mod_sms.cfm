
<!---
Name:
	mod_sms.cfm

Description:
	This is the container page for SMS Enrolmment page.

Author: Karanam Sankar

Revision History:
	04/07/2009	Karanam Shankar			Created.
	08/02/2011  	Vijaya Gopi				Changes done for NESPII Project.

To Do:

--->
<cfoutput>
 
<script language="JavaScript"> 
function country_handler()
{
	var formname = "form1";
	var oForm = document[formname];
 
	oForm.sendinfo_carriers.value = 1;   
	oForm.submit();
}
</script>
 

<script language="JavaScript" type="text/javascript">
var callShowKeywordToDisplay = -1;
function showDIV(divName)
{
	if (document.getElementById)
	{
		document.getElementById(divName).style.display = "block";
		document.getElementById(divName).style.visibility = "visible";
	}

	else if (document.layers)
	{
		document.layers[divName].visibility = "show";
	}
}

function hideDIV(divName)
{
	if (document.getElementById)
	{
		document.getElementById(divName).style.display = "none";
		document.getElementById(divName).style.visibility = "hidden";
	}

	else if (document.layers)
	{
		document.layers[divName].visibility = "hide";
	}
}

function showCountryCode()
{
	showDIV('country_code');
	if (document.form1.country.value == 0)
	{
		hideDIV('country_code');
	}
	document.getElementById('countrycode').innerText = document.form1.country.value;	
}

function validateCheck(group)
{
	
	if (document.form1.mobile_number.value!=document.form1.confirm_mobile_number.value)
	 {
	 	alert ("#request.udf.safesnippet("mobilevalidation", "_errormessages")#");
	  	return false;
	 }
	var checkval=0;
	var e=document.getElementsByTagName('input');
	for(var i=0;i<e.length;i++)
	{
		 if(e[i].getAttribute('type') == 'checkbox')
		{
			if(e[i].checked)
			{
				checkval=1;
			}
		 }
	}
	var sms_required = '#request.site.SMS_alerttype_required#';
	if(checkval == 1 || sms_required == 'n')
	{
		return true;
	}
	else
	{
		alert("#request.udf.safesnippet("alerttype_required", "_common")#");
		return false;
	}


}

function showKeywordDisplay()
{
	if(document.form1.language.value=="1")
	{
		EnglishKeyword.style.display = "block";
		SpanishKeyword.style.display = "none";
		FrenchKeyword.style.display = "none";
	}
	else if (document.form1.language.value=="2")
	{
		EnglishKeyword.style.display = "none";
		SpanishKeyword.style.display = "block";
		FrenchKeyword.style.display = "none";
	}
	else if(document.form1.language.value=="3")
	{
		EnglishKeyword.style.display = "none";
		SpanishKeyword.style.display = "none";
		FrenchKeyword.style.display = "block";
	}
	else
	{
		EnglishKeyword.style.display = "block";
		SpanishKeyword.style.display = "none";
		FrenchKeyword.style.display = "none";
	}
}

function showKeywordToDisplay(languageOption)
{
	if(languageOption=="1")
	{
		EnglishKeyword.style.display = "block";
		SpanishKeyword.style.display = "none";
		FrenchKeyword.style.display = "none";
	}
	else if (languageOption=="2")
	{
		EnglishKeyword.style.display = "none";
		SpanishKeyword.style.display = "block";
		FrenchKeyword.style.display = "none";
	}
	else if(languageOption=="3")
	{
		EnglishKeyword.style.display = "none";
		SpanishKeyword.style.display = "none";
		FrenchKeyword.style.display = "block";
	}
	else
	{
		EnglishKeyword.style.display = "block";
		SpanishKeyword.style.display = "none";
		FrenchKeyword.style.display = "none";
	}
}
</script>

<style type="text/css" media="all">@import url("#media("sv3_tooltip.css")#");</style>

<!--- Begin Tool tip code --->
<div id="dhtmltooltip"></div>
<script language="JavaScript" src="#media("cms/tooltip.js")#" type="text/javascript"></script>
<!--- End Tool tip code --->
					
#ffFormStart("#request.pageid#")#
<cfset cardnum = request.sessiondata.smsenrollingcardnum>
<cfset DoNotDisturb = 1>
<!--- For First time enrollment will take the values (Country, Language, Alert types)  from smsconfiguration session .
		For Active Status take the values from smsenrollment session --->
		<cfif isdefined("request.sessiondata.smsenrollment") and  StructKeyExists(request.sessiondata.smsenrollment, cardnum)>
			<cfset status = request.sessiondata.smsenrollment[cardnum].status>
			<cfset countrycode = request.sessiondata.smsenrollment[cardnum].countrycode>		
			<cfset mobilenumber = request.sessiondata.smsenrollment[cardnum].mobilenumber>
			<cfset DoNotDisturb = request.sessiondata.smsenrollment[cardnum].DoNotDisturb>
			<cfset languagename = request.sessiondata.smsenrollment[cardnum].languagename>
			<cfif isDefined("request.sessiondata.smsconfiguration.carrier")>
				<cfset CarrierDesc = request.sessiondata.smsenrollment[cardnum].CarrierDesc>
			</cfif>			
			<cfset lowbalance = request.sessiondata.smsenrollment[cardnum].AddlParamOverride>
			<cfset alerttype = request.sessiondata.smsenrollment[cardnum].alerttype>
		</cfif>			
			
		<cfset languagelist = request.sessiondata.smsconfiguration.language>
		<cfif isDefined("request.sessiondata.smsconfiguration.carrier")>
			<cfset countrylist = request.sessiondata.smsconfiguration.carrier>				
		</cfif>
		<cfset timezonelist = request.sessiondata.smsconfiguration.timezone>
		<cfset alerttype = request.sessiondata.smsconfiguration.alerttype>
		<cfif isdefined("request.sessiondata.smsconfiguration.fees") and len(request.sessiondata.smsconfiguration.fees) eq 0>
			<cfset request.sessiondata.smsconfiguration.fees = 0>
		</cfif>
<cf_wcs_borg_display_validation_errors>
		<h4 class="msg error"><cf_wcs_borg_format_validation_errors></h4>
	</cf_wcs_borg_display_validation_errors>
<div id="subHeader">
	<cfif isdefined("request.sessiondata.smsenrollment") and StructKeyExists(request.sessiondata.smsenrollment, cardnum) and request.sessiondata.smsenrollment[cardnum].status neq 0 and request.sessiondata.smsenrollment[cardnum].status neq 3>
		<h1 id="pageTitle">#snippet("sms_pagetitle","_common")#</h1><h2 id="subTitle"> #snippet("sms_subtitle")#</h2>
	<cfelse>
		<h1 id="pageTitle">#snippet("sms_pagetitle","_common")#</h1>
	</cfif>
</div>

<div class="container">
	<div class="content">

		<ul id="progressChips">
			<li title="Step 1" class="first active">#snippet("step_1","_common")#</li>
			<li title="Step 2">#snippet("step_2","_common")#</li>
			<li title="Step 3">#snippet("step_3","_common")#</li>
		</ul>
		<h3 id="progressBar">#snippet("progress_s1_3","_labels")#</h3>
		<cfset curcard = request.sessiondata.cards[cardnum]>
		<cfif isdefined("request.sessiondata.smsenrollment") and StructKeyExists(request.sessiondata.smsenrollment, cardnum) and request.sessiondata.smsenrollment[cardnum].status neq 0>
			<cfif isdefined("request.sessiondata.smsconfiguration.fees") and (request.sessiondata.smsconfiguration.fees gt 0)>
				#safesnippetreplace("sms_active_note", "l115", "X.XX", "#request.udf.formatcurrencyintl(request.sessiondata.smsconfiguration.fees,curcard.issuing_currency,'ISO','left',1)#")#
			</cfif>
		<cfelse>
			<cfif isdefined("request.sessiondata.smsconfiguration.fees") and (request.sessiondata.smsconfiguration.fees gt 0)>
				#safesnippetreplace("sms_msg", "l115", "X.XX", "#request.udf.formatcurrencyintl(request.sessiondata.smsconfiguration.fees,curcard.issuing_currency,'ISO','left',1)#")#
			<cfelse>
				#snippet("sms_withoutfee_msg")#
			</cfif>
		</cfif>

		 #snippet("smsnote","_common")#

    	<div class="required">#snippet("req_fields","_common")#</div>
			<label class="boxLabel">#snippet("smsinfo")#</label>
			<table border="0" cellspacing="10" cellpadding="0" class="innerBox" summary="This table used for layout" width="100%">
		  <tr valign="top">
				<td>
					<div class="relative">
						<label for="country">#snippet("country")#</label>
							<cfif isDefined("countrylist")>							
								<cfquery dbtype="query"	name="Countrylist">
									select distinct country,countrycode,countryphonecode from countrylist
								</cfquery>
							
								<cfif isdefined("request.sessiondata.smsenrollment") and StructKeyExists(request.sessiondata.smsenrollment, cardnum)>
									<select name="country" id="country" class="width-135px"  onchange="country_handler();">
										<option value="0">#snippet("choose")#</option>
										<cfloop query="Countrylist">
											<cfif request.sessiondata.smsenrollment[cardnum].countrycode eq "#countrylist.countrycode#">
												<option value="#Countrylist.countrycode#" selected id="#Countrylist.countrycode#">#Countrylist.country#</option>
											<cfelse>
												<option value="#Countrylist.countrycode#" id="#Countrylist.countrycode#">#Countrylist.country#</option>
											</cfif>
										</cfloop>
									</select>
									<input type="hidden" name="sendinfo_carriers" value="0">				
									<noscript>
										#ffSubmit("sendinfo_carriers", SafeSnippet("update_carrier", "_btn"), "", "", "title=""#safesnippet("update_carrier_title", "_btn")#"" onMouseOver=""cls(this,'btnOn');"" onMouseOut=""cls(this,'btn');"" onFocus=""cls(this,'btnOn');"" onBlur=""cls(this,'btn');""", "btn")#
									</noscript>									
									<div class="note">#snippet("countryinfo")#</div>
									</td>
									<td>
										 <div id="country_code">
										 <label>#snippet("countrycode","_common")#</label>
										 <label id="countrycode" for="countrycode">#request.sessiondata.smsenrollment[cardnum].countryphonecode#</label>
										<cfset countryphonecode = #request.sessiondata.smsenrollment[cardnum].countryphonecode#>
										</div>
									</td>
								<cfelse>
									<select name="country" id="country" class="width-135px" onchange="country_handler();">
										<option value="0">#snippet("choose")#</option>
										<cfloop query="Countrylist">
											<option value="#Countrylist.countrycode#" id="#Countrylist.countrycode#">#Countrylist.country#</option>
										</cfloop>
									</select>
									<input type="hidden" name="sendinfo_carriers" value="0">				
									<noscript>
										#ffSubmit("sendinfo_carriers", SafeSnippet("update_carrier", "_btn"), "", "", "title=""#safesnippet("update_carrier_title", "_btn")#"" onMouseOver=""cls(this,'btnOn');"" onMouseOut=""cls(this,'btn');"" onFocus=""cls(this,'btnOn');"" onBlur=""cls(this,'btn');""", "btn")#
									</noscript>
									<div class="note">#snippet("countryinfo")#</div>
									</td>
									<td>
									 <div id="country_code" style="display:none">
										<label>#snippet("countrycode","_common")#</label>
										 <label id="countrycode" for="countrycode">#Countrylist.countryphonecode#</label>
										 <cfset countryphonecode = #Countrylist.countryphonecode#>
									</div>
									</td>
								</cfif>
					  <cfelse>
							<input type="hidden" id="country" name="country" value= "#request.sessiondata.smsconfiguration.address.country#">
							#request.sessiondata.smsconfiguration.address.country#							
							<div class="note">#snippet("countryinfo")#</div>
							</td>
							<td>
							<label>#snippet("countrycode","_common")#</label>
							<label id="countrycode" for="countrycode">#request.sessiondata.smsconfiguration.address.countryphonecode# </label>							
							</td>
						</cfif>
					</div>
			<tr>
				<td>
					<label for="language">#snippet("language")#</label>
						 <cfquery dbtype="query"	name="languagelist">
								select languageid, languagename from languagelist
						</cfquery>

						<cfif "#languagelist.recordcount#" ge 2 >
							<cfif isdefined("request.sessiondata.smsenrollment") and StructKeyExists(request.sessiondata.smsenrollment, cardnum)>
								<select name="language" id="language" class="width-135px"  onchange="javascript:showKeywordDisplay();">
									<option value="0">#snippet("choose")#</option>
									<cfloop query="languagelist">
										<cfif request.sessiondata.smsenrollment[cardnum].languagename eq #languagelist.languagename#>
											<option value="#languagelist.languageid#" selected>#languagelist.languagename#</option>
										<cfelse>
											<option value="#languagelist.languageid#" >#languagelist.languagename#</option>
										</cfif>
									</cfloop>
								  </select>
							  <cfelse>
								<select name="language" id="language" class="width-135px"  onchange="javascript:showKeywordDisplay();">
									<option value="0">#snippet("choose")#</option>
									<cfloop query="languagelist">
										<option value="#languagelist.languageid#">#languagelist.languagename#</option>
									</cfloop>
								  </select>
							</cfif>
						<cfelse>
								#languagelist.languagename#
								<script language="javascript">
									callShowKeywordToDisplay = #languagelist.languageid#;
								</script>
								<input type="hidden" id="language" name="language" value= "#languagelist.languagename#">
						</cfif>
					<div class="note">#snippet("languagenote")#</div>
				</td>
				<td valign="top">
					<cfif isDefined("request.sessiondata.smsconfiguration.carrier")>						
						<label for="carrier">#snippet("carrier")#</label>						
						<cfif isDefined("request.sessiondata.Selectedcarrier")>
								<cfquery dbtype="query"	name="carrierlist">
										select carrierid, CarrierDesc from request.sessiondata.Selectedcarrier
								</cfquery>
								<cfif isdefined("request.sessiondata.smsenrollment") and StructKeyExists(request.sessiondata.smsenrollment, cardnum)>
									<cfif  len(request.sessiondata.smsenrollment[cardnum].countryphonecode) gt 0>
										<select name="carrier" id="carrier" class="width-135px" >									
											<option value="0">#snippet("choose")#</option>
											<cfloop query="carrierlist">
												<cfif request.sessiondata.smsenrollment[cardnum].CarrierDesc eq #carrierlist.CarrierDesc#>
													<option value="#carrierlist.carrierid#"  selected>#carrierlist.CarrierDesc#</option>
												<cfelse>
													<option value="#carrierlist.carrierid#"  >#carrierlist.CarrierDesc#</option>
												</cfif>
											</cfloop>
										  </select>
									<cfelse>
										<select name="carrier" id="carrier" class="width-135px">
										<option value="0">#snippet("choose")#</option>								
									  </select>
									</cfif>
								  <cfelse>
									 <select name="carrier" id="carrier" class="width-135px">
										<option value="0">#snippet("choose")#</option>
										<cfloop query="carrierlist">
											<option value="#carrierlist.carrierid#">#carrierlist.CarrierDesc#</option>
										</cfloop>
									  </select>							 
								</cfif>
							<cfelse>
								<select name="carrier" id="carrier" class="width-135px">
									<option value="0">#snippet("choose")#</option>								
								  </select>		
							</cfif>
					</cfif>
        		</td>
			</tr>
			<tr>
				<td width="40%">
				<label for="mobile_number" class="margin-top-5px">#snippet("mobilenumber")#</label>
				<input type="text" id="mobile_number" name="mobile_number" size="25" maxlength="25" oncopy="alert('#safesnippet("mobilenumber_copyalert")#'); return false;" onpaste="alert('#safesnippet("mobilenumber_copyalert")#'); return false;" <cfif IsDefined("mobilenumber") and len(mobilenumber)>value="#mobilenumber#"</cfif>>
				</td>
				<td width="60%">
				<label for="confirm_mobile_number" class="margin-top-5px">#snippet("confmobilenumber")#</label>
				<input type="text" id="confirm_mobile_number" name="confirm_mobile_number" size="25" maxlength="25" oncopy="alert('#safesnippet("mobilenumber_copyalert")#'); return false;"onpaste="alert('#safesnippet("mobilenumber_copyalert")#'); return false;"<cfif IsDefined("mobilenumber") and len(mobilenumber)>value="#mobilenumber#"</cfif>>
				</td>
			</tr>
			<tr>
        		<td colspan="2"> #snippet("mobilenumber_note")#</td>
			</tr>
			<cfset showDoNotDisturb = "">
			<cfquery dbtype="query"	name="GetDoNotDisturb">
				select DoNotDisturbFrom,DoNotDisturbTo,msgid from request.sessiondata.smsconfiguration.alerttype 
				where accesslvl = 1 order by msgdescription desc
			</cfquery>
			<cfif GetDoNotDisturb.recordcount gt 0>																							
				<cfloop query="GetDoNotDisturb">
					<cfif len(GetDoNotDisturb.DoNotDisturbFrom) or len(GetDoNotDisturb.DoNotDisturbTo)>
						<cfset showDoNotDisturb = "1">
						<cfset DoNotDisturbFromTime = #TimeFormat(GetDoNotDisturb.DoNotDisturbFrom, "hh:mmtt")#>
						<cfset DoNotDisturbToTime = #TimeFormat(GetDoNotDisturb.DoNotDisturbTo, "hh:mmtt")#>
					</cfif>
				</cfloop>
			</cfif>		
         	<cfif showDoNotDisturb is "1">	
				<tr>
					<td >
					<label for="timezone">#snippet("timezone")#</label>
					<cfquery dbtype="query"	name="timezonelist">
							select TzId, Location from timezonelist order by  Location
					</cfquery>

					<cfif isdefined("request.sessiondata.smsenrollment") and StructKeyExists(request.sessiondata.smsenrollment, cardnum)>
						<select name="timezone" id="timezone" class="width-135px">
							<option value="0">#snippet("choose")#</option>
							<cfloop query="timezonelist">
								<cfif request.sessiondata.smsenrollment[cardnum].TimeZoneLocation eq #timezonelist.Location#>
									<option value="#timezonelist.TzId#" selected>#timezonelist.Location#</option>
								<cfelse>
									<option value="#timezonelist.TzId#" >#timezonelist.Location#</option>
								</cfif>
							</cfloop>
						  </select>
					  <cfelse>
						<select name="timezone" id="timezone" class="width-135px">
							<option value="0">#snippet("choose")#</option>
							<cfloop query="timezonelist">
								<option value="#timezonelist.TzId#">#timezonelist.Location#</option>
							</cfloop>
						  </select>
					</cfif>
					</td>								
				</tr>
				<tr>				
					<td colspan="3">					
						<div class="label"><input type="checkbox" id="DoNotDisturb" onclick="return enableDisableTimeZone()" name="DoNotDisturb"  value="1" class="chkbox" <cfif IsDefined("DoNotDisturb") and DoNotDisturb is "1">checked</cfif>> #SnippetReplace("DoNotDisturb", "_common", "fromtime", DoNotDisturbFromTime,"totime",DoNotDisturbToTime)# <a href="javascript:" class="help" onMouseOver="ddrivetip('#SnippetReplace("sms_DnD_title", "_titles", "fromtime", DoNotDisturbFromTime,"totime",DoNotDisturbToTime)#')" onMouseOut="hideddrivetip();" onClick="return false;">i</a> </div>
						
					</td>
				</tr>
				<script language="JavaScript">
						enableDisableTimeZone();
						function enableDisableTimeZone()
						{
							var dd=document.getElementById("DoNotDisturb");
							if(dd.checked == true)
							{
									document.getElementById("timezone").disabled = false;													
							}
							else
							{
									document.getElementById("timezone").disabled = true;													
							}
						}
					</script>		
			</cfif>
        <cfset btnDisabled = "">
		<cfset selectAlert = "">
		<cfset datarow = "datarow1">	
				<tr>
					<td colspan="3">
					<label for="alert_types" style="margin-top:10px;">#snippet("alerttype","_common")#</label>
					<table id="alert_types" border="0" cellspacing="0" cellpadding="0" width="100%" class="dataTable" summary="">
						<cfquery dbtype="query"	name="alerttype">
							select accesslvl,msgdescription,msgtriggerid,msgid,addlparam from request.sessiondata.smsconfiguration.alerttype 
							where accesslvl = 1 order by msgdescription desc
						</cfquery>
						<cfif alerttype.recordcount gt 0>																							
							<cfloop query="alerttype">	
									<cfif isdefined("request.sessiondata.smsenrollment") and 
										StructKeyExists(request.sessiondata.smsenrollment, cardnum)>
										<cfif listfindnocase(request.sessiondata.smsenrollment[cardnum].alerttype.alertid,"#alerttype.msgid#")>
											<cfset selectAlert = "checked">
										<cfelse>
											<cfset selectAlert = "">
										</cfif>
									<cfelse>
											<cfset selectAlert = "checked">
									</cfif>
									<tr class="#datarow#" valign="top">
										<td class="labels" align="left" width="15" valign="top">
											<input type="checkbox" id="#alerttype.msgid#" name="#alerttype.msgid#"  class="chkbox" #selectAlert# <cfif alerttype.msgid is "MT9">onclick="return enableDisableLowBalance()"</cfif>>
										</td>
										
										<cfif isdefined("alerttype.addlparam") and len(alerttype.addlparam) eq 0>
											<cfset additionalparam = 0>
										<cfelse>
											<cfif IsNumeric(alerttype.addlparam)>
												<cfset additionalparam = NUMBERFORMAT(alerttype.addlparam, '____.__')>
											<cfelse>
												<cfset additionalparam = alerttype.addlparam>
											</cfif>
										</cfif>
										<cfif alerttype.msgid eq "MT9">
											<cfif IsDefined("request.site.SMS_lowbalance_required") and request.site.SMS_lowbalance_required>
												<td align="left" width="240"><label for="#alerttype.msgid#">#alerttype.msgdescription#</label>
													<div class="note">#snippet("sms_MT9_lowbalance_note", "_common")# #LEFT(request.udf.formatcurrencyintl(additionalparam,curcard.issuing_currency,'ISO','left',1),3)#</div>
												</td>
											<cfelse>
												<td align="left"><label for="#alerttype.msgid#">#alerttype.msgdescription#</label>
													<div class="note">#safesnippetreplace("sms_MT9_note", "_common", "CUR","#LEFT(request.udf.formatcurrencyintl(additionalparam,curcard.issuing_currency,'ISO','left',1),3)#","X.XX","#additionalparam#")#</div>
												</td>
											</cfif>	
										<cfelse>
											<td align="left"><label for="#alerttype.msgid#">#alerttype.msgdescription#</label></td>
										</cfif>							
										
										<cfif alerttype.msgid eq "MT9">
											<cfif isDefined("lowbalance") and len(lowbalance)>
													<cfif IsNumeric(lowbalance)>
														<cfset additionalparam = NUMBERFORMAT(lowbalance, '____.__')>
													<cfelse>
														<cfset additionalparam = lowbalance>
													</cfif>										
											</cfif>
											<cfif IsDefined("request.site.SMS_lowbalance_required") and request.site.SMS_lowbalance_required>
												<cfset minval = request.udf.formatcurrencyintl(request.site.SMS_lowbalance_minval,curcard.issuing_currency,'ISO','left',1)>
												<td align="left">
													<input type="text" name="lowbalance" id="lowbalance" size="4" maxlength="7" 
													value="#additionalparam#">
												</td>
												<td width="200">
													<cfset maxval = request.udf.formatcurrencyintl(alerttype.addlparam,curcard.issuing_currency,'ISO','left',1)>
													<div class="note">#SnippetReplace("lowbalance_note", "_common", "minval", minval, "maxval", maxval)#</div>
												</td>											
											</cfif>		
											<script language="JavaScript">
												enableDisableLowBalance();
												function enableDisableLowBalance()
												{
													var dd=document.getElementById("MT9");
													if(dd.checked == true)
													{
															document.getElementById("lowbalance").disabled = false;													
													}
													else
													{
															document.getElementById("lowbalance").disabled = true;													
													}
												}
											</script>
										<cfelse>
											<td></td>	
											<td></td>											
										</cfif>
									</tr>									
									<cfif datarow eq "datarow1">
										<cfset datarow = "datarow2">
									<cfelse>
										<cfset datarow = "datarow1">
									</cfif>							
							</cfloop>	
						<cfelse>
							<cfset btnDisabled = "disabled" >
							<tr class="#datarow#" valign="top">
									<td class="labels" align="left">
												#snippet("no_alerts")#
									</TD>
							</TR>	
						</cfif>
					</table>
				</td>
			</tr>
		</table>

      <label class="boxLabel">#snippet("smscmdinfo","_common")#</label>
      <table cellspacing="10" class="innerBox" summary="This table is used for layout" width="100%">
      <tr>
      	<td>
				
				<label for="send_alerts">
				#snippet("smsdialcode","_common")#
				<span id="alert_dialcode">
					#request.sessiondata.smsconfiguration.address.MsgAddress#
				</span>
				</label>		
			
				<div id="EnglishKeyword" style="display:block;">
					<table id="send_alerts" cellpadding="5" border="0" cellspacing="0" width="100%" class="dataTable" summary="">
						<tr class="dataHeader" valign="bottom">
							<th colspan="2">#snippet("thcmd","_common")#</th>
							<th>#snippet("thwhatitdoes","_common")#</th>
							<th>#snippet("thexample","_common")#</th>
						</tr>
						<cfset datarow = "datarow1">
						<!--- jfc - snippetize description --->
						<cfloop query="request.sessiondata.SMSCommandInfo">
							<tr class="#datarow#" valign="top">
								<td align="left" width="15"><img src="#media("cms/checkmark.gif")#" alt="checked"></td>
								<td><label>#command#</label></td>
								<td>#snippet("SMScmd_#command#", "mod_sms")#</td>
								<td>#example#</td>
							</tr>
							<cfif datarow eq "datarow1">
								<cfset datarow = "datarow2">
							<cfelse>
								<cfset datarow = "datarow1">
							</cfif>
						</cfloop>
					</table>
				</div>
				 <div id="SpanishKeyword" style="display:none;">
					<table id="send_alerts_Spanish" cellpadding="5" border="0" cellspacing="0" width="100%" class="dataTable" summary="">
						<tr class="dataHeader" valign="bottom">
							<th colspan="2">#snippet("thcmd","_common")#</th>
							<th>#snippet("thwhatitdoes","_common")#</th>
							<th>#snippet("thexample","_common")#</th>
						</tr>
						<cfset datarow = "datarow1">
						<!--- jfc - snippetize description --->
						<cfloop query="request.sessiondata.SMSCommandInfoSpanish">
							<tr class="#datarow#" valign="top">
								<td align="left" width="15"><img src="#media("cms/checkmark.gif")#" alt="checked"></td>
								<td><label>#command#</label></td>
								<td>#snippet("SMScmd_#command#", "mod_sms")#</td>
								<td>#example#</td>
							</tr>
							<cfif datarow eq "datarow1">
								<cfset datarow = "datarow2">
							<cfelse>
								<cfset datarow = "datarow1">
							</cfif>
						</cfloop>
					</table>
				</div>
				<div id="FrenchKeyword" style="display:none;">
					<table id="send_alerts_French" cellpadding="5" border="0" cellspacing="0" width="100%" class="dataTable" summary="">
						<tr class="dataHeader" valign="bottom">
							<th colspan="2">#snippet("thcmd","_common")#</th>
							<th>#snippet("thwhatitdoes","_common")#</th>
							<th>#snippet("thexample","_common")#</th>
						</tr>
						<cfset datarow = "datarow1">
						<!--- jfc - snippetize description --->
						<cfloop query="request.sessiondata.SMSCommandInfoFrench">
							<tr class="#datarow#" valign="top">
								<td align="left" width="15"><img src="#media("cms/checkmark.gif")#" alt="checked"></td>
								<td><label>#command#</label></td>
								<td>#snippet("SMScmd_#command#", "mod_sms")#</td>
								<td>#example#</td>
							</tr>
							<cfif datarow eq "datarow1">
								<cfset datarow = "datarow2">
							<cfelse>
								<cfset datarow = "datarow1">
							</cfif>
						</cfloop>
					</table>
				</div>

				</td>

				<cfif isdefined("request.site.dialcode") and request.site.dialcode eq 1>
					<cfset smsdialcode = request.sessiondata.smsconfiguration.address.MsgAddress>
				<cfelse>
					<cfset smsdialcode = "XXXXX">
				</cfif>
				<td><div class="note">#SnippetReplace("smsalertnote", "_common", "dialcode", smsdialcode)#</div>
				</td>
			</tr>
      </table>

		<table border="0" cellspacing="0" cellpadding="0" id="formControls" summary="This table is used for layout">
      		<tr>
				<td id="formNav">
				<a href="index.cfm?pageid=l01&#request.sessiontoken#" class="btn" title="#safesnippet("cancel","_btn")#">#safesnippet("cancel","_btn")#</a>
				</td>
				<td id="formAction">
				<input type="submit" name="sendinfo" value="#safesnippet("continue","_btn")#" class="btn"   title="#safesnippet("continue_next_title","_btn")#" onFocus="cls(this,'btnOn')" onBlur="cls(this,'btn')" onMouseOver="cls(this,'btnOn')" onMouseOut="cls(this,'btn')" onclick="return(validateCheck(this));">
				</td>
			</tr>
		</table>

		#ffFormEnd()#

	</div>
</div>
<script language="javascript">
	if(callShowKeywordToDisplay != -1)
		showKeywordToDisplay(callShowKeywordToDisplay);
</script>
</cfoutput>
