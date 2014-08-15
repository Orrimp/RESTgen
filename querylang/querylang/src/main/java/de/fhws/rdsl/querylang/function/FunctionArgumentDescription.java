package de.fhws.rdsl.querylang.function;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class FunctionArgumentDescription {

    private int[] types;
    private boolean nullAllowed;

    public FunctionArgumentDescription(int[] types, boolean nullAllowed) {
        super();
        this.types = types;
        this.nullAllowed = nullAllowed;
    }

    public int[] getTypes() {
        return this.types;
    }

    public boolean isNullAllowed() {
        return this.nullAllowed;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
