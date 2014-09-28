package de.fhws.rdsl.query.transformer.sql;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import de.fhws.rdsl.query.transformer.api.schema.Member;
import de.fhws.rdsl.query.transformer.api.schema.Type;

public class Join {

    protected Type from;
    protected Member via;
    protected Type to;
    protected String aliasFrom;
    protected String aliasTo;

    public Join(Type from, Member via, Type to) {
        super();
        this.from = from;
        this.via = via;
        this.to = to;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Join) {
            Join join = (Join) obj;
            if (this.from.equals(join.from) && this.to.equals(join.to) && this.via.equals(join.via)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
