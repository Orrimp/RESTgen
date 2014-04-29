package com.xtext.rest.rdsl.generator.internals;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Orrimp
 * Provide support for annotations in classes. If this class is empty then no annotations should be created
 */
public class AnnotationUtils {

	private CharSequence classAnno = "";
	private CharSequence constrAnno = "";
	private CharSequence fieldAnno = "";
	private CharSequence getMethodAnno = "";
	private CharSequence setMethodAnno = "";
	private CharSequence methodAnno = "";
	private List<String> annoImports;
	
	public AnnotationUtils(){
		this.annoImports = new ArrayList<String>();
	}
	
	public CharSequence getClassAnno() {
		return classAnno;
	}
	public void setClassAnno(CharSequence classAnno) {
		this.classAnno = classAnno;
	}
	public CharSequence getConstrAnno() {
		return constrAnno;
	}
	public void setConstrAnno(CharSequence constrAnno) {
		this.constrAnno = constrAnno;
	}
	public CharSequence getFieldAnno() {
		return fieldAnno;
	}
	public void setFieldAnno(CharSequence fieldAnno) {
		this.fieldAnno = fieldAnno;
	}
	public CharSequence getGetMethodAnno() {
		return getMethodAnno;
	}
	public void setGetMethodAnno(CharSequence getMethodAnno) {
		this.getMethodAnno = getMethodAnno;
	}
	public CharSequence getSetMethodAnno() {
		return setMethodAnno;
	}
	public void setSetMethodAnno(CharSequence setMethodAnno) {
		this.setMethodAnno = setMethodAnno;
	}
	public CharSequence getMethodAnno() {
		return methodAnno;
	}
	public void setMethodAnno(CharSequence methodAnno) {
		this.methodAnno = methodAnno;
	}

	public List<String> getAnnoImports() {
		return annoImports;
	}

	public void setAnnoImports(List<String> annoImports) {
		this.annoImports = annoImports;
	}

}
