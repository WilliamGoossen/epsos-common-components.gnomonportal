<%@ include file="/html/common/init.jsp" %>

<%@ page import="gnomon.business.StringUtils" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.model.ConnectionFactory" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>

<%@ page import="com.ext.portlet.ecommerce.batches.*" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.*" %>



<%
        final long compId = 74940;
        final String S = System.getProperty("file.separator");
        //final String sourceRootPath = "C:\\tmp\\PRODUCT SHOTS-B2B x 640";
        //final String targetRootPath = "C:\\J2EE\\apps\\gi9-eservices\\webapps\\ROOT\\FILESYSTEM\\74940\\ecommerce\\product";
        //final String sourceRootPath = "C:" + S + "tmp" + S + "PRODUCT SHOTS-B2B x 640";
        //final String targetRootPath = "C:" + S + "J2EE" + S + "apps" + S + "gi9-eservices" + S + "webapps" + S + "ROOT" + S + "FILESYSTEM" + S + compId + S + "ecommerce" + S + "product";
        final String sourceRootPath = S + "home" + S + "gi9_eshop" + S + "PRODUCT SHOTS-B2B x 640";
        final String targetRootPath = S + "home" + S + "gi9_eshop" + S + "eservices" + S + "webapps" + S + "ROOT" + S + "FILESYSTEM" + S + compId + S + "ecommerce" + S + "product";
        
        new FileTraversal(out) {
        	private long i = 0;
            public void parseProduct(String productCode, String colorCode, final File f ) throws IOException {
                
                //getOut().println(colorCode);
                
                GnPersistenceService srv = GnPersistenceService.getInstance(null);
                List<PrProductinstance> instances = srv.listAllObjects(
                		compId, 
                		PrProductinstance.class, 
                		"upper(table1.erpcode) like '" + productCode + "$" + colorCode + "%'", 
                		"", 
                		1);
                
                if (instances!=null && instances.size()>0) {
                	//update the instances with the photo
                	//getOut().println(productCode + "$" + colorCode);
                	//getOut().println("<br/><br/>");
                	//getOut().println((++i) + ". " + f.getAbsolutePath());
                	for (PrProductinstance inst: instances) {
                		//update instances without images
                		if (Validator.isNull(inst.getImage())) {
	                		Integer mainid = inst.getMainid();
	                		Integer productid = inst.getPrProduct().getMainid();
	                		String imageFileName = f.getName();
	                		String imageFilePath = targetRootPath + S + productid + S + imageFileName;
	                		com.liferay.util.FileUtil.copyFile(f.getAbsolutePath(), imageFilePath, false);
	                		
	                		//getOut().println(imageFilePath + "<br/>");
	                		//getOut().flush();
	                		
	                		inst.setImage(f.getName());
                            srv.updateObject(inst);
	                		
	                		GeneralUtils.createThumbnail(imageFilePath, 
	                	    	    GeneralUtils.createThumbnailPath(imageFilePath), 
	                	    	    compId);
	                	    GeneralUtils.createThumbnail(imageFilePath, 
	                	    		GeneralUtils.createThumbnailPath(imageFilePath).replace("thumbnail","thumbnail2"), 
	                	    		120, 120);
                		}
                	}
                } else {
                	//printout non matched paths
                	getOut().println("<br/>");
                    getOut().println(f.getAbsolutePath()); // + "\t\t (" + productCode + "$" + colorCode + ")");
                }
            }
            
            
            public void onFile( final File f ) throws IOException {
                String fileName = f.getName();
                String fileAbsolutePath = f.getAbsolutePath();
                
                if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".tif") || fileName.endsWith(".png")) {
                	File d = f.getParentFile();
                	String dirName = d.getName();
                	if (dirName.startsWith("_"))
                        dirName = dirName.substring(1);
                    
                    String productCode = dirName.indexOf("_")<0? 
                            "": dirName.substring(0, dirName.indexOf("_"));
                	
                    String productName = fileName.indexOf("_")<0? 
                            fileName.substring(0, fileName.lastIndexOf(".")):
                                fileName.substring(0, fileName.indexOf("_"));
                    
                    String residual = fileName.indexOf("_")<0? 
                            fileName.substring(fileName.lastIndexOf(".") + 1):
                                fileName.substring(fileName.indexOf("_") + 1);
                    
                    if (residual.indexOf(".")>0) {
                        String color = residual.indexOf("_")<0? 
                                residual.substring(0, residual.lastIndexOf(".")):
                                    residual.substring(0, residual.indexOf("_"));
                        
                        color = StringUtils.myreplaceALL(color, "_", "/");
                        color = color.toUpperCase();
                        
                        //find product instance with the color feature and the selected featvalue
                        parseProduct(productCode, color, f);
                        
                    } else {
                        getOut().println("--DROPPED FILE " + fileAbsolutePath);
                    }
                    //String sizeCode = "";
                }
            }
            
            public void onDirectory( final File d ) throws IOException {
                String dirName = d.getName();
                //ignore preceding underscore
                if (dirName.startsWith("_"))
                    dirName = dirName.substring(1);
                
                String productCode = dirName.indexOf("_")<0? 
                        "": dirName.substring(0, dirName.indexOf("_"));
                
                String productName = dirName.indexOf("_")<0? 
                        dirName: dirName.substring(dirName.indexOf("_")+1);
                
                //getOut().println("Product Line " + productCode + " with name " + productName);
            }
            
        }.traverse(new File(sourceRootPath));
        
%>