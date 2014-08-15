package de.fhws.rdsl.querylang.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;
import de.fhws.rdsl.querylang.sql.elements.SelectElement;

public class SelectFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof SelectElement;
    }

    @Override
    public String format(Element element, FormatterContext context) {
        SelectElement selectElement = (SelectElement) element;
        String distinct = selectElement.isDistinct() ? "distinct " : "";
        String select = "select " + distinct + Joiner.on(", ").join(selectElement.getProperties().stream().map(child -> context.format(child)).iterator());
        String from = "from `" + selectElement.getFromTable() + "` `" + selectElement.getFromTableAlias() + "`";
        return select + " " + from;
    }

}
