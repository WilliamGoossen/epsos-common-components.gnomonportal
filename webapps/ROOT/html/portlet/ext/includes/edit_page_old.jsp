 

<%
Vector items = (Vector) request.getAttribute(request_itemname);
Hashtable item=null;


String current_language="";

boolean isTranslationPage=false;


/*************** INITIALIZE FORM BUTTONS *******************/

boolean buttonSave=true;
boolean buttonAdd=true;
boolean buttonAddTrans=true;
boolean buttonCancel=true;
boolean buttonUpdate=true;
boolean buttonDelete=true;
boolean buttonDeleteTrans=true;
boolean buttonSaveTrans=false;

String labelSave="save";
String labelAdd= "add";
String labelAddTrans= "add-translation";
String labelCanel="cancel";
String labelUpdate="update";
String labelDelete="delete";
String labelDeleteTrans="delete-this-translation";
String labelSaveTrans="save";
String msgDelete = "are-you-sure-you-want-to-delete-this-item";
String msgDeleteTrans = "are-you-sure-you-want-to-delete-this-translation";

String  onclickSaveTrans="";
String  onclickSave="";
String onclickAdd="";
String onclickAddTrans="";
String onclickCancel="";
String onclickUpdate="";
String onclickDelete="";
String onclickDeleteTrans="";


if(items!=null && items.size() >0)
	item = (Hashtable)items.get(0);

	
/************ GET THE TRANSLATION ************/	
Vector availableTranslations = (Vector)request.getAttribute("existTrans");
Vector availableLanguages = (Vector)request.getAttribute("availLang");

/********** GET THE ROW ******************/
int fieldIndex;
formFields myfield;
String value;
for(fieldIndex=0; fieldIndex < fields.size(); fieldIndex++) {
	if (item != null) {
	  myfield = (formFields) fields.get(fieldIndex);
	  //System.out.println(myfield.getFieldName());
	  value = item.get(myfield.getFieldName()).toString();
	  //System.out.println(value);
	  if (myfield.isLanguage())
	  	current_language = value;
	  myfield.setValue( value );	
	}
}
%>

