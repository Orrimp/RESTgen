package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.sql.elements.JoinElement;
import de.fhws.rdsl.querylang.sql.elements.StatementElement;

public class StatementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof StatementElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        StatementElement statementElement = (StatementElement) element;
        String sql = context.format(statementElement.getSelect()) + "\n";
        for (JoinElement join : statementElement.getJoins()) {
            sql += context.format(join) + "\n";
        }
        sql += "where " + context.format(statementElement.getFilter());
        if (statementElement.getOrder() != null) {
            sql += "\n" + context.format(statementElement.getOrder());
        }
        if (statementElement.getStart() != null && statementElement.getOffset() != null) {
            sql += "\nlimit " + statementElement.getStart() + ", " + statementElement.getOffset();
        } else if (statementElement.getOffset() != null && statementElement.getStart() == null) {
            sql += "\nlimit " + statementElement.getOffset();
        }
        return sql;
    }

}
