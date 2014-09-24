package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.RESTResource
import java.util.ArrayList
import java.util.List

class PermutationGenerator 
{
	val RESTResource resource;
	
	new(RESTResource resource)
	{
		this.resource = resource;
	}

	def String getPermutatedPatchResources()
	{
		val List<List<PermutationElement>> layers = getPermutatedLayers();
		
		'''
return new Object[]{
		«FOR element: layers»
			«getStrings(element)»,
		«ENDFOR»
};
		'''
	}
	
	private def String getStrings(List<PermutationElement> elements)
	{
		var StringBuffer result = new StringBuffer("new Object[]{(new String(\"{");
		
		var first = true;
		for(PermutationElement element: elements)
		{
			if(!first)
			{
				result.append(", ");
			}
			
			result.append("\\\"");
			result.append(element.getKey());
			result.append("\\\":");
			
			val simpleName = element.getValue().javaDataType.dataType.literal;
			if(simpleName.equals("String"))
			{
				result.append("\\\"\" + generators.get(\"" + simpleName + "\").getTestDataWithinLimits(\"" + 
					element.getKey() + "\") + \"\\\"");
			} else
			{
				result.append("\" + generators.get(\"" + simpleName + "\").getTestDataWithinLimits(\"" + 
					element.getKey() + "\") + \"");
			}
			
			first = false;
		}
		result.append("}\"))}")
		
		return result.toString();
	}
	
	def String getPermutatedQueryParameters()
	{
		val List<List<PermutationElement>> layers = getPermutatedLayers();
		layers.remove(0);
		'''
return new Object[]{
		«FOR element: layers»
			«getHashMaps(element)»,
		«ENDFOR»
};
		'''
	}
	
	private def String getHashMaps(List<PermutationElement> elements)
	{
		var StringBuffer result = new StringBuffer("new Object[]{new HashMap<String,Object>(){{");
		
		for(PermutationElement element: elements)
		{
			result.append("put(\"");
			result.append(element.getKey());
			result.append("\", ")
			
			val simpleName = element.getValue().javaDataType.dataType.literal;
			result.append("generators.get(\"");
			result.append(simpleName);
			result.append("\").getTestDataWithinLimits(\"" + element.getKey() + "\")); ");
		}
		
		result.append("}}}")
		
		return result.toString();
	}
	
	private def List<List<PermutationElement>> getPermutatedLayers()
	{
		var int n = resource.attributes.size() + 1;
		var List<List<List<PermutationElement>>> layers = new ArrayList<List<List<PermutationElement>>>();
		layers.add(initLayer0());
		layers.add(initLayer1());
		
		for(k : 2..< n)
		{
			var List<List<PermutationElement>> layerNow = new ArrayList<List<PermutationElement>>();
			
			val List<List<PermutationElement>> layerBefore = layers.get(k - 1);
			
			for(List<PermutationElement> element: layerBefore)
			{
				var List<PermutationElement> lastElement = new ArrayList<PermutationElement>();
				lastElement.add(element.last());
				var index = layers.get(1).indexOf(lastElement) + 1;
				
				for(x : index..< layers.get(1).size())
				{
					layerNow.add(combine(element, layers.get(1).get(x)));
				}
			}
			
			layers.add(layerNow);
		}
		
		var List<List<PermutationElement>> permutatedLayers = new ArrayList<List<PermutationElement>>();
		
		for(List<List<PermutationElement>> layer : layers)
		{
			permutatedLayers.addAll(layer);
		}
		
		return permutatedLayers;
	}
	
	private def List<List<PermutationElement>> initLayer0()
	{
		var List<List<PermutationElement>> layer0 = new ArrayList<List<PermutationElement>>();
		layer0.add(new ArrayList<PermutationElement>());
		
		return layer0;		
	}
	
	private def List<List<PermutationElement>> initLayer1()
	{
		var List<List<PermutationElement>> layer1 = new ArrayList<List<PermutationElement>>();
		
		val attributes = resource.attributes;
		for(Attribute a: attributes)
		{
			if(a.value instanceof JavaReference)
			{
				var List<PermutationElement> element = new ArrayList<PermutationElement>();
				element.add(new PermutationElement(a.name, a.value as JavaReference));
				layer1.add(element);
			}
		}
		
		return layer1;
	}
	
	private def List<PermutationElement> combine(List<PermutationElement> currentElement, List<PermutationElement> baseElement)
	{
		var List<PermutationElement> newElement = new ArrayList<PermutationElement>();
		
		for(PermutationElement element: currentElement)
		{
			newElement.add(new PermutationElement(element));
		}
		
		for(PermutationElement element: baseElement)
		{
			newElement.add(new PermutationElement(element));
		}
		
		return newElement;
	}
}