package de.fhws.rdsl.query.transformer.sql;

import java.util.Map;

import com.google.common.collect.Maps;

import de.fhws.rdsl.query.transformer.spi.ElementTransformer;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.QueriesElement;

public class SQLElementTransformer implements ElementTransformer {

    private TransformerContext context;

    @Override
    public Map<String, Object> transform(TargetElement element, TransformerContext context) {
        this.context = context;
        QueriesElement queriesElement = (QueriesElement) element;
        String sqlString = format(queriesElement.getQuery());
        String sqlCountQuery = format(queriesElement.getCountQuery());
        Map<String, Object> map = Maps.newHashMap();
        map.put("sqlQuery", sqlString);
        map.put("sqlCountQuery", sqlCountQuery);
        return map;
    }

    public String format(TargetElement element) {
        return this.context.format(element);
    }

}
