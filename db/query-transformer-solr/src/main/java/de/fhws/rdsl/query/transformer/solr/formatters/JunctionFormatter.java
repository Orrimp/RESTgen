package de.fhws.rdsl.query.transformer.solr.formatters;

import java.util.List;

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
        List<TargetElement> children = junctionElement.getChildren();
        String op = junctionElement.getType() == JunctionElement.AND ? " AND " : " OR ";
        return "(" + Joiner.on(op).join(children.stream().map(child -> context.format(child)).iterator()) + ")";
    }

}
