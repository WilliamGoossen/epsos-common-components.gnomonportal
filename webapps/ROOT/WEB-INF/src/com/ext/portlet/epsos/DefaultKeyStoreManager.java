/*
 *  Copyright 2010 jerouris.
 * 
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 * 
 *       http://www.apache.org/licenses/LICENSE-2.0
 * 
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  under the License.
 */
package com.ext.portlet.epsos;

import epsos.ccd.gnomon.configmanager.ConfigurationManagerService;
import gnomon.util.GnPropsUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.UnrecoverableKeyException;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import org.apache.log4j.Logger;

import com.liferay.portal.kernel.util.GetterUtil;

// TODO: Auto-generated Javadoc
/**
 * The Class DefaultKeyStoreManager.
 *
 * @author jerouris
 */
public final class DefaultKeyStoreManager implements KeyStoreManager {

    /** The KEYSTOR e_ location. */
    private final String KEYSTORE_LOCATION;
    
    /** The TRUSTSTOR e_ location. */
    private final String TRUSTSTORE_LOCATION;
    
    /** The KEYSTOR e_ password. */
    private final String KEYSTORE_PASSWORD;
    
    /** The TRUSTSTOR e_ password. */
    private final String TRUSTSTORE_PASSWORD;
    
    /** The PRIVATEKE y_ alias. */
    private final String PRIVATEKEY_ALIAS;
    
    /** The PRIVATEKE y_ password. */
    private final String PRIVATEKEY_PASSWORD;
    
    /** The key store. */
    private KeyStore keyStore;
    
    /** The trust store. */
    private KeyStore trustStore;
    
    /** The _log. */
    private static Logger _log = Logger.getLogger("DEFAULTKEYMANAGER");
    
    /**
     * Instantiates a new default key store manager.
     */
    public DefaultKeyStoreManager() {
       
        // Constants Initialization
       
//    KEYSTORE_LOCATION =GetterUtil.getString(GnPropsUtil.get("portalb", "KEYSTORE_LOCATION"),"Unknown-1");
//    KEYSTORE_PASSWORD =GetterUtil.getString(GnPropsUtil.get("portalb", "KEYSTORE_PASSWORD"),"spirit");
//    PRIVATEKEY_ALIAS = GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_ALIAS"),"server1");
//    PRIVATEKEY_PASSWORD = GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_PASSWORD"),"spirit");
//    TRUSTSTORE_LOCATION = GetterUtil.getString(GnPropsUtil.get("portalb", "TRUSTSTORE_LOCATION"),"Unknown");
//    TRUSTSTORE_PASSWORD = GetterUtil.getString(GnPropsUtil.get("portalb", "TRUSTSTORE_PASSWORD"),"spirit");
   
    ConfigurationManagerService cms = ConfigurationManagerService.getInstance();
    KEYSTORE_LOCATION =cms.getProperty("javax.net.ssl.keyStore");
    KEYSTORE_PASSWORD =cms.getProperty("javax.net.ssl.keyStorePassword");
    PRIVATEKEY_ALIAS = cms.getProperty("javax.net.ssl.key.alias");
    PRIVATEKEY_PASSWORD = cms.getProperty("javax.net.ssl.privateKeyPassword");
    TRUSTSTORE_LOCATION = cms.getProperty("javax.net.ssl.trustStore");
    TRUSTSTORE_PASSWORD = cms.getProperty("javax.net.ssl.trustStorePassword");

    
    keyStore = getKeyStore();
    trustStore = getTrustStore();
    }

    /* (non-Javadoc)
     * @see com.ext.portlet.epsos.KeyStoreManager#getPrivateKey(java.lang.String, char[])
     */
    public KeyPair getPrivateKey(String alias, char[] password) throws SMgrException {


        try {

            // Get private key
            Key key = keyStore.getKey(alias, password);
            if (key instanceof PrivateKey) {
                // Get certificate of public key
                java.security.cert.Certificate cert = keyStore.getCertificate(alias);

                // Get public key
                PublicKey publicKey = cert.getPublicKey();

                // Return a key pair
                return new KeyPair(publicKey, (PrivateKey) key);
            }
        }
        catch (UnrecoverableKeyException e) {
            
            throw new SMgrException("Key with alias:" + alias + " is unrecoverable", e);
        }
        catch (NoSuchAlgorithmException e) {
           // Logger.getLogger(SignatureManager.class.getName()).error(null, e);
            throw new SMgrException("Key with alias:" + alias + " uses an incompatible algorithm", e);
        }
        catch (KeyStoreException e) {
            //Logger.getLogger(SignatureManager.class.getName()).error(null, e);
            throw new SMgrException("Key with alias:" + alias + " not found", e);
        }
        return null;
    }

    /* (non-Javadoc)
     * @see com.ext.portlet.epsos.KeyStoreManager#getKeyStore()
     */
    public KeyStore getKeyStore() {

        try {
            keyStore = KeyStore.getInstance(KeyStore.getDefaultType());
            
            ClassLoader cl = Thread.currentThread().getContextClassLoader();
        	//URL url = cl.getResource("com/ext/portlet/epsos/keys/" + KEYSTORE_LOCATION);
        	ConfigurationManagerService cms = ConfigurationManagerService.getInstance();
        	
        	File file = new File(KEYSTORE_LOCATION);
        	
            InputStream keystoreStream = new FileInputStream(file);
        	//InputStream keystoreStream = new FileInputStream(url.getFile());
            keyStore.load(keystoreStream, KEYSTORE_PASSWORD.toCharArray());

            return keyStore;

        }
        catch (IOException ex) {
        	
        	ex.printStackTrace();
        }
        catch (NoSuchAlgorithmException ex) {
        	ex.printStackTrace();
        }
        catch (CertificateException ex) {
        	ex.printStackTrace();
        }
        catch (KeyStoreException ex) {
        	ex.printStackTrace();
        }
        return null;
    }

    /* (non-Javadoc)
     * @see com.ext.portlet.epsos.KeyStoreManager#getCertificate(java.lang.String)
     */
    public Certificate getCertificate(String alias) throws SMgrException {
        try {
            java.security.cert.Certificate cert = keyStore.getCertificate(alias);
            return cert;
        }
        catch (KeyStoreException ex) {
            Logger.getLogger(DefaultKeyStoreManager.class.getName()).error(null, ex);
            throw new SMgrException("Certificate with alias: " + alias + " not found in keystore", ex);
        }

    }

    /* (non-Javadoc)
     * @see com.ext.portlet.epsos.KeyStoreManager#getTrustStore()
     */
    public KeyStore getTrustStore() {
        try {
            trustStore = KeyStore.getInstance(KeyStore.getDefaultType());
            
            //ClassLoader cl = Thread.currentThread().getContextClassLoader();
           	File file = new File(TRUSTSTORE_LOCATION);
            
        	//URL url = cl.getResource("com/ext/portlet/epsos/keys/" + TRUSTSTORE_LOCATION);
            
            //InputStream keystoreStream = new FileInputStream(url.getFile());
           	InputStream keystoreStream = new FileInputStream(file);
            trustStore.load(keystoreStream, TRUSTSTORE_PASSWORD.toCharArray());
            return trustStore;
        }
        catch (IOException ex) {
            java.util.logging.Logger.getLogger(DefaultKeyStoreManager.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        catch (NoSuchAlgorithmException ex) {
            java.util.logging.Logger.getLogger(DefaultKeyStoreManager.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        catch (CertificateException ex) {
            java.util.logging.Logger.getLogger(DefaultKeyStoreManager.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        catch (KeyStoreException ex) {
            java.util.logging.Logger.getLogger(DefaultKeyStoreManager.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return null;
    }

    /* (non-Javadoc)
     * @see com.ext.portlet.epsos.KeyStoreManager#getDefaultPrivateKey()
     */
    public KeyPair getDefaultPrivateKey() throws SMgrException {
        return getPrivateKey(PRIVATEKEY_ALIAS, PRIVATEKEY_PASSWORD.toCharArray());
    }

    /* (non-Javadoc)
     * @see com.ext.portlet.epsos.KeyStoreManager#getDefaultCertificate()
     */
    public Certificate getDefaultCertificate() throws SMgrException {
        return getCertificate(PRIVATEKEY_ALIAS);
    }
}
