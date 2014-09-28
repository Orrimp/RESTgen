package de.fhws.rdsl.query.transformer.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.JunctionElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class JunctionFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof JunctionElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        JunctionElement junctionElement = (JunctionElement) element;
        String op = junctionElement.getType() == JunctionElement.AND ? " and " : " or ";
        String sql = "(" + Joiner.on(op).join(junctionElement.getChildren().stream().map(child -> context.format(child)).iterator()) + ")";
        return sql;
    }

}
