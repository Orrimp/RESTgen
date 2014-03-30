package com.xtext.rest.rdsl.generator.framework

import com.xtext.rest.rdsl.restDsl.Attribute

public abstract class MethodGenerator {
	
	public def CharSequence generateGETAttribute(Attribute attribute);
	public def CharSequence generatePOST();
	public def CharSequence generatePUT();
	public def CharSequence generatePATCH();
	public def CharSequence generateDELETE();
	public def CharSequence generateGET();
}