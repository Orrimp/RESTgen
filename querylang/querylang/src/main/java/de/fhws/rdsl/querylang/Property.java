package de.fhws.rdsl.querylang;

import java.util.Collections;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.google.common.collect.Lists;

public class Property {

    private List<String> path = Lists.newArrayList();

    public Property(String... names) {
        super();
        Collections.addAll(this.path, names);
    }

    public Property(List<String> names) {
        super();
        this.path.addAll(names);
    }

    public String getName() {
        return this.path.get(this.path.size() - 1);
    }

    public List<String> getNamespace() {
        if (this.path.size() == 1) {
            return Collections.emptyList();
        } else {
            return this.path.subList(0, this.path.size() - 1);
        }
    }

    public List<String> getPath() {
        return this.path;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Property) {
            Property other = (Property) obj;
            if (other.getPath().size() == getPath().size()) {
                for (int i = 0; i < other.getPath().size(); i++) {
                    if (getPath().get(i).equalsIgnoreCase(other.getPath().get(i))) {
                        continue;
                    } else {
                        return false;
                    }
                }
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
