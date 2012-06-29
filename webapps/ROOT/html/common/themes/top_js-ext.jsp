<%
/**
 * Copyright (c) 2000-2006 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<script src="<%= themeDisplay.getPathJavaScript() %>/cms_menu.js" type="text/javascript"></script>
<script src="<%= themeDisplay.getPathJavaScript() %>/ui_utils.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%= themeDisplay.getPathJavaScript() %>/thickbox/thickbox.css" type="text/css" media="screen" />


<% if ("print".equals(request.getParameter("p_p_mode"))) {%>
<div class="button-holder" id="buttonDiv" style="text-align:right">
<a title="<%= LanguageUtil.get(pageContext, "print") %>" href="#" onClick="document.getElementById('buttonDiv').style.display='none'; window.print();">
<img alt="<%= LanguageUtil.get(pageContext, "print") %>" src="<%= themeDisplay.getPathThemeImage() %>/common/print.png">&nbsp;<%= LanguageUtil.get(pageContext, "print") %>
</div>
	<%
}
%>


<script language="JavaScript">
//global variable to hold dynamic form fields mutual filtering information
var _top_filterTable = new Array();
// global variable to hold dynamic form fields original options settings
var _top_allFieldsOptions = new Array();

// an object to hold information about the filtered values of a given form field
function _top_filterTableEntry(feature2, valuesArray)
{
   this.f2 = feature2;
   this.values = valuesArray;
}

// the event callback function to filter out options of form fields based on a 
// currently selected value for the given form element and the information stored
// in the filter table array, in the formatof filter table entry objects
function _top_updateOptionsFor(formName, formElement, selectedValue) 
 {
     if (_top_filterTable[formName+"_"+formElement]) 
    {
       var f;
       for (f=0; f<_top_filterTable[formName+"_"+formElement].length; f++)
       {
           var tableEntry = _top_filterTable[formName+"_"+formElement][f];
           var originalOptions = _top_allFieldsOptions[formName+"_"+tableEntry.f2];
           if (originalOptions != null) {
	           var optionsToReduce = new Array();
	           var o;
	           for(o=0; o<originalOptions.length; o++) {
	           		optionsToReduce[o] = originalOptions[o];
	           }
	           // only do something if there is a filter defined for the given value
	           if (tableEntry.values[selectedValue])
	           {
		           	 // make certain that the affected fields are set to the empty selection (value:0)
		           	 // document.forms[formName].elements[tableEntry.f2].selectedIndex = 0;
		           	 // in case this field had some filters of its own, recursively call the update function
		           	 // updateOptionsFor(formName, tableEntry.f2, "");
		           	 // then filter the options for the given selection
		             var i;
		             for (i=0; i < optionsToReduce.length; i++ ) {
		                var option = optionsToReduce[i];
		                var found = false;
		                if (optionsToReduce[i].value == "") found = true;
		                var j=0;
		                while (!found && j<tableEntry.values[selectedValue].length)
		                {
		                      if (option.value == tableEntry.values[selectedValue][j])
		                         found=true;
		                      j++;
		                }
		                if (!found)
		                {
		                   optionsToReduce[i] = null;
		                   //if (i == document.forms[formName].elements[tableEntry.f2].selectedIndex)
		                   //		document.forms[formName].elements[tableEntry.f2].selectedIndex = 0;
		                }
		             }
	           }
	           
	           var filteredListBoxName = tableEntry.f2;
		       var listObj = document.forms[formName].elements[filteredListBoxName];
		       if (listObj.options == null && listObj.selectedIndex == null)
		       {
		       		// this is the case if the filtered listbox is disabled, then its actual name has an extra underscore
		       		filteredListBoxName = tableEntry.f2+"_";
		       		listObj = document.forms[formName].elements[filteredListBoxName];
		       }
		       var oldOptions = document.forms[formName].elements[filteredListBoxName].options ;
		       var selectedOption = "";
		       if (listObj != null &&
		           listObj.selectedIndex != null &&
		           listObj.selectedIndex != 0)
		       		selectedOption = ""+listObj.options[listObj.selectedIndex].value;
		       // remove all old entries
		       while(oldOptions.length) { listObj.remove(0);}
		       // copy over reduced entries
		       var n, newSelectedIndex = 0, currentIndex = 0;
		       for(n=0; n<optionsToReduce.length; n++)
		       {
		       		if (optionsToReduce[n] != null)
		       		{
		       			oldOptions.add(optionsToReduce[n]);
		       			if (optionsToReduce[n].value == selectedOption)
		       			{
		       				newSelectedIndex = currentIndex;
		       			}
		       			currentIndex ++;
		       		}
		       }
		       listObj.selectedIndex = newSelectedIndex;
		     }
	     }
    }
    return true;
}

</script>

