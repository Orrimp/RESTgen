package de.fhws.rdsl.querylang.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;
import de.fhws.rdsl.querylang.sql.elements.JunctionElement;

public class JunctionFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof JunctionElement;
    }

    @Override
    public String format(Element element, FormatterContext context) {
        JunctionElement junctionElement = (JunctionElement) element;
        String op = junctionElement.getType() == JunctionElement.AND ? " and " : " or ";
        String sql = "(" + Joiner.on(op).join(junctionElement.getChildren().stream().map(child -> context.format(child)).iterator()) + ")";
        return sql;
    }

}
