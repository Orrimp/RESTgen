package com.xtext.rest.rdsl.generator.framework.jersey

import org.eclipse.xtext.generator.IFileSystemAccess
import java.util.List
import com.xtext.rest.rdsl.restDsl.ResourceType
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Naming

class GensonResolverContent implements IResolverContent {
	
	private val IFileSystemAccess fsa;
	private val List<ResourceType> resources;
	
	
	new(IFileSystemAccess fsa, List<ResourceType> resources) {
		this.fsa = fsa;
		this.resources = resources;
	
	}
	
	override getConstructor() {
		'''
		final String ISO8601_DATETIME_FORMAT = "yyyy-MM-dd' 'HH:mm:ss";
		final DateFormat format = new SimpleDateFormat(ISO8601_DATETIME_FORMAT);
		format.setTimeZone(TimeZone.getTimeZone("UTC"));
		format.setLenient(false);
		
		genson = new Genson.Builder()
			.setDateFormat(format)
			«FOR res: resources»
			.addAlias("«res.name.toLowerCase»", «res.name.toFirstUpper».class)
			«ENDFOR»
			.addAlias("«Naming.CLASS_LINK.getClassName().toLowerCase»", «Naming.CLASS_LINK».class)
			.create();
			 
		'''
	}
	
	override getName() {
		return "Genson";
	}
	
	override getClassName() {
		return Naming.GENSON_RESOLVER.className;
	}
	
	override getImports() {
		'''
		import java.text.DateFormat;
		import java.text.SimpleDateFormat;
		import java.util.TimeZone;
		
		«FOR res: resources»
		import «PackageManager.objectPackage».«res.name.toFirstUpper»;
		«ENDFOR»

		import com.owlike.genson.Genson;
		import «Naming.CLASS_LINK.classImport»;
		'''
	}
	
	override getClassVariables() {
		'''
		private final Genson genson;
		'''
	}
	
	override getContextMethod() {
		'''
		return genson;
		'''
	}	
}