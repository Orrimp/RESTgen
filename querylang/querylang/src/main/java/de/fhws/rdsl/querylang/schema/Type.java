package de.fhws.rdsl.querylang.schema;

import java.util.List;

import com.google.common.collect.Lists;

public class Type extends Element {

    public List<Member> members = Lists.newArrayList();
    public String name;

    public Member getMember(String name) {
        for (Member member : this.members) {
            if (name.equals(member.name)) {
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