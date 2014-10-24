package com.xtext.rest.rdsl.generator.resouces.interal;

import java.util.HashMap;

import com.xtext.rest.rdsl.generator.framework.jersey.JerseyStatusCodes;

public class ExceptionMapper extends HashMap<Integer, ExceptionDescription> {

	private static final long serialVersionUID = -7875742742350805097L;
	private String baseErrorMessage ="An error occured!";

	public ExceptionMapper(){
		initJersey();	
	}

	private void initJersey() {
		put(304, new ExceptionDescription("ModificationException", baseErrorMessage,  JerseyStatusCodes.S_304));
		put(400, new ExceptionDescription("BussinessException", baseErrorMessage, JerseyStatusCodes.S_400));
		put(401, new ExceptionDescription("AuthorisationException", baseErrorMessage, JerseyStatusCodes.S_401));
		put(403, new ExceptionDescription("ForbiddenException", baseErrorMessage, JerseyStatusCodes.S_403));
		put(404, new ExceptionDescription("ResourceNotFoundException", "The requested resouce could not be found.", JerseyStatusCodes.S_404));
		put(410, new ExceptionDescription("DeletedException", baseErrorMessage, JerseyStatusCodes.S_410));
		put(500, new ExceptionDescription("TechnicalException", baseErrorMessage, JerseyStatusCodes.S_500));
	}
	
	
	
	
}
