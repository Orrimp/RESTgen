package de.fhws.rdsl.querylang.formatter;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.Element;

public class DefaultFormatterProvider implements FormatterProvider {

    private List<Formatter> formatters = Lists.newArrayList();

    @Override
    public Formatter getFormatter(Element element) {
        return this.formatters.stream().filter(formatter -> formatter.isFormatterFor(element)).findFirst().orElse(null);
    }

    @Override
    public void registerFormatter(Formatter formatter) {
        this.formatters.add(0, formatter);
    }

}
