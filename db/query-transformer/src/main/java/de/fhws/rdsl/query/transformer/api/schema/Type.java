package de.fhws.rdsl.query.transformer.api.schema;

import java.util.List;

import com.google.common.collect.Lists;

public abstract class Type extends Element {

    private List<Member> members = Lists.newArrayList();
    private String name;

    public Type(String name) {
        super();
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public List<Member> getMembers() {
        return this.members;
    }

    public Member getMember(String name) {
        for (Member member : this.members) {
            if (name.equalsIgnoreCase(member.getName())) {
                return member;
            }
        }
        return null;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Type) {
            Type type = (Type) obj;
            if (this.name.equals(type.name)) {
                return true;
            }

        }
        return false;
    }

    @Override
    public String toString() {
        return getClass().getSimpleName() + " [name: " + this.name + "]";
    }
}