/*
 * Created on Nov 25, 2003
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package gnomon.hibernate.model;

import gnomon.hibernate.model.journal.JournalTopic;
import gnomon.hibernate.model.portal.GnResource;
import gnomon.hibernate.model.portal.GnResourceCode;

import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Interceptor;
import org.hibernate.MappingException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.liferay.portal.model.impl.PermissionImpl;
import com.liferay.portal.spring.hibernate.HibernateUtil;
import com.liferay.portal.util.PropsUtil;
import com.liferay.portlet.journal.model.impl.JournalArticleImpl;
import com.liferay.util.JNDIUtil;

/**
 * Singleton class that creates and returns an open Hibernate <code>Session</code> to the user.
 *
 * Copyright 2003 Edward Hand
 *
 * @author Edward Hand
 *
 */
/*
 * This class was created to encapsulate the Hibernate SessionFactory and assist
 * the service layer, in this example consisting of ItemService.
 *
 */
public class ConnectionFactory
{

	private static ConnectionFactory instance = null;
	private SessionFactory sessionFactory = null;

	private ConnectionFactory()
	{
		// Establish SessionFactory for Hibernate
		Connection dbConn = null;
		Session session=null;
		try
		{

			/*
			 * The Hibernate Configuration will contain all the classes to be
			 * persisted by Hibernate.  For each class persisted, Hibernate will
			 * expect to find a ClassName.hbm.xml file in the same location as the
			 * class file.  This XML file will define the mapping between the Java
			 * object and the database.
			 *
			 * To add additional classes to the configuration, you may cascade the
			 * method calls thusly:
			 *
			 * Configuration cfg = new Configuration().
			 *                         addClass(Foo.class).
			 *                         addClass(Bar.class);
			 *
			 */

			JNDIUtil util;
			Configuration cfg = new Configuration();
			cfg.setProperty("hibernate.show_sql", "false");
			cfg.setProperty("hibernate.connection.datasource", "java:/comp/env/jdbc/LiferayPool");
			session = HibernateUtil.getSessionFactory().openSession();
			dbConn = session.connection();
			String dialect = "org.hibernate.dialect.SQLServerDialect";
			String dbType = dbConn.getMetaData().getDatabaseProductName().toLowerCase();
			if (dbType.startsWith("mysql")){
				dialect="org.hibernate.dialect.MySQLInnoDBDialect";
			} else if (dbType.startsWith("microsoft") || dbType.indexOf("sql server")>=0) {
				dialect="org.hibernate.dialect.SQLServerDialect";
			} else if (dbType.startsWith("oracle")) {
				dialect="org.hibernate.dialect.OracleDialect";
			}
			cfg.setProperty("hibernate.dialect", dialect);

			cfg.setProperty("hibernate.max_fetch_depth", "6");
			cfg.setProperty("hibernate.cache.use_query_cache","true");
			cfg.setProperty("hibernate.cache.use_second_level_cache","true");
			cfg.setProperty("hibernate.cache.provider_class","org.hibernate.cache.EhCacheProvider");	


			// re-implementations of hibernate mappings for specific liferay portal tables
			cfg.addClass(JournalArticleImpl.class);
			cfg.addClass(JournalTopic.class);
			cfg.addClass(GnResourceCode.class);
			cfg.addClass(GnResource.class);
			cfg.addClass(PermissionImpl.class);


			// #### GI9 HIBERNATE MAPPINGS ####
			 
			// Gi9 core classes
			cfg.configure("/gnomon/hibernate/model/gn/gn_tables.cfg.xml");

			// Parties Tables
			cfg.configure("/gnomon/hibernate/model/parties/parties_tables.cfg.xml");
			 
			// GN Base Portlet Tables
			cfg.configure("/gnomon/hibernate/model/base/base_portlet_tables.cfg.xml");

			// E-Commerce
		//	cfg.configure("/gnomon/hibernate/model/ecommerce/ecommerce_tables.cfg.xml");

			// E-GOV
//			cfg.configure("/gnomon/hibernate/model/egov/egov_tables.cfg.xml");

			// CRM
//			cfg.configure("/gnomon/hibernate/model/crm/crm_tables.cfg.xml");

			// SRV
//			cfg.configure("/gnomon/hibernate/model/srv/srv_tables.cfg.xml");

			// PAYMENT
//			cfg.configure("/gnomon/hibernate/model/payment/payment_tables.cfg.xml");
			
			// Calendar Tables
//			cfg.configure("/gi9/calendar/model/calendar_tables.cfg.xml");

			// Iplan Tables
//			cfg.configure("/gnomon/hibernate/model/iplan/iplan_tables.cfg.xml");
			
			// Vacation house
//			cfg.configure("/gnomon/hibernate/model/base/vacation_house_tables.cfg.xml");
			
			 
			 // EPSOS
			 cfg.addClass(gnomon.hibernate.model.epsos.EpsosPatientConfirmation.class);
			
			 //
//			 cfg.addClass(gnomon.hibernate.model.ocean.Queries.class);
//			 cfg.addClass(gnomon.hibernate.model.ocean.QueryMetadata.class);
//			 cfg.addClass(gnomon.hibernate.model.ocean.QueryParameters.class);
			 
			sessionFactory = cfg.buildSessionFactory();
		}
		catch (MappingException e)
		{
			/*
			 * Upon encountering a Hibernate generated Exception, we are throwing
			 * an unchecked RuntimeExcpetion that will cause the user's
			 * request to fail.
			 *
			 */
			System.err.println("Mapping Exception" + e.getMessage());
			throw new RuntimeException(e);
		}
		catch (HibernateException e)
		{
			/*
			 * Upon encountering a Hibernate generated Exception, we are throwing
			 * an unchecked RuntimeExcpetion that will cause the user's request to fail.
			 *
			 */
			System.err.println("Hibernate Exception" + e.getMessage());
			throw new RuntimeException(e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally
		{
			try
			{
			session.close();


			}
			catch (Exception e) {}
		}
		
	}

	/**
	 * getInstance() returns the instance of the ConnectionFactory singleton.
	 *
	 * Example call to retrieve session:
	 *
	 * <pre>
	 * Session session = ConnectionFactory.getInstance().getSession();
	 * </pre>
	 *
	 * @return Instance of the <code>ConnectionFactory</code> singleton.
	 */
	public static synchronized ConnectionFactory getInstance()
	{
		/*
		 * If the instance of the Singleton has not been created, create and
		 * return.
		 */
		if (instance == null)
		{
			instance = new ConnectionFactory();
		}
		return instance;
	}

	/**
	 * getSession() returns a Hibernate <code>Session</code>
	 *
	 * @return <code>Session</code> retrieved from Hibernate <Code>SessionFactory</code>
	 */
	public Session getSession()
	{
		try
		{
			/*
			 * Use the Hibernate Session Factory to return an open session to the caller.
			 */
			Session s = sessionFactory.openSession();
			return s;
		}
		catch (HibernateException e)
		{
			/*
			 * Upon encountering a Hibernate generated Exception, we are throwing
			 * an unchecked RuntimeExcpetion that will cause the user's request to fail.
			 *
			 */
			System.err.println("Hibernate Exception" + e.getMessage());
			throw new RuntimeException(e);
		}
	}

	public Session getSession(Interceptor interceptor)
	{
		try
		{
			/*
			 * Use the Hibernate Session Factory to return an open session to the caller.
			 */
			Session s = sessionFactory.openSession(interceptor);
			return s;
		}
		catch (HibernateException e)
		{
			/*
			 * Upon encountering a Hibernate generated Exception, we are throwing
			 * an unchecked RuntimeExcpetion that will cause the user's request to fail.
			 *
			 */
			System.err.println("Hibernate Exception" + e.getMessage());
			throw new RuntimeException(e);
		}
	}

}
