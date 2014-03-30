package com.xtext.rest.rdsl.generator.internals

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionDescription
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.PackageManager

class ExceptionGenerator implements IExceptionGenerator{
	/*
	 * Generate an exception in specific folder under a specific name
	 */
	var IFileSystemAccess fsa;
	val String generatePackage = Constants.getMainPackage() + Constants.EXCEPTIONPACKAGE + "/";
	
	
	new(IFileSystemAccess fsa) {
		this.fsa = fsa;		
	}
	

	
	override generateCustomException(ExceptionDescription exDesc) {
		
		
		fsa.generateFile(generatePackage + exDesc.name + Constants.JAVA,
		'''
		package «PackageManager.exceptionPackage»;
		
		import javax.ws.rs.WebApplicationException;
			 
		public class «exDesc.name» extends WebApplicationException {
			
			private String developerMessage = "";
			private String userMessage = "";
			private Exception innerDeveloperException = null;
			
			public «exDesc.name»(){
				super();
				this.developerMessage = "«exDesc.developerMessage»";
				this.userMessage = "«exDesc.message»";
			}
			
			public String getDeveloperMessage(){ 
				return this.developerMessage;
			}
			
			public String getUserMEssage(){
				return this.userMessage;
			}
			
			public void setInnerException(Exception ex){
				this.innerDeveloperException = ex;
			}
		}
		'''
		)
	}
}