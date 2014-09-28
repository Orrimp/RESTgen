package de.fhws.rdsl.query.transformer.sql.formatters;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.JoinElement;
import de.fhws.rdsl.query.transformer.sql.elements.StatementElement;

public class StatementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof StatementElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        StatementElement statementElement = (StatementElement) element;
        String sql = context.format(statementElement.getSelect()) + "\n";
        for (JoinElement join : statementElement.getJoins()) {
            sql += context.format(join) + "\n";
        }
        sql += "where " + context.format(statementElement.getFilter());
        if (statementElement.getOrder() != null) {
            sql += "\n" + context.format(statementElement.getOrder());
        }
        if (statementElement.getStart() != null && statementElement.getSize() != null) {
            sql += "\nlimit " + statementElement.getStart() + ", " + statementElement.getSize();
        } else if (statementElement.getSize() != null && statementElement.getStart() == null) {
            sql += "\nlimit " + statementElement.getSize();
        }
        return sql;
    }

}
