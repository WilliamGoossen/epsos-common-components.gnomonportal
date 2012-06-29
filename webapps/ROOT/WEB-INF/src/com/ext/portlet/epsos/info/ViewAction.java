package com.ext.portlet.epsos.info;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;

public class ViewAction extends PortletAction {

	

	public ActionForward render(ActionMapping mapping,
			ActionForm form,
			PortletConfig config,
			RenderRequest request,
			RenderResponse response) throws Exception
	{
		try {
			EpsosHelperService epsos = EpsosHelperService.getInstance();
			SpiritUserClientDto usr = epsos.getEpsosUserInformation(request);
			request.setAttribute("EPSOS_USER", usr);
			
//			byte[] photo = usr.getJpegPhoto().get(0);
//			if (photo != null && photo.length > 0)
//			{
//				String path = CommonUtil.getRootPath(request)+ "FILESYSTEM" + File.separator+ PortalUtil.getCompanyId(request)+File.separator +
//								  "epsos"+File.separator;
//				String filename = usr.getUid().get(0)+".jpg";
//				
//				try {
//					File uploadDir = new File(path);
//					if (!uploadDir.exists()){
//						uploadDir.mkdirs();
//					}
//					
//					File imageFile = new File(path+filename);
//					if (!imageFile.exists())
//					{
//						ByteArrayOutputStream baos = new ByteArrayOutputStream();
//						//write the file to the file specified
//						OutputStream bos = new FileOutputStream(path + filename);
//						bos.write(photo);
//						bos.close();
//					}
//				} catch (Exception io) {}
//
//			}

			return mapping.findForward("common.success");
		} catch (Exception e) {
			return mapping.findForward("common.failure");
		}
	}
	
	

}
