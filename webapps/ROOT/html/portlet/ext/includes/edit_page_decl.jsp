 

<%
Vector items =null; 
Hashtable item=null;

boolean area_labels=false;
boolean show_empty_fields=true;
int pageColumns=1;
int remainCols=0;

boolean showLabels=true;
boolean showEdit=true;
Vector items_topics =null; 
Hashtable item_topic=null;
ItemContentTopicModel content_topic;
boolean topicnamedisabled=true;


PortletSettingsModel settingsModel;
Vector pSettings=null;
Hashtable pSettingsRow = null;
String portletApproval="0";

String checkpermission="";
String onSubmitBody1="";
settingsModel = new PortletSettingsModel();
pSettings = settingsModel.selectOneRow(thisPortletId, company.getCompanyId() );
if(pSettings!=null && pSettings.size() >0) {
	pSettingsRow =(Hashtable) pSettings.get(0);
	if(pSettingsRow!=null) {
		portletApproval = pSettingsRow.get("HAS_APPROVAL").toString();
	}
}

Throwable genException = (Throwable) request.getAttribute(PageContext.EXCEPTION);	 

int addIndexParam=-1;

String current_language="";

boolean isTranslationPage=false;
boolean isStrutsPage =false;
ActionException ae ;

Vector throwedExceptions;
int throwedIndex=0;
String generalException =  "com.ext.sql.ValidationException";
String commonExceptions[]= {"com.ext.sql.InvalidDateException",
 "com.ext.sql.InvalidNumberException",
 "com.ext.sql.InvalidSizeException",
 "com.ext.sql.NullNotAllowedException"}; 
 
 String commonExceptionsFields[] ={"","","",""};
  String commonExceptionsMessages[] ={"InvalidDateException","InvalidNumberException","InvalidSizeException","NullNotAllowedException"};

int exceptionsIndex;

/************ for formfield ***/

int index=0;
formFields form_field;
String fieldName;
String formFieldName;
boolean required;
String formType;
String formValue;
String defaultValue;
String exceptionName;
String exceptionMessage;
String fieldTitle;
int fieldSize;
String optionNames[];
String optionValues[];
String optionSelected[];
boolean show;
String formPathUrl;
boolean inOneRow=false;
String fieldDateFormat="";
String formStyle="";

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

	
/************ GET THE TRANSLATION ************/	
Vector availableTranslations = null;
Vector availableLanguages = null;

/********** GET THE ROW ******************/
int fieldIndex;
formFields myfield;
String value;
String StrutsParamNames[]={""};


String disp_def_myspanstyle="gamma1";
String disp_def_myrefstyle="gamma1";
//String def_myrefstyle="alpha1"; - Allagi Stelios 13/7

String disp_myspanstyle="gamma1";
String disp_myrefstyle="gamma1";
//String myrefstyle="alpha1"; - Allagi Stelios 13/7

//String labelsStyle="sub3"; - Allagi Stelios 13/7
//String disp_labelsStyle="alpha1"; - Allagi Stelios 26/9
String disp_labelsStyle="gamma1-FormText";
String disp_labelsLine="subLine";
%>

