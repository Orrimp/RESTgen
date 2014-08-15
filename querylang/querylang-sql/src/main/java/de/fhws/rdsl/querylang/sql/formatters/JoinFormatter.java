package de.fhws.rdsl.querylang.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.sql.elements.JoinElement;

public class JoinFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof JoinElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        JoinElement joinElement = (JoinElement) element;
        String sql = "join " + joinElement.getTable() + " " + joinElement.getTableAlias() + " on ";
        sql += Joiner.on(" and ").join(joinElement.getProperties().stream().map(child -> context.format(child)).iterator());
        return sql;
    }

}
