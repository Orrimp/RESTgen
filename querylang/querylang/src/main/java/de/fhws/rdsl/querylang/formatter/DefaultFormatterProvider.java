package de.fhws.rdsl.querylang.formatter;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.elements.Element;

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

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
