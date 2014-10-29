package com.xtext.rest.rdsl.management;

/**
 * @author Vitaliy
 * Class for managing all the imports for the generted classes.
 */
public class PackageManager {
	
	private static String objectPackage = "";
	private static String exceptionPackage ="";
	private static String mainPackage = "";
	private static String clientPackage ="";
	private static String resourcePackage ="";
	private static String interfacePackage ="";
	private static String authPackage = "";
	private static String databasePackage = "";
	private static String frameworkPackage = "";
	private static String webPackage = "";
	private static String responsePackage;
	
	/**
	 * @return the objectPackage
	 */
	public static String getObjectPackage() {
		return objectPackage;
	}
	/**
	 * @param objectPackage the objectPackage to set
	 */
	public static void setObjectPackage(String objectPackage) {
		PackageManager.objectPackage = objectPackage;
	}
	/**
	 * @return the exceptionPackage
	 */
	public static String getExceptionPackage() {
		return exceptionPackage;
	}
	/**
	 * @param exceptionPackage the exceptionPackage to set
	 */
	public static void setExceptionPackage(String exceptionPackage) {
		PackageManager.exceptionPackage = exceptionPackage;
	}
	/**
	 * @return the mainPackage
	 */
	public static String getMainPackage() {
		return mainPackage;
	}
	/**
	 * @param mainPackage the mainPackage to set
	 */
	public static void setMainPackage(String mainPackage) {
		PackageManager.mainPackage = mainPackage;
	}
	/**
	 * @return the clientPackage
	 */
	public static String getClientPackage() {
		return clientPackage;
	}
	/**
	 * @param clientPackage the clientPackage to set
	 */
	public static void setClientPackage(String clientPackage) {
		PackageManager.clientPackage = clientPackage;
	}
	/**
	 * @return the resourcePackage
	 */
	public static String getResourcePackage() {
		return resourcePackage;
	}
	/**
	 * @param resourcePackage the resourcePackage to set
	 */
	public static void setResourcePackage(String resourcePackage) {
		PackageManager.resourcePackage = resourcePackage;
	}
	/**
	 * @return the interfacePackage
	 */
	public static String getInterfacePackage() {
		return interfacePackage;
	}
	/**
	 * @param interfacePackage the interfacePackage to set
	 */
	public static void setInterfacePackage(String interfacePackage) {
		PackageManager.interfacePackage = interfacePackage;
	}
	/**
	 * @return the authPackage
	 */
	public static String getAuthPackage() {
		return authPackage;
	}
	/**
	 * @param authPackage the authPackage to set
	 */
	public static void setAuthPackage(String authPackage) {
		PackageManager.authPackage = authPackage;
	}
	/**
	 * @return the databasePackage
	 */
	public static String getDatabasePackage() {
		return databasePackage;
	}
	/**
	 * @param databasePackage the databasePackage to set
	 */
	public static void setDatabasePackage(String databasePackage) {
		PackageManager.databasePackage = databasePackage;
	}
	/**
	 * @return the frameWorkPackage
	 */
	public static String getFrameworkPackage() {
		return frameworkPackage;
	}
	/**
	 * @param frameWorkPackage the frameWorkPackage to set
	 */
	public static void setFrameworkPackage(String frameworkPackage) {
		PackageManager.frameworkPackage = frameworkPackage;
	}
	/**
	 * @return the webPackage
	 */
	public static String getWebPackage() {
		return webPackage;
	}
	/**
	 * @param webPackage the webPackage to set
	 */
	public static void setWebPackage(String webPackage) {
		PackageManager.webPackage = webPackage;
	}
	public static void setResponsePackage(String response) {
		PackageManager.responsePackage = response;
	}
	
	public static String getResponsePackage(){
		return responsePackage;
	}
}
