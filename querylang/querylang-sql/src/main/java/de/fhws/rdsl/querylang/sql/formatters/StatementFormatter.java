package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;
import de.fhws.rdsl.querylang.sql.elements.JoinElement;
import de.fhws.rdsl.querylang.sql.elements.StatementElement;

public class StatementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof StatementElement;
    }

    @Override
    public String format(Element element, FormatterContext context) {
        StatementElement statementElement = (StatementElement) element;
        String sql = context.format(statementElement.getSelect()) + "\n";
        for (JoinElement join : statementElement.getJoins()) {
            sql += context.format(join) + "\n";
        }
        sql += "where " + context.format(statementElement.getFilter());
        return sql;
    }

}
