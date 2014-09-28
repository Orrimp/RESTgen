package de.fhws.rdsl.query.transformer.sql;

import de.fhws.rdsl.query.transformer.spi.DefaultFormatterProvider;
import de.fhws.rdsl.query.transformer.sql.formatters.BooleanElementFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.DoubleFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.EqualsFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.IntegerFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.JoinFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.JunctionFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.NotFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.NullFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.OrderFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.PropertyFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.SelectFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.StatementFormatter;
import de.fhws.rdsl.query.transformer.sql.formatters.StringFormatter;

public class SQLFormatterProvider extends DefaultFormatterProvider {

    public SQLFormatterProvider() {
        registerFormatter(new BooleanElementFormatter());
        registerFormatter(new DoubleFormatter());
        registerFormatter(new EqualsFormatter());
        registerFormatter(new IntegerFormatter());
        registerFormatter(new JoinFormatter());
        registerFormatter(new JunctionFormatter());
        registerFormatter(new NullFormatter());
        registerFormatter(new PropertyFormatter());
        registerFormatter(new SelectFormatter());
        registerFormatter(new StatementFormatter());
        registerFormatter(new StringFormatter());
        registerFormatter(new OrderFormatter());
        registerFormatter(new NotFormatter());
    }

}
