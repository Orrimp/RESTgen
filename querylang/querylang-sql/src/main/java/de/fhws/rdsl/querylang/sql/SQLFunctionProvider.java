package de.fhws.rdsl.querylang.sql;

import de.fhws.rdsl.querylang.function.DefaultFunctionProvider;
import de.fhws.rdsl.querylang.sql.functions.EqualsFunction;

public class SQLFunctionProvider extends DefaultFunctionProvider {

    public SQLFunctionProvider() {
        registerFunction(new EqualsFunction());
    }

}
