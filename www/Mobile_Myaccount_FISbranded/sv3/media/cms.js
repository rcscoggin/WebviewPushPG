var tmpDomain = "";

if (window.location.hostname.length > 0)
	tmpDomain = window.location.hostname;
/*
else if (window.parent != undefined && window.parent != null)
	tmpDomain = window.parent.location.hostname;
else if (window.opener != undefined && window.opener != null)
	tmpDomain = window.opener.location.hostname;
*/

if (tmpDomain.length > 0)
{
	var tmpAry = tmpDomain.split(".");
	if (tmpAry.length > 1)
		tmpDomain = tmpAry[tmpAry.length-2] + "." + tmpAry[tmpAry.length-1]
	document.domain = tmpDomain;
	tmpAry = "";
	tmpDomain = "";
}

function reloadSelf()
{
	self.location.reload();
}

