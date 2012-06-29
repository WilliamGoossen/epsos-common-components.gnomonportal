<script>
	function serialize(obj){
		for (el in obj){
			alert("> \t "+el+"="+obj[el]);
		}
	}
	/**
	 *	Accept number of the form : <COUNTRY_CODE>-<AREA CODE>-<NUMBER>-<EXT>
	 * 	
	 */
	function splitTelephoneNumber(wholeTelNumEl){
		try{//alert('splitTelephoneNumber');
			var formEl = wholeTelNumEl.form;
			
			//serialize(wholeTelNumEl);
			
			if (formEl != null) {
				var countryCodeEl = formEl.elements['countryCode'];
				var areaCodeEl = formEl.elements['areaCode'];
				var numberEl = formEl.elements['number'];
				var extensionEl = formEl.elements['extension'];
				
				var telNum = wholeTelNumEl.value;
				var tmpArr = telNum.split("-");
				
				if (tmpArr != null && (tmpArr.length == 3 || tmpArr.length == 4)) {
					countryCodeEl.value = tmpArr[0];
					areaCodeEl.value = tmpArr[1];
					numberEl.value = tmpArr[2];
					if (tmpArr.length == 4) {
						extensionEl.value = tmpArr[3];
					}else{
						extensionEl.value = '';
					}
				}else{
					countryCodeEl.value = '';
					areaCodeEl.value = '';
					numberEl.value =telNum;
					extensionEl.value = '';
				}
			}
			/*
			var countryCodeEl = document.getElementsByName('countryCode')[0];
			var areaCodeEl = document.getElementsByName('areaCode')[0];
			var numberEl = document.getElementsByName('number')[0];
			var extensionEl = document.getElementsByName('extension')[0];*/

			
		}catch(ex){	
			alert(ex);
		}
	}
</script>