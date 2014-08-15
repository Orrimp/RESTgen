package de.fhws.rdsl.querylang;

import de.fhws.rdsl.querylang.formatter.FormatterProvider;

public class ElementToStringTransformerContext {

    private FormatterProvider formatterProvider;

    public ElementToStringTransformerContext(FormatterProvider formatterProvider) {
        super();
        this.formatterProvider = formatterProvider;
    }

    public FormatterProvider getFormatterProvider() {
        return this.formatterProvider;
    }

}
