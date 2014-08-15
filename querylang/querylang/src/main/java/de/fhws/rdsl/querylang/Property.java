package de.fhws.rdsl.querylang;

import com.google.common.base.Strings;

public class Property {

    private String namespace;
    private String name;

    public Property(String namespace, String name) {
        super();
        this.namespace = namespace;
        this.name = name;
    }

    public Property(String name) {
        this(null, name);
    }

    public String getName() {
        return this.name;
    }

    public String getNamespace() {
        return this.namespace;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }

    @Override
    public String toString() {
        if (Strings.isNullOrEmpty(this.namespace)) {
            return this.name;
        } else {
            return this.namespace + "." + this.name;
        }
    }

}
