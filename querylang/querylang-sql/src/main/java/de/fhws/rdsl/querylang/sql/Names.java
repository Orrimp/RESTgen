package de.fhws.rdsl.querylang.sql;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

import com.google.common.base.Joiner;
import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.schema.Containment;
import de.fhws.rdsl.querylang.schema.Reference;
import de.fhws.rdsl.querylang.schema.ReferenceType;
import de.fhws.rdsl.querylang.schema.RootResourceType;
import de.fhws.rdsl.querylang.schema.Type;
import de.fhws.rdsl.querylang.schema.Utils;

public class Names {

    public static String getReferenceTableIdProperty(RootResourceType type) {
        return type.name + "Id";
    }

    public static String getTableName(Type type, List<Type> allTypes) {
        Type currentType = type;
        while (true) {
            Containment containment = Utils.findContainment(currentType, allTypes);
            if (containment == null || containment.list) {
                return currentType.name;
            } else {
                currentType = Utils.findContainer(currentType, allTypes);
            }
        }
    }

    public static List<Property> getKeys(String prefix, Type type, List<Type> allTypes) {
        LinkedList<String> keys = Lists.newLinkedList();
        if (type instanceof ReferenceType) {
            Reference reference = Utils.findFirstReference((ReferenceType) type, allTypes);
            RootResourceType container = (RootResourceType) Utils.findType(reference, allTypes);
            keys.addAll(Lists.newArrayList(getReferenceTableIdProperty(reference.resourceType), getReferenceTableIdProperty(container)));
        } else {
            Type currentType = type;
            while (true) {
                Containment containment = Utils.findContainment(currentType, allTypes);
                if (containment == null) { // root
                    keys.addLast("id");
                    break;
                }
                currentType = Utils.findContainer(currentType, allTypes);
                if (!containment.list) { // 1:1
                } else { // 1:n
                    keys.addFirst(getTableName(currentType, allTypes) + "Id");
                }
            }
        }

        return keys.stream().map(key -> new Property(prefix, key)).collect(Collectors.toList());
    }

    public static String joinPath(List<String> path) {
        return Joiner.on('.').join(path);
    }

}
