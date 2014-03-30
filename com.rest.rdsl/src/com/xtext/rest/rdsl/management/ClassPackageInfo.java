package com.xtext.rest.rdsl.management;

import java.util.ArrayList;
import java.util.List;

public class ClassPackageInfo {

	public enum CLASSTYPE{
		INTERFACE,
		CLASS,
		ABSTRACT_CLASS,
		OTHER
	}	
	
	private String className;
	private CLASSTYPE classType;
	private String packageName;
	private List<String> baseImports = new ArrayList<String>();
	
	public ClassPackageInfo(){
		this.className = "";
		this.classType = CLASSTYPE.CLASS;
		this.packageName = "";
	}
	
	public ClassPackageInfo(String className, String packageName){
		this.className = className;
		this.classType = CLASSTYPE.CLASS;
		this.packageName = packageName;
	}
	
	public ClassPackageInfo(String className, String packageName, CLASSTYPE classType){
		this(className, packageName);
		this.classType = classType;
	}
	
	public ClassPackageInfo(String className, String packageName, CLASSTYPE classType, List<String> baseimports){
		this(className, packageName, classType);
		if(baseimports != null)
			this.baseImports = baseimports;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public CLASSTYPE getClassType() {
		return classType;
	}

	public void setClassType(CLASSTYPE classType) {
		this.classType = classType;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public List<String> getBaseImports() {
		return baseImports;
	}

	public void setBaseImports(List<String> baseImports) {
		this.baseImports = baseImports;
	}
	
	public void addBaseImport(String importString){
		this.baseImports.add(importString);
	}
	
	/**
	 * return Returns the String which helps inmporting this class. 
	 */
	public String getClassImport(){
		return packageName + "." + className;
	}
	
	public String getGenerationLocation(){
		String tmp = packageName.replaceAll("\\.", "/");
		return  tmp + "/" + className;
	}
	
	@Override
	public String toString(){
		return className;
	}
}
