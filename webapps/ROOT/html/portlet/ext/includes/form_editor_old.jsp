
<SCRIPT language=JavaScript>
	
function initEditor() {
var temp;
<%if (isStrutsPage==true) { %>
temp = <portlet:namespace/>fm.<portlet:namespace/><%=formFieldName %>.value;
<%} else { %>
temp = fm.<%=formFieldName %>.value;
<%} %>


		return escape(temp);
	}
	

	function <%=formFieldName %>_saveArticle() {
var  myservername="http://<%=request.getServerName() %>";
var myimg="";
var myport=<%=request.getServerPort() %>;
if(myport!=80)
	myservername=myservername + ":" + myport ;

	myimg= myservername;
	myservername = myservername + "/html/js/editor/editor.html";

	
	
	var mysrc;
	<%if(isStrutsPage==true) { %>
	 mysrc = parent.<portlet:namespace/><%=formFieldName%>_editor.getHTML();
	 
	 	<%} else { %>
 mysrc = parent.<%=formFieldName%>_editor.getHTML();
 <%} %>

while(mysrc.indexOf(myservername) >=0)
	mysrc=mysrc.replace(myservername,"");
	
while(mysrc.indexOf(myimg) >=0)
	mysrc=mysrc.replace(myimg,"");

;
	mysrc=doCleanCode(mysrc);

		//document.fm.<%=formFieldName %>.value = parent.<%=formFieldName%>_editor.getHTML();
		<%if (isStrutsPage==true) { %>
				document.<portlet:namespace/>fm.<portlet:namespace/><%=formFieldName %>.value =mysrc;
		<%} else { %>
		document.fm.<%=formFieldName %>.value =mysrc;
		<%} %>
//		submitForm(document.fm);
	}
	
	
	////
		function setHTMLTextarea() {

		var  myservername="http://<%=request.getServerName() %>";
var myport=<%=request.getServerPort() %>;
if(myport!=80)
	myservername=myservername + ":" + myport ;
	myimg= myservername;
	myservername = myservername + "/html/js/editor/editor.html";

	
var mysrc;
	<%if(isStrutsPage==true) { %>
	 mysrc = parent.<portlet:namespace/><%=formFieldName%>_editor.getHTML();
	<%} else { %>
 mysrc = parent.<%=formFieldName%>_editor.getHTML();
 <%} %>

	
	while(mysrc.indexOf(myservername) >=0)
		mysrc=mysrc.replace(myservername,"");
		
		while(mysrc.indexOf(myimg) >=0)
	mysrc=mysrc.replace(myimg,"");

	
	
	mysrc=doCleanCode(mysrc);
	
	<%if (isStrutsPage==true) { %>
				document.<portlet:namespace/>fm.<portlet:namespace/><%=formFieldName %>.value =mysrc;
	<%} else { %>
			document.fm.<%=formFieldName %>.value =mysrc;
			<%}%>
//		document.fm.<%=formFieldName %>.value = parent.<%=formFieldName%>_editor.getHTML();
	//	submitForm(document.fm);
	}



function doCleanCode(strx)
{   


strx =strx.replace(/\r/g,"");
strx =strx.replace(/\n>/g,">");
strx =strx.replace(/>\n/g,">");
strx =strx.replace(/\n/g," ");
strx =strx.replace(/\\/g,"&#92;");
strx =strx.replace(/\'/g,"&#39;");

// Security
/*
if(SECURE==1)
{
strx =strx.replace(/<meta/ig,"< meta")
strx =strx.replace(/&lt;meta/ig,"&lt; meta")
strx =strx.replace(/<script/ig,"< script")
strx =strx.replace(/&lt;script/ig,"&lt; script")
strx =strx.replace(/<\/script/ig,"< /script")
strx =strx.replace(/&lt;\/script/ig,"&lt; /script")
strx =strx.replace(/<iframe/ig,"< iframe")
strx =strx.replace(/&lt;iframe/ig,"&lt; iframe")
strx =strx.replace(/<\/iframe/ig,"< /iframe")
strx =strx.replace(/&lt;\/iframe/ig,"&lt; /iframe")
strx =strx.replace(/<object/ig,"< object")
strx =strx.replace(/&lt;object/ig,"&lt; object")
strx =strx.replace(/<\/object/ig,"< /object")
strx =strx.replace(/&lt;\/object/ig,"&lt; /object")
strx =strx.replace(/<applet/ig,"< applet")
strx =strx.replace(/&lt;applet/ig,"&lt; applet")
strx =strx.replace(/<\/applet/ig,"< /applet")
strx =strx.replace(/&lt;\/applet/ig,"&lt; /applet")
strx =strx.replace(/ on/ig," o&shy;n")
strx =strx.replace(/script:/ig,"script&shy;:")
}
*/



// -


var mys= String.fromCharCode(8211);

while(strx.indexOf(mys)>=0)
	strx = strx.replace(mys, "-");

// "
mys= String.fromCharCode(8220);

while(strx.indexOf(mys)>=0)
	strx = strx.replace(mys, "\"");
//"
	mys= String.fromCharCode(8221);

while(strx.indexOf(mys)>=0)
	strx = strx.replace(mys, "\"");

	
   strx = strx.replace(/(<html)([^>]*)/i, "$1");


   strx = strx.replace(/<\/?SPAN[^>]*>/gmi,"");

  
   strx = strx.replace(/<\/st1:address>(<\/st1:\w*>)?<\/p>[\n\r\s]*<p[\s\w="']*>/gi, "<br>");

   // Remove all instances of <o:p></o:p>
   strx = strx.replace(/<o:p>/g, "");
   strx = strx.replace(/<\/o:p>/g, "");
   strx = strx.replace(/<o:SmartTagType[^>]*>/g, "");

   // Remove all instances of <st1:whatever></st1:whatever>
   strx = strx.replace(/<st1:[\w\s"=]*>/gi, "");
   strx = strx.replace(/<\/st1:\w*>/gi, "");

      // This finds the mso-*:"SomeStuff"; style attributes and sets them to be nothing.
   strx = strx.replace(/mso-[^:]*:"[^"]*";/g, "");



   
//alert(strx);

   strx = strx.replace(/\/?style=[^>]*>/gmi,">");

//	 alert(strx);

   
   // This finds the other mso-* style attibutes.
   strx = strx.replace(/mso-[^;'"]*;*(\n|\r)*/g, "");

   // Remove some other Word-only css style attributes.
   strx = strx.replace(/page-break-after[^;]*;/g, "");
   //strx = strx.replace(/ style=['"]tab-interval:[^'"]*['"]/g, "");
//GNOMONSA END

// get rid of ugly colon tags <a:b> or </a:b>
//code =code.replace(/<\/?\w+:[^>]*>/gi,"")
// removes all empty <p> tags
//strx =strx.replace(/<p([^>])*>(&nbsp;)*\s*<\/p>/gi,"");
// removes all empty span tags
strx =strx.replace(/<span([^>])*>(&nbsp;)*\s*<\/span>/gi,"");


strx =strx.replace(/<FONT([^>])*>/gi,"");
strx =strx.replace(/<\/FONT>/gi,"");


while(strx.indexOf("class=MsoNormal")>=0)
	strx= strx.replace("class=MsoNormal","class=PageText");
while(strx.indexOf("class=MsoBodyText")>=0)
	strx= strx.replace("class=MsoBodyText","class=PageText");
while(strx.indexOf("MsoBodyText3")>=0)
	strx= strx.replace("MsoBodyText3","PageText");
while(strx.indexOf("PageText3")>=0)
	strx= strx.replace("PageText3","PageText");

//strx =strx.replace(/<P([^>])*><STRONG([^>])*>(&nbsp;)*\s*<\/STRONG><\/P>/gi,"");

//  strx = strx.replace(/<\?xml([^>])*\/>/gi,"");

return strx;
}

	
</SCRIPT>
