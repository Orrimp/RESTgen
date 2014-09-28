package de.fhws.rdsl.query.transformer.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.JoinElement;

public class JoinFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof JoinElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        JoinElement joinElement = (JoinElement) element;
        String sql = "join " + joinElement.getTable() + " " + joinElement.getTableAlias() + " on ";
        sql += Joiner.on(" and ").join(joinElement.getProperties().stream().map(child -> context.format(child)).iterator());
        return sql;
    }

}
