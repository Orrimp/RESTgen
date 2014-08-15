package de.fhws.rdsl.querylang.sql;

import de.fhws.rdsl.querylang.formatter.DefaultFormatterProvider;
import de.fhws.rdsl.querylang.sql.formatters.BooleanElementFormatter;
import de.fhws.rdsl.querylang.sql.formatters.DoubleFormatter;
import de.fhws.rdsl.querylang.sql.formatters.EqualsFormatter;
import de.fhws.rdsl.querylang.sql.formatters.IntegerFormatter;
import de.fhws.rdsl.querylang.sql.formatters.JoinFormatter;
import de.fhws.rdsl.querylang.sql.formatters.JunctionFormatter;
import de.fhws.rdsl.querylang.sql.formatters.NotFormatter;
import de.fhws.rdsl.querylang.sql.formatters.NullFormatter;
import de.fhws.rdsl.querylang.sql.formatters.OrderFormatter;
import de.fhws.rdsl.querylang.sql.formatters.PropertyFormatter;
import de.fhws.rdsl.querylang.sql.formatters.SelectFormatter;
import de.fhws.rdsl.querylang.sql.formatters.StatementFormatter;
import de.fhws.rdsl.querylang.sql.formatters.StringFormatter;

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
