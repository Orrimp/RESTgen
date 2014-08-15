package de.fhws.rdsl.querylang.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.sql.elements.SelectElement;

public class SelectFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof SelectElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
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
