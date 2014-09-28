package de.fhws.rdsl.query.transformer.api.schema;

import java.util.Collection;
import java.util.List;
import java.util.stream.Stream;

public class Utils {

    public static Member findMemberByName(String name, Type type) {
        return type.getMembers().stream().filter(member -> member.getName().equalsIgnoreCase(name)).findFirst().orElse(null);
    }

    public static Type findTypeByName(String name, List<Type> types) {
        return types.stream().filter(type -> type.getName().equalsIgnoreCase(name)).findFirst().orElse(null);
    }

    public static Containment findContainment(Type type, List<Type> types) {
        Stream<Member> members = types.stream().map(t -> t.getMembers()).flatMap(Collection::stream);
        return (Containment) members.filter(m -> m instanceof Containment && ((Containment) m).getResourceType() == type).findFirst().orElse(null);
    }

    public static Type findContainer(Type type, List<Type> types) {
        for (Type element : types) {
            for (Member member : element.getMembers()) {
                if (member instanceof Containment) {
                    if (((Containment) member).getResourceType() == type) {
                        return element;
                    }
                }
            }
        }
        return null;
    }

    public static Reference findFirstReference(ReferenceType type, Type target, List<Type> types) {
        for (Type element : types) {
            for (Member member : element.getMembers()) {
                if (member instanceof Reference) {
                    if (((Reference) member).getType() == type) {
                        if (target != null) {
                            if (((Reference) member).getType() == target) {
                                return (Reference) member;
                            }
                        } else {
                            return (Reference) member;
                        }
                    }
                }
            }
        }
        return null;
    }

    public static Reference findFirstReference(ReferenceType type, List<Type> types) {
        return findFirstReference(type, null, types);
    }

    public static Type findType(Member attribute, List<Type> types) {
        for (Type element : types) {
            for (Member member : element.getMembers()) {
                if (member == attribute) {
                    return element;
                }
            }
        }
        return null;
    }

}
