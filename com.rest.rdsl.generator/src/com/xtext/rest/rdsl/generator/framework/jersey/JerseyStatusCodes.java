package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.generator.resources.internal.IStatusCode;

/**
 * @author Orrimp
 * Represent key-values pair for status codes and its corresponding Framework strings
 */
public enum JerseyStatusCodes implements IStatusCode {
	
	S_304(304, "NOT_MODIFIED"),
	S_400(400, "BAD_REQUEST"),
	S_401(401, "UNAUTHORIZED"),
	S_403(403, "FORBIDDEN"),
	S_404(404, "NOT_FOUND"),
	S_410(410, "GONE"),
	S_500(500, "INTERNAL_SERVER_ERROR")	
	;
	
	
	private int statusCode;
	private String statusString;
	
	/**
	 * Initialize the enum with Status code and corresponding framework string. 
	 * @param statusCode Status code for example 404 
	 * @param statusString 404 Status code is NOT_FOUND in Jersey 
	 */
	private JerseyStatusCodes(int statusCode, String statusString){
		this.setStatusCode(statusCode);
		this.setStatusString(statusString);
	}

	/**
	 * @return the statusString
	 */
	public String getStatusString() {
		return statusString;
	}

	/**
	 * @param statusString2 the statusString to set
	 */
	public void setStatusString(String statusString) {
		this.statusString = statusString;
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
	

}
