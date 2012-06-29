<script>

var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) >= 4))

var isIE = !Nav4;
	function onFocusLost(el){
		//self.focus();
		if (self.focusComponent != null) {
			self.focusComponent.focus();
		}
	}

	function onLoadHDLR(){
		self.onBlur = onFocusLost;
		
		/*if (opener.parent){
			if (opener.parent.blockEvents == null){
				opener.parent.blockEvents = opener.unblockEvents;
			}
			opener.parent.blockEvents();
		}
		opener.blockEvents();*/
		
		window.onresize=disableUserResize;
		
		resizeView();
		// Store initial window size to use while resizing
		self.initWidth = document.getElementById("MainFrameBodyId").offsetWidth;
		self.initHeight = document.getElementById("MainFrameBodyId").offsetHeight;		
	}
	
	function disableUserResize(){
		if (isIE) return;
	
		// Fixing a problem of repeated resizing
		window.onresize=null;
	
	     //var x=document.getElementById("MainFrameBodyId").offsetWidth;
	     //var y=document.getElementById("MainFrameBodyId").offsetHeight;
		var x=self.initWidth;//document.getElementById("MainFrameBodyId").offsetWidth;  
		var y=self.initHeight;//document.getElementById("MainFrameBodyId").offsetHeight; 
		     
		     
		var wOffset = 15;
		var hOffset = (isIE) ? 15 : 25;
		if (!isIE && hOffset > (186-y)){
			hOffset += 25;
		}
	     window.resizeTo(x+wOffset, y+hOffset);
	
		// Fixing a problem of repeated resizing
	    setTimeout("window.onresize=disableUserResize;", 500);
	}
	
	function resizeView(){
    	try{
	        var tableEl = document.getElementById("MainFrameBodyId");
	        var topWindow = window;
	
	    	if (window.parent){
	        	// window is the iframe inside the ModalWindow
	        	// window.parent is the Modal Window
	            topWindow = window.parent;
	            var iframeEl = window.parent.document.getElementsByTagName("IFRAME")[0];
	    	    if (iframeEl){
	                iframeEl.width = tableEl.offsetWidth;//formEl.offsetWidth;
	                iframeEl.height = tableEl.offsetHeight + 10;//formEl.offsetHeight + 10;
	            }
	    	}else{
	            topWindow = window;
	        }
	
	        if (topWindow.dialogArguments){
	            //window.parent.resizeTo(iframeEl.width, iframeEl.height);
	            topWindow.dialogWidth = parseInt(iframeEl.width)+'px';
	            topWindow.dialogHeight = parseInt(iframeEl.height)+'px';
	        }else{
	            var tHeight = tableEl.offsetHeight;
	            if (typeof tableEl.height != "undefined" && tableEl.height != null && tableEl.height != "")
	            	tHeight=((tableEl.offsetHeight > parseInt(tableEl.height)) ? tableEl.offsetHeight: parseInt(tableEl.height)) + 10;
	
	            var wOffset = 15;
	            var hOffset = (isIE) ? 15 : 25;
	            //alert(tHeight+hOffset);
	            if (!isIE && hOffset > (186-tHeight)){
	                hOffset += 25;
	            }
	            topWindow.resizeTo(tableEl.offsetWidth +wOffset, tHeight+hOffset/*tableEl.offsetHeight+15*/);
	
	
	            // Put window to center of screen
	            /*var topOffsW = topWindow.document.documentElement.offsetWidth;
	            var topOffsH = topWindow.document.documentElement.offsetHeight;
	            var openerOffsW = topWindow.opener.document.documentElement.offsetWidth;
	            var openerOffsH = topWindow.opener.document.documentElement.offsetHeight;
	            if (isIE){
	
	                var winLeft = topWindow.opener.screenLeft + (openerOffsW - topOffsW)/2;
	                var winTop = topWindow.opener.screenTop + (openerOffsH - topOffsH)/2;
	
	                if (winLeft + topOffsW > screen.availWidth){
	                    winLeft = screen.availWidth - topOffsW;
	                    winLeft = (winLeft < 0) ? 0 : winLeft;
	                }
	                if (winTop + topOffsH > screen.availHeight){
	                    winTop = screen.availHeight - topOffsH;
	                    winTop = (winTop < 0) ? 0 : winTop;
	                }
	
	                topWindow.moveTo(winLeft, winTop);
	            }else{
	
	                var winLeft = topWindow.opener.screenX + (openerOffsW - topOffsW)/2;
	                var winTop = topWindow.opener.screenY + (openerOffsH - topOffsH)/2;
	
	                topWindow.moveTo(winLeft, winTop);
	            }*/
	
	        }
	
	        var firstFocusElement = document.getElementById("FIRST_FOCUS");
	        if (firstFocusElement) firstFocusElement.focus();
	    } catch(ex){
	    	alert("JavaScript EXCEPTION:"+ex.message);
	    }
	}
	function test_serializeObj(el){
		for (it in el) alert(it+"="+el[it]+"\n")
	}

	function onSelect(formName, radioName){
		onSelectSeparator(formName, radioName, "&")
	}
	
	function onSelectSeparator(formName, radioName, separator){
		try{
			var formEl = document.getElementsByName(formName)[0];
			
			var radioGroup = formEl.elements[radioName];
			var radioValue = null;
			
			//test_serializeObj(formEl.elements[radioName]);
			
			if (!radioGroup.length){
				radioValue = radioGroup.value;
			}else{
				for(var i=0; i<radioGroup.length; i++) {
					if (radioGroup[i].checked)
						break;
				}
				if (i == radioGroup.length){ // this means end of list was reached, no button was selected
					return; // do nothing
				}
				radioValue = radioGroup[i].value;
			}
			
			var openerIdEl = opener.document.<%= openerFormName%>.elements["<%= lookupFieldIdHtmlId%>"];
			var openerDisplEl = opener.document.<%= openerFormName%>.elements["<%= lookupFieldDisplHtmlId%>"];

			var strArr = radioValue.split(separator);
			openerIdEl.value=strArr[0];
			openerDisplEl.value=strArr[1];
			self.close();
		}catch(ex){
			alert("EXCEPTION \n"+ex.message);
		}
	}
	
	function onClear(){
		try{
			var openerIdEl = opener.document.<%= openerFormName%>.elements["<%= lookupFieldIdHtmlId%>"];
			var openerDisplEl = opener.document.<%= openerFormName%>.elements["<%= lookupFieldDisplHtmlId%>"];
			openerIdEl.value='';
			openerDisplEl.value='';
			self.close();
		}catch(ex){
			alert("EXCEPTION \n"+ex.message);
		}
	}
	
</script>

