package gnomon.services;

import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.model.ConnectionFactory;
import gnomon.hibernate.model.base.events.BsEvent;
import gnomon.hibernate.model.base.events.EvEventType;
import gnomon.hibernate.model.base.events.EvEventTypeLanguage;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.crypto.spec.SecretKeySpec;
import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.quartz.CronTrigger;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.ObjectAlreadyExistsException;
import org.smslib.GatewayException;
import org.smslib.ICallNotification;
import org.smslib.IGatewayStatusNotification;
import org.smslib.IInboundMessageNotification;
import org.smslib.InboundMessage;
import org.smslib.Library;
import org.smslib.Service;
import org.smslib.TimeoutException;
import org.smslib.AGateway.GatewayStatuses;
import org.smslib.AGateway.Protocols;
import org.smslib.InboundMessage.MessageClasses;
import org.smslib.Message.MessageTypes;
import org.smslib.crypto.AESKey;
import org.smslib.modem.SerialModemGateway;

import com.ext.portlet.crm.helpdesk.services.CrmService;
import com.ext.portlet.ecommerce.erp.kefweb.job.CheckStatusJob;
import com.ext.portlet.ecommerce.pricing.EcommercePriceUpdaterJob;
import com.ext.portlet.parties.contacts.highroles.HighRoleService;
import com.ext.util.CommonUtil;
import com.liferay.portal.job.JobScheduler;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.util.PortalInstances;
import com.liferay.portal.util.PropsUtil;
import com.liferay.util.Http;
import com.objectxp.msg.GsmHelper;
import com.objectxp.msg.SmsMessage;
public class QuartzSchedulerServlet extends GenericServlet {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Service srv;

	public static final String SCH_CRON_IAS_PERIOD = "projectMgmt.schedulejob.createIasPeriod.cron";

	public static final String JOB_GROUP_GI9 = "Gi9-Jobs";

	public void init(ServletConfig config) throws ServletException {
			super.init(config);
			System.out.println("Scheduling additional Quartz Jobs through servlet..");

			String path = CommonUtil.getRootPath(this);;

			sendEmails(path);
		
			// HIGH ROLES DEFINITIONS (if any)
			try {
				String xml = Http.URLtoString(getServletContext().getResource("/WEB-INF/high-role-definitions.xml"));
				HighRoleService.getInstance().processDefinitions(xml);
			} catch (Exception e) {
			}
			
		}

		public void service(ServletRequest arg0, ServletResponse arg1)
			throws ServletException, IOException {
		}
		public String getServletInfo() {
			return null;
		}

		
	    private void sendEmails(String path){

	    	String prop_schedule_job = PropsUtil.get("gi9.email.notification.schedulejob");
	    	String prop_schedule_cron = PropsUtil.get("gi9.email.notification.schedulejob.cron");
	    	Logger log = Logger.getLogger(MailNotificationJob.class.getName());
	    	try {
	    		boolean scheduleJob = Boolean.valueOf(prop_schedule_job).booleanValue();
	    		if (scheduleJob)
	    		{
	    			MailNotificationJob aJob = new MailNotificationJob();
	    			JobDetail jobDetail = new JobDetail(
	    					aJob.getClass().getSimpleName(), JOB_GROUP_GI9,
	    					aJob.getClass());
	    			jobDetail.setDescription("Gi9 Email Notifications");
	    			HashMap<String, String> params = new HashMap<String, String>();
					params.put("path", path);
					jobDetail.setJobDataMap(new JobDataMap(params));
	    			CronTrigger trigger = new CronTrigger(
	    					aJob.getClass().getSimpleName() + "_TRIGGER",
	    					JOB_GROUP_GI9 );
	    			trigger.setCronExpression(prop_schedule_cron);
	    			log.info("Scheduling Job '"+aJob.getClass().getName()+"' to run on '"+prop_schedule_cron+"' (cron).");
	    			JobScheduler.scheduleJob(jobDetail, trigger);
	    		}
	    	}catch (ObjectAlreadyExistsException oae) {
	    		log.error("Did nothing, Job was already scheduled: "+oae.getMessage());
	    	} catch (Exception e) {
	    		log.error("Exception happened during Job scheduling", e);
	    	}
	    }


		

		
		
	}
