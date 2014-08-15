package de.fhws.rdsl.querylang.schema;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import com.google.common.collect.Lists;

public class Schema implements Iterable<Type> {
    private List<Type> allTypes = Lists.newArrayList();

    public Schema(List<Type> allTypes) {
        super();
        this.allTypes.addAll(allTypes);
    }

    public List<Type> getAllTypes() {
        return Collections.unmodifiableList(this.allTypes);
    }

    public Type findType(String name) {
        return Utils.findTypeByName(name, this.allTypes);
    }

    @Override
    public Iterator<Type> iterator() {
        return this.allTypes.iterator();
    }

}
