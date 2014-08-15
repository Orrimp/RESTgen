package de.fhws.rdsl.querylang.schema;

import java.util.List;

public class Utils {

    public static Member findMemberByName(String name, Type type) {
        for (Member member : type.members) {
            if (name.equalsIgnoreCase(member.name)) {
                return member;
            }
        }
        return null;
    }

    public static Type findTypeByName(String name, List<Type> types) {
        for (Type type : types) {
            if (type.name.equalsIgnoreCase(name)) {
                return type;
            }
        }
        return null;
    }

    public static Containment findContainment(Type type, List<Type> types) {
        for (Type element : types) {
            for (Member member : element.members) {
                if (member instanceof Containment) {
                    if (((Containment) member).resourceType == type) {
                        return (Containment) member;
                    }
                }
            }
        }
        return null;
    }

    public static Type findContainer(Type type, List<Type> types) {
        for (Type element : types) {
            for (Member member : element.members) {
                if (member instanceof Containment) {
                    if (((Containment) member).resourceType == type) {
                        return element;
                    }
                }
            }
        }
        return null;
    }

    public static Reference findFirstReference(ReferenceType type, Type target, List<Type> types) {
        for (Type element : types) {
            for (Member member : element.members) {
                if (member instanceof Reference) {
                    if (((Reference) member).referenceType == type) {
                        if (target != null) {
                            if (((Reference) member).resourceType == target) {
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
            for (Member member : element.members) {
                if (member == attribute) {
                    return element;
                }
            }
        }
        return null;
    }

}
