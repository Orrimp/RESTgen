package com.xtext.rest.rdsl.generator

import com.xtext.rest.rdsl.restDsl.CollectionResource
import com.xtext.rest.rdsl.restDsl.Datatype
import com.xtext.rest.rdsl.restDsl.DispatcherResource
import com.xtext.rest.rdsl.restDsl.GlobalTratis
import com.xtext.rest.rdsl.restDsl.RESTSecurity
import com.xtext.rest.rdsl.restDsl.SingleResource
import com.xtext.rest.rdsl.restDsl.impl.RestDslFactoryImpl
import java.util.ArrayList
import java.util.List
import com.xtext.rest.rdsl.restDsl.ResourceView

class RESTResourceObjects {

	val RESTSecurity security;
	val List<SingleResource> singleResources;
	val List<CollectionResource> collResources;
	val DispatcherResource dispatchResource;
	val GlobalTratis gloablTraits;
	val SingleResource userResource

	public new(List<SingleResource> singleResources, List<CollectionResource> collResources,
		DispatcherResource dispatchResource, GlobalTratis gloablTraits, RESTSecurity security) {
		this.singleResources = singleResources;
		this.collResources = collResources;
		this.dispatchResource = dispatchResource;
		this.gloablTraits = gloablTraits;
		this.userResource = createUserResource();
		this.security = security;
		createIdAttriutes();
	}

	def SingleResource createUserResource() {
		var res = RestDslFactoryImpl.eINSTANCE.createSingleResource;
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
		for (SingleResource sing : singleResources) {
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


	public def List<SingleResource> getSingleResources() {

		if (singleResources != null) {
			return this.singleResources;
		} else {
			return new ArrayList<SingleResource>();
		}
	}

	public def List<CollectionResource> getCollectionResources() {
		if (this.collResources != null) {
			return this.collResources;
		} else {
			return new ArrayList<CollectionResource>();
		}
	}

	public def DispatcherResource getDispatcheResource() {
		return this.dispatchResource;
	}

	public def GlobalTratis getGlobalTraits() {
		return this.gloablTraits;
	}

	public def SingleResource getUserResource() {
		return this.userResource;
	}

	public def RESTSecurity getSecurity() {
		return this.security;
	}

}
