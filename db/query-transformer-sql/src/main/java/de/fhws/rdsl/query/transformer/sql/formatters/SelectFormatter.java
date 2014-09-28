package de.fhws.rdsl.query.transformer.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.SelectElement;

public class SelectFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof SelectElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        SelectElement selectElement = (SelectElement) element;
        String distinct = selectElement.isDistinct() ? "distinct " : "";
        String properties = Joiner.on(", ").join(selectElement.getProperties().stream().map(child -> context.format(child)).iterator());
        String select = "select ";
        if (selectElement.isCount()) {
            select += "count(" + distinct + properties + ")";
        } else {
            select += distinct + properties;
        }
        String from = "from `" + selectElement.getFromTable() + "` `" + selectElement.getFromTableAlias() + "`";
        return select + " " + from;
    }

}
