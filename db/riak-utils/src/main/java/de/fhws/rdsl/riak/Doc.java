package de.fhws.rdsl.riak;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.json.JSONObject;

public class Doc {

    private String id;
    private JSONObject fields;

    public Doc(String id, JSONObject fields) {
        super();
        this.id = id;
        this.fields = fields;
    }

    public JSONObject getFields() {
        return this.fields;
    }

    public String getId() {
        return this.id;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
