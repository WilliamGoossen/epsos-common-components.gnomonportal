package com.ext.sql;

import java.util.Arrays;
import java.util.Hashtable;

public class StrutsFormFields {
	public static final int DEFAULT_FIELD_SIZE = 20;
	public static final int DEFAULT_TEXTAREA_COLS = 45;
	public static final int DEFAULT_TEXTAREA_ROWS = 6;
	public static final int DEFAULT_POPUP_WIDTH = 450;
	public static final int DEFAULT_POPUP_HEIGHT = 350;
	
	public static final String GNOMON_TOOLBAR = "gnomon";
	public static final String REDUCED_TOOLBAR = "gnomon_reduced";
	
	private String formFieldName;
	private String formFieldKey;
	private boolean required;
	private String formFieldType;
	private String value;
	private String DateFormat="";
	private boolean hidden;
	private boolean readonly = false;

	private int field_size = DEFAULT_FIELD_SIZE;
	private int textAreaCols = DEFAULT_TEXTAREA_COLS;
	private int textAreaRows = DEFAULT_TEXTAREA_ROWS;
	private int popupWidth = DEFAULT_POPUP_WIDTH;
	private int popupHeight = DEFAULT_POPUP_HEIGHT;
	private String collectionName; //for radios, select klp.
	private String collectionAttrName;
	private String collectionProperty; //for radios, select klp.
	private String collectionLabel;
	private java.util.List optionValues; //for radios, select klp.
	private java.util.List optionLabels; //for radios, select klp.
	private java.util.List selectedOptionValues; //for radios, select klp.
	private java.util.List optionHasChildren; // Used to mark the leaves in case of hierarchical options 
	private int multipleSelection=0; // for select-types
	private String onChange;
	private String alignment;
	private String textAreaToolBar = GNOMON_TOOLBAR;
	
	// For lookup field
	private String lookupAction;
	private Hashtable lookupParameters;

	// File upload
	private String uploadFilePath;
	
	// Image
	private String imageFileName;
	
	//colour
	private String colour="inherit";
	
	private String fieldWidth;
	
	private boolean secretTextField;

	// Image & Files!
	private String fileName;
	private String imgWidth = "32";
	private String imgHeight = "32";
	
	// Used with the form field type "link_text"
	private String onClick;
	// Used in form field type  "date". Shows a clear button.
	private boolean clearDate = true;
	
	private String column;
	private String helpMessage;
	private boolean dynamicField = false;
	
	/**
	 * This is used in dynamic fields of type "select" that take optional values
	 * from a hierarchic data source (tree).
	 */
	private boolean selectOnlyLeaves = false;
	

	public StrutsFormFields() {}

	public StrutsFormFields(String field,String key, String type, boolean hidden) {
		this.formFieldName=field;
		this.formFieldKey=key;
		this.formFieldType=type;
		this.hidden=hidden;
	}

	public StrutsFormFields(String field,String key, String type, boolean hidden, boolean readonly) {
		this.formFieldName=field;
		this.formFieldKey=key;
		this.formFieldType=type;
		this.hidden=hidden;
		this.readonly=readonly;
	}

	public StrutsFormFields(String field,String key, String type, boolean hidden, boolean readonly, boolean required) {
		this.formFieldName=field;
		this.formFieldKey=key;
		this.formFieldType=type;
		this.hidden=hidden;
		this.readonly=readonly;
		this.required = required;
	}

	/**
	 * Returns a comma separated values of the labels of the selected options.
	 * This is used in case of multiple selection
	 * @return
	 */
	public String getLabelForMultipleSelection(){
		String retStr = "";
		if (this.getMultipleSelection() > 0 && value != null){
			String[] valueParts = value.split(",");
			if (valueParts != null) {
				java.util.Arrays.sort(valueParts);
				for (int i = 0; i < optionValues.size(); i++){
					if (Arrays.binarySearch(valueParts, optionValues.get(i)) >= 0){
						retStr += (retStr.equals("")) ? "" : ", ";
						retStr += optionLabels.get(i);
					}
				}
			}
		}
		return retStr;
	}
	
	public boolean isClearDate() {
		return clearDate;
	}

	public void setClearDate(boolean clearDate) {
		this.clearDate = clearDate;
	}

	public String getOnClick() {
		return onClick;
	}

	public void setOnClick(String onClick) {
		this.onClick = onClick;
	}

	public String getDateFormat() {
		return DateFormat;
	}


	public void setDateFormat(String dateFormat) {
		DateFormat = dateFormat;
	}


	public int getField_size() {
		return field_size;
	}


	public void setField_size(int field_size) {
		this.field_size = field_size;
	}


	public String getFormFieldKey() {
		return formFieldKey;
	}


	public void setFormFieldKey(String formFieldKey) {
		this.formFieldKey = formFieldKey;
	}


	public String getFormFieldName() {
		return formFieldName;
	}


	public void setFormFieldName(String formFieldName) {
		this.formFieldName = formFieldName;
	}


	public String getFormFieldType() {
		return formFieldType;
	}


	public void setFormFieldType(String formFieldType) {
		this.formFieldType = formFieldType;
	}




	public String getCollectionLabel() {
		return collectionLabel;
	}


	public void setCollectionLabel(String collectionLabel) {
		this.collectionLabel = collectionLabel;
	}


	public String getCollectionName() {
		return collectionName;
	}


	public void setCollectionName(String collectionName) {
		this.collectionName = collectionName;
	}


	public String getCollectionProperty() {
		return collectionProperty;
	}


	public void setCollectionProperty(String collectionProperty) {
		this.collectionProperty = collectionProperty;
	}


	public boolean isRequired() {
		return required;
	}


	public void setRequired(boolean required) {
		this.required = required;
	}

	public boolean isReadonly() {
		return readonly;
	}


	public void setReadonly(boolean readonly) {
		this.readonly = readonly;
	}

	public String getValue() {
		return value;
	}


	public void setValue(String value) {
		this.value = value;
	}


	public boolean isHidden() {
		return hidden;
	}


	public void setHidden(boolean hidden) {
		this.hidden = hidden;
	}

	public String getOnChange() {
		return onChange;
	}

	public void setOnChange(String onChange) {
		this.onChange = onChange;
	}

	public String getLookupAction() {
		return lookupAction;
	}

	public void setLookupAction(String lookupAction) {
		this.lookupAction = lookupAction;
	}

	public Hashtable getLookupParameters() {
		return lookupParameters;
	}

	public void setLookupParameters(Hashtable lookupParameters) {
		this.lookupParameters = lookupParameters;
	}

	public String getUploadFilePath() {
		return uploadFilePath;
	}

	public void setUploadFilePath(String uploadFilePath) {
		this.uploadFilePath = uploadFilePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getImgWidth() {
		return imgWidth;
	}

	public void setImgWidth(String imgWidth) {
		this.imgWidth = imgWidth;
	}

	public String getImgHeight() {
		return imgHeight;
	}

	public void setImgHeight(String imgHeight) {
		this.imgHeight = imgHeight;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public java.util.List getOptionLabels() {
		return optionLabels;
	}

	public void setOptionLabels(java.util.List optionLabels) {
		this.optionLabels = optionLabels;
	}

	public java.util.List getOptionValues() {
		return optionValues;
	}

	public void setOptionValues(java.util.List optionValues) {
		this.optionValues = optionValues;
	}
	public java.util.List getOptionHasChildren() {
		return optionHasChildren;
	}

	public void setOptionHasChildren(java.util.List optionHasChildren) {
		this.optionHasChildren = optionHasChildren;
	}

	public int getMultipleSelection() {
		return multipleSelection;
	}

	public void setMultipleSelection(int multipleSelection) {
		this.multipleSelection = multipleSelection;
	}

	public String getFieldWidth() {
		return fieldWidth;
	}

	public void setFieldWidth(String fieldWidth) {
		this.fieldWidth = fieldWidth;
	}

	public String getAlignment() {
		return alignment;
	}

	public void setAlignment(String alignment) {
		this.alignment = alignment;
	}

	public boolean isSecretTextField() {
		return secretTextField;
	}

	public void setSecretTextField(boolean secretTextField) {
		this.secretTextField = secretTextField;
	}

	public String getColour() {
		return colour;
	}

	public void setColour(String colour) {
		this.colour = colour;
	}

	public String getCollectionAttrName() {
		return collectionAttrName;
	}

	public void setCollectionAttrName(String collectionAttrName) {
		this.collectionAttrName = collectionAttrName;
	}

	public boolean isSelectOnlyLeaves() {
		return selectOnlyLeaves;
	}

	public void setSelectOnlyLeaves(boolean selectOnlyLeaves) {
		this.selectOnlyLeaves = selectOnlyLeaves;
	}
	
	
		/**
	 * @return the selectedOptionValues
	 */
	public java.util.List getSelectedOptionValues() {
		return selectedOptionValues;
	}

	/**
	 * @param selectedOptionValues the selectedOptionValues to set
	 */
	public void setSelectedOptionValues(java.util.List selectedOptionValues) {
		this.selectedOptionValues = selectedOptionValues;
	}

	public String getHelpMessage() {
		return helpMessage;
	}

	public void setHelpMessage(String helpMessage) {
		this.helpMessage = helpMessage;
	}

	public int getTextAreaCols() {
		return textAreaCols;
	}

	public void setTextAreaCols(int textAreaCols) {
		this.textAreaCols = textAreaCols;
	}

	public int getTextAreaRows() {
		return textAreaRows;
	}

	public void setTextAreaRows(int textAreaRows) {
		this.textAreaRows = textAreaRows;
	}

	public int getPopupHeight() {
		return popupHeight;
	}

	public void setPopupHeight(int popupHeight) {
		this.popupHeight = popupHeight;
	}

	public int getPopupWidth() {
		return popupWidth;
	}

	public void setPopupWidth(int popupWidth) {
		this.popupWidth = popupWidth;
	}

	public boolean isDynamicField() {
		return dynamicField;
	}

	public void setDynamicField(boolean dynamicField) {
		this.dynamicField = dynamicField;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getTextAreaToolBar() {
		return textAreaToolBar;
	}

	public void setTextAreaToolBar(String textAreaToolBar) {
		this.textAreaToolBar = textAreaToolBar;
	}
	
}