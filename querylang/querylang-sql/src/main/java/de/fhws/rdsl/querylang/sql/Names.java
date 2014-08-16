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

    public static String getTableName(Type type, List<Type> allTypes) {
        Type currentType = type;
        while (true) {
            Containment containment = Utils.findContainment(currentType, allTypes);
            if (containment == null || containment.isList()) {
                return currentType.getName();
            } else {
                currentType = Utils.findContainer(currentType, allTypes);
            }
        }
    }

    public static List<Property> getKeys(String prefix, Type type, List<Type> allTypes) {
        LinkedList<String> keys = Lists.newLinkedList();
        if (type instanceof RootResourceType) {
            keys.add("_" + type.getName() + "Id");
        } else if (type instanceof ReferenceType) {
            keys.addAll(type.getMembers().stream().filter(member -> member instanceof Reference).map(member -> ((Reference) member).getType())
                    .map(t -> "_" + t.getName() + "Id").collect(Collectors.toList()));
        } else {
            Type currentType = type;
            while (true) {
                Containment containment = Utils.findContainment(currentType, allTypes);
                if (containment == null) { // root
                    keys.addFirst("_" + currentType.getName() + "Id");
                    break;
                }
                if (!containment.isList()) { // 1:1
                } else { // 1:n
                    keys.addFirst("_" + getTableName(currentType, allTypes) + "Id");
                }
                currentType = Utils.findContainer(currentType, allTypes);
            }
        }

        return keys.stream().map(key -> new Property(prefix, key)).collect(Collectors.toList());
    }

    public static String joinPath(List<String> path) {
        return Joiner.on('.').join(path);
    }

}
