package com.xtext.rest.rdsl.generator.resources.internal;


public class ExceptionDescription {
	
	private String name;
	private String message;
	private String developerMessage;
	private int statusCode;
	private String statusString;

	public ExceptionDescription(String name){
		this.name = name;
	}	
	
	public ExceptionDescription(String name, String message){
		this(name);
		this.message = message;
	}
	
	public ExceptionDescription(String name, String message, IStatusCode statusCodes){
		this(name, message);
		this.statusCode = statusCodes.getStatusCode();
		this.statusString = statusCodes.getStatusString();
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return the developerMessage
	 */
	public String getDeveloperMessage() {
		return developerMessage;
	}

	/**
	 * @param developerMessage the developerMessage to set
	 */
	public void setDeveloperMessage(String developerMessage) {
		this.developerMessage = developerMessage;
	}

	/**
	 * @return the statusCode
	 */
	public int getStatusCode() {
		return statusCode;
	}

	/**
	 * @param statusCode the statusCode to set
	 */
	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	/**
	 * @return the statusString
	 */
	public String getStatusString() {
		return statusString;
	}

	/**
	 * @param statusString the statusString to set
	 */
	public void setStatusString(String statusString) {
		this.statusString = statusString;
	}
}
