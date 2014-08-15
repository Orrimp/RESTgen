package de.fhws.rdsl.querylang.solr;

import java.util.Map;

import com.google.common.collect.Maps;

import de.fhws.rdsl.querylang.ElementTransformer;
import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;

public class SolrElementTransformer implements ElementTransformer {

    private TransformerContext context;

    @Override
    public Map<String, Object> transform(Element element, TransformerContext context) {
        this.context = context;
        String solrQuery = format(element);
        Map<String, Object> map = Maps.newHashMap();
        map.put("solrQuery", solrQuery);
        return map;
    }

    public String format(Element element) {
        return this.context.format(element);
    }

}
