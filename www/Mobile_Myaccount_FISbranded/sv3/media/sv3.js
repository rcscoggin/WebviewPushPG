///////////////////////////////////////////////////////////////////////////
//
// Filename: sv3.js
//
//
///////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
//
// SV3 Javascript Library v1.0
//
// History:
//  DSP 20050415 Initial Write
///////////////////////////////////////////////////////////////////////////

// Input button highliter

function cls(obj,cls)
{
	obj.className=cls;
}

// DIV SWAPPER

function showDIV(divName){
	document.getElementById(divName).style.display = 'block';
	document.getElementById(divName).style.visibility='visible';
}

function hideDIV(divName){
	document.getElementById(divName).style.visibility='hidden';
	document.getElementById(divName).style.display = 'none';
}

