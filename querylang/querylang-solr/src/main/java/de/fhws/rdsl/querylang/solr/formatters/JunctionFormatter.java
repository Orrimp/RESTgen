package de.fhws.rdsl.querylang.solr.formatters;

import java.util.List;

import com.google.common.base.Joiner;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.JunctionElement;
import de.fhws.rdsl.querylang.formatter.Formatter;

public class JunctionFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof JunctionElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        JunctionElement junctionElement = (JunctionElement) element;
        List<Element> children = junctionElement.getChildren();
        String op = junctionElement.getType() == JunctionElement.AND ? " AND " : " OR ";
        return "(" + Joiner.on(op).join(children.stream().map(child -> context.format(child)).iterator()) + ")";
    }

}
