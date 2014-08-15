package de.fhws.rdsl.querylang.sql;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.schema.Attribute;
import de.fhws.rdsl.querylang.schema.Containment;
import de.fhws.rdsl.querylang.schema.Reference;
import de.fhws.rdsl.querylang.schema.ReferenceType;
import de.fhws.rdsl.querylang.schema.RootResourceType;
import de.fhws.rdsl.querylang.schema.SubResourceType;
import de.fhws.rdsl.querylang.schema.Type;

public class AbstractSQLTransformerTest {

    protected List<Type> createTypes() {
        return getTypes();
    }

    private static List<Type> getTypes() {
        RootResourceType person = getPersonType();
        SubResourceType address = getAddressType();
        SubResourceType addressDescription = getAddressDescriptionType();
        SubResourceType dummy1 = getDummy1Type();
        SubResourceType dummy2 = getDummy2Type();
        RootResourceType company = getCompanyType();
        SubResourceType addressTags = getAddressTagsType();
        ReferenceType personManagedCompanyManager = getPersonManagedCompanyManagerType();
        person.members.add(new Containment() {
            {
                this.list = true;
                this.name = "addresses";
                this.resourceType = address;
            }
        });
        person.members.add(new Reference() {
            {
                this.list = true;
                this.name = "managedCompany";
                this.resourceType = company;
                this.opposite = "manager";
                this.referenceType = personManagedCompanyManager;
            }
        });
        person.members.add(new Attribute() {
            {
                this.list = false;
                this.name = "name";
            }
        });
        address.members.add(new Containment() {
            {
                this.list = false;
                this.name = "description";
                this.resourceType = addressDescription;
            }
        });
        address.members.add(new Attribute() {
            {
                this.list = false;
                this.name = "code";
            }
        });
        address.members.add(new Containment() {
            {
                this.list = true;
                this.name = "tags";
                this.resourceType = addressTags;
            }
        });
        addressTags.members.add(new Attribute() {
            {
                this.list = false;
                this.name = "value";
            }
        });
        addressDescription.members.add(new Containment() {
            {
                this.list = true;
                this.name = "dummy1";
                this.resourceType = dummy1;
            }
        });
        addressDescription.members.add(new Containment() {
            {
                this.list = false;
                this.name = "dummy2";
                this.resourceType = dummy2;
            }
        });
        addressDescription.members.add(new Attribute() {
            {
                this.list = true;
                this.name = "author";
            }
        });
        company.members.add(new Attribute() {
            {
                this.list = false;
                this.name = "name";
            }
        });

        company.members.add(new Reference() {
            {
                this.list = true;
                this.name = "manager";
                this.resourceType = person;
                this.opposite = "managedCompany";
                this.referenceType = personManagedCompanyManager;
            }
        });
        dummy1.members.add(new Attribute() {
            {
                this.list = false;
                this.name = "name";
            }
        });

        dummy2.members.add(new Attribute() {
            {
                this.list = false;
                this.name = "name";
            }
        });
        personManagedCompanyManager.members.add(new Reference() {
            {
                this.list = false;
                this.name = "person";
                this.resourceType = person;
            }
        });
        personManagedCompanyManager.members.add(new Reference() {
            {
                this.list = false;
                this.name = "company";
                this.resourceType = company;
            }
        });

        return Lists.newArrayList(person, address, addressDescription, dummy1, dummy2, company, addressTags, personManagedCompanyManager);
    }

    private static RootResourceType getPersonType() {
        RootResourceType person = new RootResourceType();
        person.name = "Person";
        return person;
    }

    private static SubResourceType getAddressType() {
        SubResourceType address = new SubResourceType();
        address.name = "Address";
        return address;
    }

    private static SubResourceType getAddressDescriptionType() {
        SubResourceType description = new SubResourceType();
        description.name = "AddressDescription";
        return description;
    }

    private static SubResourceType getAddressTagsType() {
        SubResourceType tempType = new SubResourceType() {
            {
                this.name = "AddressTags";
            }
        };
        return tempType;
    }

    private static SubResourceType getDummy1Type() {
        SubResourceType dummy = new SubResourceType();
        dummy.name = "Dummy1";
        return dummy;
    }

    private static SubResourceType getDummy2Type() {
        SubResourceType dummy = new SubResourceType();
        dummy.name = "Dummy2";
        return dummy;
    }

    private static RootResourceType getCompanyType() {
        RootResourceType company = new RootResourceType();
        company.name = "Company";
        return company;
    }

    private static ReferenceType getPersonManagedCompanyManagerType() {
        ReferenceType company = new ReferenceType();
        company.name = "PersonManagedCompanyManager";
        return company;
    }

}
