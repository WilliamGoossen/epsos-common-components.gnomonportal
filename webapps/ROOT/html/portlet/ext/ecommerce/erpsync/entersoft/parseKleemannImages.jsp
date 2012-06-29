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
        final long compId = 80175;
        final String S = System.getProperty("file.separator");
        final String sourceRootPath = "C:\\Users\\nikos.GNOMONSA\\Desktop\\Kleemann\\Photos";
        final String targetRootPath = "C:\\J2EE\\apps\\gi9-eservices\\webapps\\ROOT\\FILESYSTEM\\80175\\ecommerce\\product";
        //final String sourceRootPath = "C:" + S + "tmp" + S + "PRODUCT SHOTS-B2B x 640";
        //final String targetRootPath = "C:" + S + "J2EE" + S + "apps" + S + "gi9-eservices" + S + "webapps" + S + "ROOT" + S + "FILESYSTEM" + S + compId + S + "ecommerce" + S + "product";
        //final String sourceRootPath = S + "home" + S + "gi9_eshop" + S + "PRODUCT SHOTS-B2B x 640";
        //final String targetRootPath = S + "home" + S + "gi9_eshop" + S + "eservices" + S + "webapps" + S + "ROOT" + S + "FILESYSTEM" + S + compId + S + "ecommerce" + S + "product";
        
        new FileTraversal(out) {
        	private long i = 0;
            public void parseProduct(String productCode, final File f ) throws IOException {
                
                //getOut().println(colorCode);
                
                GnPersistenceService srv = GnPersistenceService.getInstance(null);
                List<PrProductinstance> instances = srv.listAllObjects(
                		compId, 
                		PrProductinstance.class, 
                		"upper(table1.erpcode) = '" + productCode.toUpperCase() + "'", 
                		"", 
                		1);
                
                if (instances!=null && instances.size()>0) {
                	//update the instances with the photo
                	//getOut().println(productCode + "$" + colorCode);
                	//getOut().println("<br/><br/>");
                	//getOut().println((++i) + ". " + f.getAbsolutePath());
                	for (PrProductinstance inst: instances) {
                		
                		PrProduct masterProduct = inst.getPrProduct();
                		Integer productid = masterProduct.getMainid();
                		
                		if (Validator.isNull(masterProduct.getImagefile()) || Validator.isNull(inst.getImage())) {
                		
	                		String imageFileName = f.getName();
	                		String imageFilePath = targetRootPath + S + productid + S + imageFileName;
	                		
	                		//update master product if without image
	                        if (Validator.isNull(masterProduct.getImagefile())) {
	                            masterProduct.setImagefile(f.getName());
	                            srv.updateObject(masterProduct);
	                        }
                		
	                		//update instances if without image
	                		if (Validator.isNull(inst.getImage())) {
		                		Integer mainid = inst.getMainid();
								
		                		//getOut().println(imageFilePath + "<br/>");
		                		//getOut().flush();
		                		
		                		inst.setImage(f.getName());
	                            srv.updateObject(inst);
	                		}
	                		
							com.liferay.util.FileUtil.copyFile(f.getAbsolutePath(), imageFilePath, false);

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
                	
                	String productCode = fileName.substring(0, fileName.lastIndexOf("."));
                	                   
                    parseProduct(productCode, f);
                }
            }
            
            public void onDirectory( final File d ) throws IOException {
                
                //getOut().println("Product Line " + productCode + " with name " + productName);
            }
            
        }.traverse(new File(sourceRootPath));
        
%>