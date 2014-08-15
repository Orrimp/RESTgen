package de.fhws.rdsl.querylang.sql;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.ElementToStringTransformerContext;
import de.fhws.rdsl.querylang.ElementToStringTransformer;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;

public class SQLElementToStringConverter implements ElementToStringTransformer, FormatterContext {

    private ElementToStringTransformerContext context;

    @Override
    public String getString(Element element, ElementToStringTransformerContext context) {
        this.context = context;
        Formatter formatter = context.getFormatterProvider().getFormatter(element);
        return formatter.format(element, this);
    }

    @Override
    public String format(Element element) {
        return getString(element, this.context);
    }

}
