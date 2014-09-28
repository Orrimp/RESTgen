package de.fhws.rdsl.query.transformer.sql;

import de.fhws.rdsl.query.transformer.spi.DefaultFunctionProvider;
import de.fhws.rdsl.query.transformer.sql.functions.EqualsFunction;
import de.fhws.rdsl.query.transformer.sql.functions.NotFunction;
import de.fhws.rdsl.query.transformer.sql.functions.ValFunction;

public class SQLFunctionProvider extends DefaultFunctionProvider {

    public SQLFunctionProvider() {
        registerFunction(new EqualsFunction());
        registerFunction(new NotFunction());
        registerFunction(new ValFunction());
    }

}
