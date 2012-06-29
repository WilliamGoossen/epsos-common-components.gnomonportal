package com.ext.sql;

import java.util.Arrays;
import java.util.Hashtable;

// TODO: Auto-generated Javadoc
/**
 * The Class StrutsFormFields2.
 */
public class StrutsFormFields2 {
	
	/** The Constant DEFAULT_FIELD_SIZE. */
	public static final int DEFAULT_FIELD_SIZE = 20;
	
	/** The Constant DEFAULT_TEXTAREA_COLS. */
	public static final int DEFAULT_TEXTAREA_COLS = 45;
	
	/** The Constant DEFAULT_TEXTAREA_ROWS. */
	public static final int DEFAULT_TEXTAREA_ROWS = 6;
	
	/** The Constant DEFAULT_POPUP_WIDTH. */
	public static final int DEFAULT_POPUP_WIDTH = 450;
	
	/** The Constant DEFAULT_POPUP_HEIGHT. */
	public static final int DEFAULT_POPUP_HEIGHT = 350;
	
	/** The Constant GNOMON_TOOLBAR. */
	public static final String GNOMON_TOOLBAR = "gnomon";
	
	/** The Constant REDUCED_TOOLBAR. */
	public static final String REDUCED_TOOLBAR = "gnomon_reduced";
	
	/** The form field name. */
	private String formFieldName;
	
	/** The form field key. */
	private String formFieldKey;
	
	/** The required. */
	private boolean required;
	
	/** The form field type. */
	private String formFieldType;
	
	/** The value. */
	private String value;
	
	/** The Date format. */
	private String DateFormat="";
	
	/** The hidden. */
	private boolean hidden;
	
	/** The readonly. */
	private boolean readonly = false;

	/** The field_size. */
	private int field_size = DEFAULT_FIELD_SIZE;
	
	/** The text area cols. */
	private int textAreaCols = DEFAULT_TEXTAREA_COLS;
	
	/** The text area rows. */
	private int textAreaRows = DEFAULT_TEXTAREA_ROWS;
	
	/** The popup width. */
	private int popupWidth = DEFAULT_POPUP_WIDTH;
	
	/** The popup height. */
	private int popupHeight = DEFAULT_POPUP_HEIGHT;
	
	/** The collection name. */
	private String collectionName; //for radios, select klp.
	
	/** The collection attr name. */
	private String collectionAttrName;
	
	/** The collection property. */
	private String collectionProperty; //for radios, select klp.
	
	/** The collection label. */
	private String collectionLabel;
	
	/** The multiple selection. */
	private int multipleSelection=0; // for select-types
	
	/** The on change. */
	private String onChange;
	
	/** The alignment. */
	private String alignment;
	
	/** The text area tool bar. */
	private String textAreaToolBar = GNOMON_TOOLBAR;
	
	// For lookup field
	/** The lookup action. */
	private String lookupAction;
	
	/** The lookup parameters. */
	private Hashtable lookupParameters;

	// File upload
	/** The upload file path. */
	private String uploadFilePath;
	
	// Image
	/** The image file name. */
	private String imageFileName;
	
	//colour
	/** The colour. */
	private String colour="inherit";
	
	/** The field width. */
	private String fieldWidth;
	
	/** The secret text field. */
	private boolean secretTextField;

	// Image & Files!
	/** The file name. */
	private String fileName;
	
	/** The img width. */
	private String imgWidth = "32";
	
	/** The img height. */
	private String imgHeight = "32";
	
	// Used with the form field type "link_text"
	/** The on click. */
	private String onClick;
	// Used in form field type  "date". Shows a clear button.
	/** The clear date. */
	private boolean clearDate = true;
	
	/** The column. */
	private String column;
	
	/** The help message. */
	private String helpMessage;
	
	/** The dynamic field. */
	private boolean dynamicField = false;
	
	/**
	 * This is used in dynamic fields of type "select" that take optional values
	 * from a hierarchic data source (tree).
	 */
	private boolean selectOnlyLeaves = false;
	

	/**
	 * Instantiates a new struts form fields2.
	 */
	public StrutsFormFields2() {}

	/**
	 * Instantiates a new struts form fields2.
	 *
	 * @param field the field
	 * @param key the key
	 * @param type the type
	 * @param hidden the hidden
	 */
	public StrutsFormFields2(String field,String key, String type, boolean hidden) {
		this.formFieldName=field;
		this.formFieldKey=key;
		this.formFieldType=type;
		this.hidden=hidden;
	}

	/**
	 * Instantiates a new struts form fields2.
	 *
	 * @param field the field
	 * @param key the key
	 * @param type the type
	 * @param hidden the hidden
	 * @param readonly the readonly
	 */
	public StrutsFormFields2(String field,String key, String type, boolean hidden, boolean readonly) {
		this.formFieldName=field;
		this.formFieldKey=key;
		this.formFieldType=type;
		this.hidden=hidden;
		this.readonly=readonly;
	}

	/**
	 * Instantiates a new struts form fields2.
	 *
	 * @param field the field
	 * @param key the key
	 * @param type the type
	 * @param hidden the hidden
	 * @param readonly the readonly
	 * @param required the required
	 */
	public StrutsFormFields2(String field,String key, String type, boolean hidden, boolean readonly, boolean required) {
		this.formFieldName=field;
		this.formFieldKey=key;
		this.formFieldType=type;
		this.hidden=hidden;
		this.readonly=readonly;
		this.required = required;
	}


	/**
	 * Checks if is clear date.
	 *
	 * @return true, if is clear date
	 */
	public boolean isClearDate() {
		return clearDate;
	}

	/**
	 * Sets the clear date.
	 *
	 * @param clearDate the new clear date
	 */
	public void setClearDate(boolean clearDate) {
		this.clearDate = clearDate;
	}

	/**
	 * Gets the on click.
	 *
	 * @return the on click
	 */
	public String getOnClick() {
		return onClick;
	}

	/**
	 * Sets the on click.
	 *
	 * @param onClick the new on click
	 */
	public void setOnClick(String onClick) {
		this.onClick = onClick;
	}

	/**
	 * Gets the date format.
	 *
	 * @return the date format
	 */
	public String getDateFormat() {
		return DateFormat;
	}


	/**
	 * Sets the date format.
	 *
	 * @param dateFormat the new date format
	 */
	public void setDateFormat(String dateFormat) {
		DateFormat = dateFormat;
	}


	/**
	 * Gets the field_size.
	 *
	 * @return the field_size
	 */
	public int getField_size() {
		return field_size;
	}


	/**
	 * Sets the field_size.
	 *
	 * @param field_size the new field_size
	 */
	public void setField_size(int field_size) {
		this.field_size = field_size;
	}


	/**
	 * Gets the form field key.
	 *
	 * @return the form field key
	 */
	public String getFormFieldKey() {
		return formFieldKey;
	}


	/**
	 * Sets the form field key.
	 *
	 * @param formFieldKey the new form field key
	 */
	public void setFormFieldKey(String formFieldKey) {
		this.formFieldKey = formFieldKey;
	}


	/**
	 * Gets the form field name.
	 *
	 * @return the form field name
	 */
	public String getFormFieldName() {
		return formFieldName;
	}


	/**
	 * Sets the form field name.
	 *
	 * @param formFieldName the new form field name
	 */
	public void setFormFieldName(String formFieldName) {
		this.formFieldName = formFieldName;
	}


	/**
	 * Gets the form field type.
	 *
	 * @return the form field type
	 */
	public String getFormFieldType() {
		return formFieldType;
	}


	/**
	 * Sets the form field type.
	 *
	 * @param formFieldType the new form field type
	 */
	public void setFormFieldType(String formFieldType) {
		this.formFieldType = formFieldType;
	}




	/**
	 * Gets the collection label.
	 *
	 * @return the collection label
	 */
	public String getCollectionLabel() {
		return collectionLabel;
	}


	/**
	 * Sets the collection label.
	 *
	 * @param collectionLabel the new collection label
	 */
	public void setCollectionLabel(String collectionLabel) {
		this.collectionLabel = collectionLabel;
	}


	/**
	 * Gets the collection name.
	 *
	 * @return the collection name
	 */
	public String getCollectionName() {
		return collectionName;
	}


	/**
	 * Sets the collection name.
	 *
	 * @param collectionName the new collection name
	 */
	public void setCollectionName(String collectionName) {
		this.collectionName = collectionName;
	}


	/**
	 * Gets the collection property.
	 *
	 * @return the collection property
	 */
	public String getCollectionProperty() {
		return collectionProperty;
	}


	/**
	 * Sets the collection property.
	 *
	 * @param collectionProperty the new collection property
	 */
	public void setCollectionProperty(String collectionProperty) {
		this.collectionProperty = collectionProperty;
	}


	/**
	 * Checks if is required.
	 *
	 * @return true, if is required
	 */
	public boolean isRequired() {
		return required;
	}


	/**
	 * Sets the required.
	 *
	 * @param required the new required
	 */
	public void setRequired(boolean required) {
		this.required = required;
	}

	/**
	 * Checks if is readonly.
	 *
	 * @return true, if is readonly
	 */
	public boolean isReadonly() {
		return readonly;
	}


	/**
	 * Sets the readonly.
	 *
	 * @param readonly the new readonly
	 */
	public void setReadonly(boolean readonly) {
		this.readonly = readonly;
	}

	/**
	 * Gets the value.
	 *
	 * @return the value
	 */
	public String getValue() {
		return value;
	}


	/**
	 * Sets the value.
	 *
	 * @param value the new value
	 */
	public void setValue(String value) {
		this.value = value;
	}


	/**
	 * Checks if is hidden.
	 *
	 * @return true, if is hidden
	 */
	public boolean isHidden() {
		return hidden;
	}


	/**
	 * Sets the hidden.
	 *
	 * @param hidden the new hidden
	 */
	public void setHidden(boolean hidden) {
		this.hidden = hidden;
	}

	/**
	 * Gets the on change.
	 *
	 * @return the on change
	 */
	public String getOnChange() {
		return onChange;
	}

	/**
	 * Sets the on change.
	 *
	 * @param onChange the new on change
	 */
	public void setOnChange(String onChange) {
		this.onChange = onChange;
	}

	/**
	 * Gets the lookup action.
	 *
	 * @return the lookup action
	 */
	public String getLookupAction() {
		return lookupAction;
	}

	/**
	 * Sets the lookup action.
	 *
	 * @param lookupAction the new lookup action
	 */
	public void setLookupAction(String lookupAction) {
		this.lookupAction = lookupAction;
	}

	/**
	 * Gets the lookup parameters.
	 *
	 * @return the lookup parameters
	 */
	public Hashtable getLookupParameters() {
		return lookupParameters;
	}

	/**
	 * Sets the lookup parameters.
	 *
	 * @param lookupParameters the new lookup parameters
	 */
	public void setLookupParameters(Hashtable lookupParameters) {
		this.lookupParameters = lookupParameters;
	}

	/**
	 * Gets the upload file path.
	 *
	 * @return the upload file path
	 */
	public String getUploadFilePath() {
		return uploadFilePath;
	}

	/**
	 * Sets the upload file path.
	 *
	 * @param uploadFilePath the new upload file path
	 */
	public void setUploadFilePath(String uploadFilePath) {
		this.uploadFilePath = uploadFilePath;
	}

	/**
	 * Gets the file name.
	 *
	 * @return the file name
	 */
	public String getFileName() {
		return fileName;
	}

	/**
	 * Sets the file name.
	 *
	 * @param fileName the new file name
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	/**
	 * Gets the img width.
	 *
	 * @return the img width
	 */
	public String getImgWidth() {
		return imgWidth;
	}

	/**
	 * Sets the img width.
	 *
	 * @param imgWidth the new img width
	 */
	public void setImgWidth(String imgWidth) {
		this.imgWidth = imgWidth;
	}

	/**
	 * Gets the img height.
	 *
	 * @return the img height
	 */
	public String getImgHeight() {
		return imgHeight;
	}

	/**
	 * Sets the img height.
	 *
	 * @param imgHeight the new img height
	 */
	public void setImgHeight(String imgHeight) {
		this.imgHeight = imgHeight;
	}

	/**
	 * Gets the image file name.
	 *
	 * @return the image file name
	 */
	public String getImageFileName() {
		return imageFileName;
	}

	/**
	 * Sets the image file name.
	 *
	 * @param imageFileName the new image file name
	 */
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	/**
	 * Gets the multiple selection.
	 *
	 * @return the multiple selection
	 */
	public int getMultipleSelection() {
		return multipleSelection;
	}

	/**
	 * Sets the multiple selection.
	 *
	 * @param multipleSelection the new multiple selection
	 */
	public void setMultipleSelection(int multipleSelection) {
		this.multipleSelection = multipleSelection;
	}

	/**
	 * Gets the field width.
	 *
	 * @return the field width
	 */
	public String getFieldWidth() {
		return fieldWidth;
	}

	/**
	 * Sets the field width.
	 *
	 * @param fieldWidth the new field width
	 */
	public void setFieldWidth(String fieldWidth) {
		this.fieldWidth = fieldWidth;
	}

	/**
	 * Gets the alignment.
	 *
	 * @return the alignment
	 */
	public String getAlignment() {
		return alignment;
	}

	/**
	 * Sets the alignment.
	 *
	 * @param alignment the new alignment
	 */
	public void setAlignment(String alignment) {
		this.alignment = alignment;
	}

	/**
	 * Checks if is secret text field.
	 *
	 * @return true, if is secret text field
	 */
	public boolean isSecretTextField() {
		return secretTextField;
	}

	/**
	 * Sets the secret text field.
	 *
	 * @param secretTextField the new secret text field
	 */
	public void setSecretTextField(boolean secretTextField) {
		this.secretTextField = secretTextField;
	}

	/**
	 * Gets the colour.
	 *
	 * @return the colour
	 */
	public String getColour() {
		return colour;
	}

	/**
	 * Sets the colour.
	 *
	 * @param colour the new colour
	 */
	public void setColour(String colour) {
		this.colour = colour;
	}

	/**
	 * Gets the collection attr name.
	 *
	 * @return the collection attr name
	 */
	public String getCollectionAttrName() {
		return collectionAttrName;
	}

	/**
	 * Sets the collection attr name.
	 *
	 * @param collectionAttrName the new collection attr name
	 */
	public void setCollectionAttrName(String collectionAttrName) {
		this.collectionAttrName = collectionAttrName;
	}

	/**
	 * Checks if is select only leaves.
	 *
	 * @return true, if is select only leaves
	 */
	public boolean isSelectOnlyLeaves() {
		return selectOnlyLeaves;
	}

	/**
	 * Sets the select only leaves.
	 *
	 * @param selectOnlyLeaves the new select only leaves
	 */
	public void setSelectOnlyLeaves(boolean selectOnlyLeaves) {
		this.selectOnlyLeaves = selectOnlyLeaves;
	}
	
	/**
	 * Gets the help message.
	 *
	 * @return the help message
	 */
	public String getHelpMessage() {
		return helpMessage;
	}

	/**
	 * Sets the help message.
	 *
	 * @param helpMessage the new help message
	 */
	public void setHelpMessage(String helpMessage) {
		this.helpMessage = helpMessage;
	}

	/**
	 * Gets the text area cols.
	 *
	 * @return the text area cols
	 */
	public int getTextAreaCols() {
		return textAreaCols;
	}

	/**
	 * Sets the text area cols.
	 *
	 * @param textAreaCols the new text area cols
	 */
	public void setTextAreaCols(int textAreaCols) {
		this.textAreaCols = textAreaCols;
	}

	/**
	 * Gets the text area rows.
	 *
	 * @return the text area rows
	 */
	public int getTextAreaRows() {
		return textAreaRows;
	}

	/**
	 * Sets the text area rows.
	 *
	 * @param textAreaRows the new text area rows
	 */
	public void setTextAreaRows(int textAreaRows) {
		this.textAreaRows = textAreaRows;
	}

	/**
	 * Gets the popup height.
	 *
	 * @return the popup height
	 */
	public int getPopupHeight() {
		return popupHeight;
	}

	/**
	 * Sets the popup height.
	 *
	 * @param popupHeight the new popup height
	 */
	public void setPopupHeight(int popupHeight) {
		this.popupHeight = popupHeight;
	}

	/**
	 * Gets the popup width.
	 *
	 * @return the popup width
	 */
	public int getPopupWidth() {
		return popupWidth;
	}

	/**
	 * Sets the popup width.
	 *
	 * @param popupWidth the new popup width
	 */
	public void setPopupWidth(int popupWidth) {
		this.popupWidth = popupWidth;
	}

	/**
	 * Checks if is dynamic field.
	 *
	 * @return true, if is dynamic field
	 */
	public boolean isDynamicField() {
		return dynamicField;
	}

	/**
	 * Sets the dynamic field.
	 *
	 * @param dynamicField the new dynamic field
	 */
	public void setDynamicField(boolean dynamicField) {
		this.dynamicField = dynamicField;
	}

	/**
	 * Gets the column.
	 *
	 * @return the column
	 */
	public String getColumn() {
		return column;
	}

	/**
	 * Sets the column.
	 *
	 * @param column the new column
	 */
	public void setColumn(String column) {
		this.column = column;
	}

	/**
	 * Gets the text area tool bar.
	 *
	 * @return the text area tool bar
	 */
	public String getTextAreaToolBar() {
		return textAreaToolBar;
	}

	/**
	 * Sets the text area tool bar.
	 *
	 * @param textAreaToolBar the new text area tool bar
	 */
	public void setTextAreaToolBar(String textAreaToolBar) {
		this.textAreaToolBar = textAreaToolBar;
	}
	
}