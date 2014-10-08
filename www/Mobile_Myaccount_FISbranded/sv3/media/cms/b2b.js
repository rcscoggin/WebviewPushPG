///////////////////////////////////////////////////////////////////////////
//
//	Filename:	b2b.js
//
//	Authors:	Ethan Pitsch (ethan.pitsch@wildcardsystems.com)
//					Jim Connor
//					Dave Phoebus (dave.phoebus@wildcardsystems.com)
//
///////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
//
//	B2B Javascript Library v1.0
//
// History:
//		EAP	20020510	Initial Write
///////////////////////////////////////////////////////////////////////////


// Object highliter

function cls(obj,clsname)
{
	obj.className=clsname;
}


function clsObj(ID,clsname)
{
	styleMe(document.getElementById(ID), clsname);
}


// Get Browser Info

	browserIE = 0;
	browserNetscape = 0;
	browserVersion = parseInt(navigator.appVersion);

	if (navigator.userAgent.indexOf('MSIE') >= 0)
		browserIE = 1;
	else if (navigator.userAgent.indexOf('Mozilla') >= 0)
		browserNetscape = 1;

ns4 = (document.layers)? true:false
ie4 = (document.all)? true:false


// Redirect to modal or full page based on Browser type

function BtnModal (bObj, src)
{
	if (ie4)
		doButton(bObj, 'mdl_' +src+'?' + GetCursorPos());
	else
		RelocateTo (src);
}

function LinkModal (src)
{
	if (ie4)
		doModal('mdl_' +src+'?' + GetCursorPos());
	else
		RelocateTo (src);
}

function ModalAction (src)
{
	if (ie4)
	{
		document.modal.action='mdl_'+src;
		document.modal.submit();
	}
	else
		RelocateTo (src);
}

function FrameAction (src)
{
	if (ie4)
	{
		window.parent.document.modal.action='mdl_'+src;
		window.parent.document.modal.submit();
	}
	else
		RelocateTo (src);
}

function doDetail (bObj,iFr,module)
{
	if (ie4)
		doButton(bObj,'mdl_' +module + '.cfm' + '?' + GetCursorPos());
	else
		doTopFrame(iFr,module);
}



// Show/Hide functions for non-pointer layer/objects
function showObject(id)
{
	if (ns4)
		document.layers[id].visibility = "show";
	else if (ie4)
		document.all[id].style.visibility = "visible";

}

function hideObject(id)
{
	if (ns4)
		document.layers[id].visibility = "hide";
	else if (ie4)
		document.all[id].style.visibility = "hidden";
}


// Page Re-directs for HTML click-thru versions
function RelocateTo(pageid)
{
	window.top.document.location=pageid; return false;
}

function RelocateFrame(pageid)
{
	window.location=pageid; return false;
}

function RelocateToBlank(pageid)
{
	window.open(pageid,"NewWin000"); return false;
}


// Account Function button hi-lighter

btnSave = new Object();

function doButton(bObj, src)
{
	disableButton(bObj);
	doModal(src);
	enableButton();
}

function disableButton(bObj)
{
	btnSave.bObj = bObj;
	btnSave.className = bObj.className;
	btnSave.onmousedown = bObj.onmousedown;
	btnSave.onmouseup = bObj.onmouseup;
	btnSave.onmouseout = bObj.onmouseout;
	bObj.className = 'activeLink';
	bObj.onmousedown = "";
	bObj.onmouseup = "";
	bObj.onmouseout = "";
}

function enableButton()
{
	btnSave.bObj.className = btnSave.className;
	btnSave.bObj.onmousedown = btnSave.onmousedown;
	btnSave.bObj.onmouseup = btnSave.onmouseup;
	btnSave.bObj.onmouseout = btnSave.onmouseout;
}


//Modal code

function init_modal()
{
	window.name = "modalWin";
	
	var maxHeight = 800;
	var maxWidth = 800;

	if (document.body.scrollWidth > maxWidth)
		window.dialogWidth = maxWidth + 'px';
	else
	{
		var wd = document.body.scrollWidth - document.body.clientWidth;
		window.dialogWidth = parseInt(window.dialogWidth) + wd + 'px';
	}
	if (document.body.scrollHeight > maxHeight)
		window.dialogHeight = maxHeight + 'px';
	else
	{
		var ht = document.body.scrollHeight - document.body.clientHeight;
		window.dialogHeight = parseInt(window.dialogHeight) + ht + 'px';		
	}
		window.dialogLeft = (window.screen.availWidth - parseInt(window.dialogWidth)) / 2 + 'px';
		window.dialogTop = (window.screen.availHeight - parseInt(window.dialogHeight)) / 2 + 'px';
}

function GetCursorPos()
{
	return "top=" + document.body.scrollLeft + event.screenY + "&left=" + document.body.scrollLeft + event.screenX;
}


getQueryString();	// creates a global javascript hash named url containing query string data


function getQueryString(string)
{
	if (string == null)
		var queryString = location.search;
	else
		var queryString = string;
		
	var data = queryString.slice(1,queryString.length); // strip ? off

	var dataArray = data.split("&");		// convert queryString to an array 
	url = new Array();
	for (j = 0;j < dataArray.length; j++)		// loop through array and create a hash
		url[dataArray[j].substring(0, dataArray[j].indexOf("="))] = dataArray[j].substring(dataArray[j].indexOf("=") + 1, dataArray[j].length);
}


function doModal(src)
{
	getQueryString(src);
	if (url.scroll == null)
		url.scroll = 'no';
		
	if (url.dialogHeight == null)
		url.dialogHeight = 100;
		
	if (url.dialogWidth == null)
		url.dialogWidth = 100;
		
	rValue = window.showModalDialog(src + "&availWidth=" + window.screen.availWidth + "&availHeight=" + window.screen.availHeight, document, "dialogHeight:" + url.dialogHeight + "px; dialogWidth:" + url.dialogWidth + "px; resizable:no; help:no; center:yes; status:no; scroll:" + url.scroll + "; unadorned:yes;")
	//parseReturn(rValue);
	eval(rValue);
}


function doReturn(dest)
{
		window.returnValue = "document.location = ' " + dest + " ' ";
		window.close();
		
}


// POP-UP WINDOWS
var winStatus = 0;

function popUp(src,x,y,resize) // pass image file name without extension
{
	if (winStatus == 1) {		
		newWindow.close();
	}
	newWindow=window.open(src,'newWin','location=no,menubar=no,directories=no,toolbar=no,status=no,personalbar=no,titlebar=no,scrollbars=no,dependent=no,resizable='+resize+',width='+x+',height='+y+''); // define window size and chrome
	winStatus = 1;
}

function popWin(target,pkg,img)
{
	if (winStatus == 1) {		
		newWindow.close();
	}
	
	// set variables
	var cardart = "?pkg="+pkg+"&img="+img;  // passes card art info for demo
	var maxWidth = window.screen.availWidth - 20;
	var maxHeight = window.screen.availHeight - 40;
	var scrollbar = "yes";
	var resize = "yes";
	
	// predefined CMS window sizes
	switch (target) {
		case "b61.cfm" :
			x = 900;
			y = 600;
			break;
		case "b61f.cfm" :
			x = 900;
			y = 600;
			break;
		case "b71.cfm" :
			x = 830;
			y = 745;
			break;
		case "b72.cfm" :
			x = 580;
			y = 365;
			break;
		case "b76.cfm" :
			x = 550;
			y = 420;
			break;
		default:
			x = 300;
			y = 200;
			break;
	}
	
	if (pkg) {
		target = target+cardart;
	}
	
	// compare desired width against available width
	if (x > maxWidth) {
		x = maxWidth;
		leftPos = 0;
		scrollbar = "yes";
	} else {
		leftPos = (window.screen.availWidth - x)/2;
	}
	
	// compare desired height against available height
	if (y > maxHeight) {
		y = maxHeight;
		x = x + 15;
		topPos = 0;
		scrollbar = "yes";
	} else {
		topPos = (window.screen.availHeight - y)/2;
	}
	
	// check for dual monitor in IE
	if (ie4) {
		var desktopPos = window.event.screenX - window.screen.availWidth;
		if (desktopPos >= 0) {
			leftPos = ((window.screen.availWidth * 2) - x + window.screen.availWidth)/2;
		}
	}
	
	// alert (' '+maxWidth+' x '+maxHeight+' ');
	// alert (' '+leftPos+' x '+topPos+' ');
	// alert (window.event.screenX);
	// alert (' '+window.screen.availWidth+' x '+window.screen.availHeight+' | '+x+' x '+y+' | '+leftPos+' x '+topPos+'');
	
	newWindow=window.open(target,'newWin','location=no,menubar=no,directories=no,toolbar=no,status=no,personalbar=no,titlebar=no,scrollbars='+scrollbar+',dependent=no,resizable='+resize+',width='+x+',height='+y+',top='+topPos+',left='+leftPos+''); // define window size and chrome
	winStatus = 1;
}

function popWinInit(target, iWidth, iHeight)
{
	if (winStatus == 1) {		
		newWindow.close();
	}
	
	// set variables
	var maxWidth = window.screen.availWidth - 20;
	var maxHeight = window.screen.availHeight - 40;
	var scrollbar = "yes";
	var resize = "yes";
	
	if (iWidth)
		x = iWidth;
	else
		x = 300;
	if (iHeight)
		y = iHeight;
	else
		y = 200;

	// compare desired width against available width
	if (x > maxWidth) {
		x = maxWidth;
		leftPos = 0;
		scrollbar = "yes";
	} else {
		leftPos = (window.screen.availWidth - x)/2;
	}
	
	// compare desired height against available height
	if (y > maxHeight) {
		y = maxHeight;
		x = x + 15;
		topPos = 0;
		scrollbar = "yes";
	} else {
		topPos = (window.screen.availHeight - y)/2;
	}
	
	// check for dual monitor in IE
	if (ie4) {
		var desktopPos = window.event.screenX - window.screen.availWidth;
		if (desktopPos >= 0) {
			leftPos = ((window.screen.availWidth * 2) - x + window.screen.availWidth)/2;
		}
	}
	
	newWindow=window.open(target,'newWin','location=no,menubar=no,directories=no,toolbar=no,status=no,personalbar=no,titlebar=no,scrollbars='+scrollbar+',dependent=no,resizable='+resize+',width='+x+',height='+y+',top='+topPos+',left='+leftPos+''); // define window size and chrome
	winStatus = 1;
}

// TREE TOGGLER

function doBranch(node) {

	if(node.parentNode.className == "closed") {
		node.parentNode.className = "open";
	}
	
	else if (node.parentNode.className == "open") {
		node.parentNode.className = "closed";
	}
}

function branchAll() {
	
	var nodes = document.getElementsByTagName('li');

	for (var i = 0; i < nodes.length; i++) {
	
		if (nodes[i].className == 'closed') {			
			nodes[i].className = 'open';
		}
	}	
}

function collapseAll() {
	
	var nodes = document.getElementsByTagName('li');

	for (var i = 0; i < nodes.length; i++) {
	
		if (nodes[i].className == 'open') {			
			nodes[i].className = 'closed';
		}
	}
}

// MODE TOGGLER

function toggleMode() {
	
	var nodes = document.getElementsByTagName('td');

	for (var i = 0; i < nodes.length; i++) {
	
		if (nodes[i].className == 'title_hide') {			
			nodes[i].className = 'title_show';
		}
	
		else if (nodes[i].className == 'title_show') {			
			nodes[i].className = 'title_hide';
		}
	}	
}


// Image swapper

function swapImg(image,target) {
	document.getElementById(target).img.src = image;
}


// SHOW-HIDE

function showHide(event,node)
{
	event.cancelBubble=true;
	document.getElementById(node).style.display = (document.getElementById(node).style.display == "none")?"":"none";
	event.cancelBubble=true;
}


// DIV SWAPPER

function showDIV(divName){
	document.getElementById(divName).style.display = 'block';
	document.getElementById(divName).style.visibility = 'visible';
}

function hideDIV(divName){
	document.getElementById(divName).style.visibility = 'hidden';
	document.getElementById(divName).style.display = 'none';
}

function doTab(obj,divName) {

	var aTabs = document.getElementsByTagName('a');
	var aPanels = document.getElementsByTagName('div');

	for (i = 0; i < aTabs.length; i++) {
	
		if (aTabs[i].className == 'on') {		
			aTabs[i].className = 'off';
		}
	}
	obj.className='on';
	
	for (i = 0; i < aPanels.length; i++) {
	
		if (aPanels[i].className == 'panel') {
			aPanels[i].style.visibility = 'hidden';
			aPanels[i].style.display = 'none';
		}
	}	
	document.getElementById(divName).style.display = 'block';
	document.getElementById(divName).style.visibility = 'visible';
}


// PROCESSING

function process() {
	document.getElementById('procMod').style.display = 'block';
	document.getElementById('procMod').style.visibility='visible';

	var proc = document.getElementById('procMod');
	var IfrRef = document.getElementById('procShim');
	
	proc.style.left = "50%"
	proc.style.top = "50%"
	
	var procleft = proc.offsetLeft
	proc.style.left = procleft - proc.offsetWidth/2
	
	var proctop = proc.offsetTop
	proc.style.top = proctop - proc.offsetHeight/2
	
		 proc.style.display = "block";
		 IfrRef.style.width = proc.offsetWidth;
		 IfrRef.style.height = proc.offsetHeight;
		 IfrRef.style.top = proc.style.top;
		 IfrRef.style.left = proc.style.left;
		 IfrRef.style.zIndex = proc.style.zIndex - 1;
		 IfrRef.style.display = "block";
		 
	setTimeout('endprocess()',2000);
}

function endprocess()
{
	var proc = document.getElementById('procMod');
	var IfrRef = document.getElementById('procShim');

	proc.style.display = "none";
	IfrRef.style.display = "none";
}


// All Checkbox Select/Deselect

function toggleChk(obj,iFr) {

	if (iFr) {
		chx = window.frames[iFr].document.getElementById(obj).getElementsByTagName('input');
		prefix = "window.frames[iFr].";
	} else {
		chx = document.getElementById(obj).getElementsByTagName('input');
		prefix = "";
	}

	for (var j = 1; j <= chx.length; j++) {
		box = eval(prefix+"document."+obj+".row" + j); 
		box.checked = !box.checked;
	}
}


// CSA IFRAME CONTROLS

function doFrame(iFr,module) {
	window.parent.document.getElementById(iFr).style.display = 'none';
	window.parent.document.getElementById(iFr).style.visibility='hidden';
	window.parent.document.getElementById(iFr).src = 'ifr_'+module+'.cfm'; // FOR SIMULATION; MAY CAUSE PARENT PAGE TO RELOAD
	window.parent.document.getElementById(iFr).style.display = 'block';
	window.parent.document.getElementById(iFr).style.visibility='visible';
}

function doTopFrame(iFr,module) {
	window.top.document.getElementById(iFr).style.display = 'none';
	window.top.document.getElementById(iFr).style.visibility='hidden';
	window.top.document.getElementById(iFr).src = 'ifr_'+module+'.cfm'; // FOR SIMULATION; MAY CAUSE PARENT PAGE TO RELOAD
	window.top.document.getElementById(iFr).style.display = 'block';
	window.top.document.getElementById(iFr).style.visibility='visible';
}

function reloadFrame(iFr) {
	window.frames[iFr].location.reload(true);
}

function reloadSelf(iFr) {
	window.parent.frames[iFr].location.reload(true);
}

function killFrame(iFr){
	window.parent.document.getElementById(iFr).style.visibility='hidden';
	window.parent.document.getElementById(iFr).style.display = 'none';
}


// AUTO-SIZE IFRAME HEIGHT

function sizeFrame(iFr) {

	i = window.parent.document.getElementById(iFr)
	iHeight = document.body.scrollHeight
	
	if (ie4) {
		i.style.height = iHeight + "px";
	}
	
	else {
		i.style.height = iHeight - 10 + "px";
	}
}


// Context Menu Creator

function ShowMenu()
{ 
	contextMenu.style.pixelLeft = event.clientX;
	contextMenu.style.pixelTop = event.clientY;
	contextMenu.style.visibility = 'visible';
} 

function hl(aObj, state)
{
	if(state)
	{
		aObj.style.backgroundColor = '#0A246A';
		aObj.style.color = '#FFFFFF';
	}
	else
	{
		aObj.style.backgroundColor = '#D4D0C8';
		aObj.style.color = '#000000';
	}
}


// INPUT CLEAR

function wipe(el) {
	if (el.defaultValue==el.value) el.value = ""
}


// Field ENABLE/DISABLE


function enableField(id)
{
	if (document.getElementById)
	{
		document.getElementById(id).className = ' ';
		document.getElementById(id).disabled = false;
	}
	
	else if (document.layers)
	{
		return false;
	}
}

function disableField(id)
{
	if (document.getElementById)
	{
		document.getElementById(id).className = 'disabled';
		document.getElementById(id).value = '';
		document.getElementById(id).disabled = true;
	}
	
	else if (document.layers)
	{
		return false;
	}
}


// Memo Length Checker

function check_size(str)
{
	var memolimit = 255;

	if(str.length < memolimit + 1)
	{
		document.all.memo_count.innerHTML = '<b>Memo *</b> ( Max. ' + memolimit + ' chars; ' + str.length + ' chars entered.)';
	}
	else
	{
		alert('Character limit of ' + memolimit + ' exceeded, Please review content!');
		document.all.memo.innerHTML = document.all.memo.innerText.substring(0, memolimit);
	}
}

// SEND TO PRINTER

function printit(){  
	if (window.print) {
	    window.print() ;  
	} else {
	    var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
	document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
	    WebBrowser1.ExecWB(6, 2); //Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
	}
}

function printFrame(iFr) {
	window[iFr].focus();
	window[iFr].print();
}


// STANDARD JAVSCRIPT OK/CANCEL CANCELLATION CONFIRMATION DIALOG

mess = 'Are you sure you want to cancel?\nAny changes not saved at this point will be lost.'; // mess = a string to be displayed as the message to the user

function Cancel(action,iFr) {

	if (confirm(mess)) {
	
		if (action == 'goBack') {
			history.back(); return false;
		}
		
		if (action == 'closeFrame') {
			killFrame(iFr)
		}

		else {
			document.location=action; return false;
		}
	}
}

function CancelMdl(action) {

	if (confirm(mess)) {
	
		if (action == 'close') {
			window.close();
		}
		
		else {
			document.modal.action='mdl_'+action;
			document.modal.submit();
		}
	}
}


// VISUAL BASIC TO JAVASCRIPT YES/NO CANCELLATION CONFIRMATION DIALOG
// VB only supported in IE, reverts to javascript CONFIRM if IE not detected

title = 'Cancel Confirmation'; // title = a string to be displayed in the dialog title bar
icon = 1; // icon = an integer between 0 and 4, inclusive, denoting the icon to be displayed
defbut = 1; // defbut = an integer between 0 and 1, inclusive, denoting the default button; 0 = Yes; 1 = No
mods = 0; // mods = an integer, either 0 or 1, denoting the modality of the dialog; 0 = Application; 1 = System

function ynCancel(action) { // action = target location if confirmation is YES
	if (ie4) {
		icon = (icon==0) ? 0 : 2; // if not zero (0), value of 2 is assumed
		defbut = (defbut==0) ? 0 : 1; // if not zero (0), value of 1 is assumed
		retVal = makeMsgBox(title,mess,icon,4,defbut,mods); // value of 4 is hard-coded for YES/NO
		retVal = (retVal==6);

		if (retVal) {
		
			if (action == 'goBack') {
				history.back(); return false;
			}
			
			else {
				window.top.document.location=action; return false;
			}
		}
	}
	
	else {
	
		if (confirm(mess)) {
		
			if (action == 'goBack') {
				history.back(); return false;
			}
	
			else {
				window.top.document.location=action; return false;
			}
		}
	}
}

function ynCancelMdl() {
	icon = (icon==0) ? 0 : 2; // if not zero (0), value of 2 is assumed
	defbut = (defbut==0) ? 0 : 1; // if not zero (0), value of 1 is assumed
	retVal = makeMsgBox(title,mess,icon,4,defbut,mods); // value of 4 is hard-coded for YES/NO
	retVal = (retVal==6);

	if (retVal) {
		window.close();
	}
}