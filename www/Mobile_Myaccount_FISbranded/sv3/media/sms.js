$(document).ready(function() {

	//Country Combo event
	$('#country').bind('change', function(){
	
	var country = $('#country').val();
		var e = new sms();
		e.setHTTPMethod("post");
		e.setForm('form1');
		e.setCallbackHandler(get_carrrier_callbackHandler);
		e.setErrorHandler(errorHandler);			
		e.getcarriers();
	});

	function get_carrrier_callbackHandler(carrier_list)
	{
		alert(carrier_list);
		var carriers= carrier_list.split('|');		
		if(carriers.length > 0)
		{
			var Carrier = "";

			if(carriers != "")
			{
				$('#carrier').empty();
				$("<option value=''>Choose...</option>").appendTo('#carrier');
				for (i=0;i<carriers.length;i++){
					
					Carrier = carriers[i];
					var carriersData= Carrier.split('^');
					$("<option value='"+carriersData[0]+"'>"+carriersData[1]+"</option>").appendTo('#carrier');
				}				
				$("#carrier option[text=Choose...]").attr("selected","selected") ;
			}
		}
	}
	
	

	// Common error handler for all asynchronous calls
	function errorHandler(code, msg)
	{
		alert("Error!!! " + code + ": " + msg);
	}

});