package de.fhws.rdsl.querylang.sql;

import java.util.Map;

import com.google.common.collect.Maps;

import de.fhws.rdsl.querylang.ElementTransformer;
import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.sql.elements.QueriesElement;

public class SQLElementTransformer implements ElementTransformer {

    private TransformerContext context;

    @Override
    public Map<String, Object> transform(Element element, TransformerContext context) {
        this.context = context;
        QueriesElement queriesElement = (QueriesElement) element;
        String sqlString = format(queriesElement.getQuery());
        String sqlCountQuery = format(queriesElement.getCountQuery());
        Map<String, Object> map = Maps.newHashMap();
        map.put("sqlQuery", sqlString);
        map.put("sqlCountQuery", sqlCountQuery);
        return map;
    }

    public String format(Element element) {
        return this.context.format(element);
    }

}
