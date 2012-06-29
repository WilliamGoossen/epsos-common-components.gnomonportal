/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
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

package com.gnomon.xslt;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.log4j.Logger;

public class EpsosXSLTransformer {

	  private static final String MAIN_XSLT = "/resources/cda.xsl";
	  private static String filesNeeded[]={"epSOSDisplayLabels.xml","NullFlavor.xml","SNOMEDCT.xml","UCUMUnifiedCodeforUnitsofMeasure.xml"};  
	  private static Logger logger = Logger.getLogger(EpsosXSLTransformer.class);
	  
		 /**
		 * @param xml the source cda xml file
		 * @param lang the language you want the labels, value set to be displayed
		 * @param actionpath the url that you want to post the dispensation form. Leave it empty to not allow dispensation
		 * @param repositorypath the path of the epsos repository files
		 * @param export whether to export file to temp folder or not
		 * @return the cda document in html format
		 */
		private String transform(String xml,String lang, String actionpath, String repositoryPath,boolean export)
			{
			String output = "";
			String path = repositoryPath;
			
			try
			{
			  if(checkLanguageFiles(path)==false) 
			  	{
				output="Language Files must be created in " + repositoryPath;
				logger.error(output);
				return output;
			  	}
			}
			catch (Exception e)
				{
				output=e.getMessage();
				}
			logger.debug("Tying to transform xml using action path for dispensation '" + actionpath + "' and repository path :" + repositoryPath);
			try
			{
			URL xslUrl = this.getClass().getResource(MAIN_XSLT);
			InputStream xslStream = this.getClass().getResourceAsStream(MAIN_XSLT);
	      
			String systemId= xslUrl.toExternalForm();
			
			
			StreamSource xmlSource = new StreamSource(new StringReader(xml));
	        StreamSource xslSource = new StreamSource(xslStream);

	        xslSource.setSystemId(systemId);
	        
			TransformerFactory transformerFactory =
				TransformerFactory.newInstance();

			Transformer transformer =
				transformerFactory.newTransformer(xslSource);
			transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
			
			transformer.setParameter("epsosLangDir", path);
			transformer.setParameter("userLang", lang);
			if ( (actionpath!=null) && !actionpath.equals(""))
			{
				transformer.setParameter("actionpath", actionpath);
				transformer.setParameter("allowDispense", "true");
			}
			else
			{
				transformer.setParameter("allowDispense", "false");
			}
			
			File resultFile = File.createTempFile("Streams", ".html");
			Result result = new StreamResult(resultFile);
			logger.debug("Temp file goes to : "+ resultFile.getAbsolutePath( ));
			transformer.transform(xmlSource, result);
			output = readFile(resultFile.getAbsolutePath());
			if (!export) 
				{
				logger.debug("Delete temp file " + resultFile.getAbsolutePath( ));
				resultFile.delete();
				}
			}
			catch (Exception e)
			{
				output=e.getMessage();
				logger.error(output);
			}
			return output;
		}
	
	 /**
	 * @param xml the source cda xml file
	 * @param lang the language you want the labels, value set to be displayed
	 * @param actionpath the url that you want to post the dispensation form
	 * @param repositorypath the path of the epsos repository files 
	 * @return the cda document in html format
	 */
	public String transform(String xml,String lang, String actionpath, String repositoryPath)
		{
		return transform(xml,lang,actionpath,repositoryPath,false);		
		}
		
	 /**This method uses the epsos repository files from user home directory
	 * @param xml the source cda xml file
	 * @param lang the language you want the labels, value set to be displayed
	 * @param actionpath the url that you want to post the dispensation form
	 * @return the cda document in html format
	 */
	public String transform(String xml,String lang, String actionpath)
		{
		String output = "";
		String path = System.getProperty("user.home");
		path = path + "/EpsosRepository";
		return transform(xml,lang,actionpath,path,false);		
		}
  
	 /**This method uses the epsos repository files from user home directory and outputs the transformed xml to the temp file without deleting it
	 * @param xml the source cda xml file
	 * @param lang the language you want the labels, value set to be displayed
	 * @param actionpath the url that you want to post the dispensation form
	 * @return the cda document in html format
	 */
	public String transformWithOutputAndUserHomePath(String xml,String lang, String actionpath)
		{
		String output = "";
		String path = System.getProperty("user.home");
		path = path + "/EpsosRepository";
		return transform(xml,lang,actionpath,path,true);		
		}
	
	 /**This method uses the epsos repository files from user home directory and outputs the transformed xml to the temp file without deleting it
	 * @param xml the source cda xml file
	 * @param lang the language you want the labels, value set to be displayed
	 * @param actionpath the url that you want to post the dispensation form
	 * @param repositorypath the path of the epsos repository files 
	 * @return the cda document in html format
	 */
	public String transformWithOutputAndDefinedPath(String xml,String lang, String actionpath,String repositoryPath)
		{
		return transform(xml,lang,actionpath,repositoryPath,true);		
		}
	
    public static String readFile( String file ) throws IOException {

    	FileInputStream fstream = new FileInputStream(file);
    	InputStreamReader   in2 = new InputStreamReader(fstream,"UTF-8");
    	
    BufferedReader reader = new BufferedReader( in2);
    String line  = null;
    StringBuilder stringBuilder = new StringBuilder();
    String ls = System.getProperty("line.separator");
    while( ( line = reader.readLine() ) != null ) {
    	// remove a strange character in the begining of the file 
    	if(line.length()>0 && line.codePointAt(0)==65279)
    		line=line.substring(1);
    	stringBuilder.append( line );
        stringBuilder.append( ls );
    }
    return stringBuilder.toString();
 }

    public static String readFile( File file ) throws IOException {
    BufferedReader reader = new BufferedReader (new FileReader(file));
    String line  = null;
    StringBuilder stringBuilder = new StringBuilder();
    String ls = System.getProperty("line.separator");
    while( ( line = reader.readLine() ) != null ) {
    	// remove a strange character in the begining of the file 
    	if(line.length()>0 && line.codePointAt(0)==65279)
    	{
    		line=line.substring(1);
    	}
    	stringBuilder.append( line );
        stringBuilder.append( ls );
    }
    return stringBuilder.toString();
 } 
    
   public  static boolean  checkLanguageFiles(String path) {
	   
	   boolean filesFound=true;
	   
	   // get User Path
	   
	   File dirFile = new File(path);
	   if(dirFile==null || !dirFile.exists())
		   filesFound=false;
	   else {
		   for(int i=0; i<filesNeeded.length;i++) {
			   	File newFile = new File (path + "/" + filesNeeded[i]);
			   	if(newFile==null || !newFile.exists()) {
					   filesFound=false;
					   break;
			   	}
		   
		   }
	   }
	   
	   
	   return filesFound;
	   
   }
}