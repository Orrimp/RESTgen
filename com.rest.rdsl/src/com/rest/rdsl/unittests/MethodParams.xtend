package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Constants

class MethodParams
{
	static def generatePrimitivesMethod(AttributeExtractor attributeExtractor)
	{
		'''
	protected Object[] «Constants.PRIMITIVE_ATTRIBUTE_PARAMS»()
	{
		return new Object[]{
			«FOR attribute: attributeExtractor.getPrimitives()»
				new Object[]{(new String("«attribute»"))},
			«ENDFOR»
			};
	}
	 
		'''
	}
	
	static def generatePrimitivesWithLowerBound(AttributeExtractor attributeExtractor)
	{
		'''
	protected Object[] «Constants.PRIMITIVES_WITH_LOWER_BOUND_PARAMS»()
	{
		return new Object[]{
			«FOR attribute: attributeExtractor.getPrimitivesWithLowerBound()»
				new Object[]{(new String("«attribute»"))},
			«ENDFOR»
			};
	}
	 
		'''
	}
	
	static def generatePrimitivesWithUpperBound(AttributeExtractor attributeExtractor)
	{
		'''
	protected Object[] «Constants.PRIMITIVES_WITH_UPPER_BOUND_PARAMS»()
	{
		return new Object[]{
			«FOR attribute: attributeExtractor.getPrimitivesWithUpperBound()»
				new Object[]{(new String("«attribute»"))},
			«ENDFOR»
			};
	}
	 
		'''
	}
	
	static def generateStringsMethod(AttributeExtractor attributeExtractor)
	{
		'''
	protected Object[] «Constants.STRING_ATTRIBUTE_PARAMS»()
	{
		return new Object[]{
			«FOR attribute: attributeExtractor.getStrings()»
				new Object[]{(new String("«attribute»"))},
			«ENDFOR»
			};
	}
	 
		'''
	}
	
	static def generateStringsWithContextMethod(AttributeExtractor attributeExtractor)
	{
		'''
	protected Object[] «Constants.STRING_ATTRIBUTE_WITH_CONTEXT_PARAMS»()
	{
		return new Object[]{
			«FOR attribute: attributeExtractor.getStringsWithContext()»
				new Object[]{(new String("«attribute»"))},
			«ENDFOR»
			};
	}
	 
		'''
	}
	
	static def generateNonStringsMethod(AttributeExtractor attributeExtractor)
	{
		'''
	protected Object[] «Constants.NON_STRING_ATTRIBUTE_PARAMS»()
	{
		return new Object[]{
			«FOR attribute: attributeExtractor.getNonStrings()»
				new Object[]{(new String("«attribute»"))},
			«ENDFOR»
			};
	}
	 
		'''
	}
	
	static def generatePermutatedPatchResources(PermutationGenerator permGen)
	{
		'''
	protected Object[] «Constants.PERMUTATED_PATCH_PARAMS»()
	{
		«permGen.getPermutatedPatchResources()»
	}
	 
		'''
	}
	
	static def generatePermutatedQueryParameters(PermutationGenerator permGen)
	{
		'''
	@SuppressWarnings({"serial"})
	protected Object[] getQueryParameters()
	{
		«permGen.getPermutatedQueryParameters()»
	}
	 
		'''
	}
}
