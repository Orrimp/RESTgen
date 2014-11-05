package com.xtext.rest.rdsl.generator

import com.xtext.rest.rdsl.restDsl.Datatype
import com.xtext.rest.rdsl.restDsl.DispatcherResource
import com.xtext.rest.rdsl.restDsl.GlobalTratis
import com.xtext.rest.rdsl.restDsl.RESTSecurity
import com.xtext.rest.rdsl.restDsl.impl.RestDslFactoryImpl
import java.util.ArrayList
import java.util.List
import com.xtext.rest.rdsl.restDsl.ResourceView
import com.xtext.rest.rdsl.restDsl.RESTState

class RESTResourceObjects {

	val RESTSecurity security;
	val List<RESTState> singleResources;
	val DispatcherResource dispatchResource;
	val GlobalTratis gloablTraits;
	val RESTState userResource

	public new(List<RESTState> singleResources,	DispatcherResource dispatchResource, GlobalTratis gloablTraits, RESTSecurity security) {
		this.singleResources = singleResources;
		this.dispatchResource = dispatchResource;
		this.gloablTraits = gloablTraits;
		this.userResource = createUserResource();
		this.security = security;
		createIdAttriutes();
	}

	def RESTState createUserResource() {
		var res = RestDslFactoryImpl.eINSTANCE.createRESTState;
		var resView = RestDslFactoryImpl.eINSTANCE.createResourceView;
		var userName = RestDslFactoryImpl.eINSTANCE.createAttribute;
		var password = RestDslFactoryImpl.eINSTANCE.createAttribute;
		var javaRef = RestDslFactoryImpl.eINSTANCE.createJavaReference;
		var primType = RestDslFactoryImpl.eINSTANCE.createPrimitiveType;

		primType.dataType = Datatype.STRING
		javaRef.javaDataType = primType;
		userName.name = "username";
		userName.value = javaRef;
		password.name = "password";
		password.value = javaRef;
		res.resources.add(resView);
		res.name = "AuthUser"

		this.singleResources.add(res);
		return res;
	}

	def createIdAttriutes() {
		for (RESTState sing : singleResources) {
			for (ResourceView view : sing.resources) {
				creatIdAttribute(view);
			}
		}
	}

	def creatIdAttribute(ResourceView view) {
		var id = RestDslFactoryImpl.eINSTANCE.createAttribute;
		var javaRef = RestDslFactoryImpl.eINSTANCE.createJavaReference;
		var primType = RestDslFactoryImpl.eINSTANCE.createPrimitiveType;

		var dataype = this.gloablTraits.idtype.literal.toFirstUpper;
		
		switch(dataype){
			case "String": primType.dataType = Datatype.STRING
			case "Long" : primType.dataType = Datatype.LONG
		}
		javaRef.javaDataType = primType;
		id.value = javaRef;
		id.name = "id"
		view.attributes.add(id);
	}


	public def List<RESTState> getSingleResources() {

		if (singleResources != null) {
			return this.singleResources;
		} else {
			return new ArrayList<RESTState>();
		}
	}

	public def DispatcherResource getDispatcheResource() {
		return this.dispatchResource;
	}

	public def GlobalTratis getGlobalTraits() {
		return this.gloablTraits;
	}

	public def RESTState getUserResource() {
		return this.userResource;
	}

	public def RESTSecurity getSecurity() {
		return this.security;
	}
}
