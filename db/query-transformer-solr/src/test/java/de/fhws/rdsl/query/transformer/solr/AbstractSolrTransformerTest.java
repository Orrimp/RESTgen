package de.fhws.rdsl.query.transformer.solr;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.query.transformer.api.schema.Attribute;
import de.fhws.rdsl.query.transformer.api.schema.Containment;
import de.fhws.rdsl.query.transformer.api.schema.Reference;
import de.fhws.rdsl.query.transformer.api.schema.ReferenceType;
import de.fhws.rdsl.query.transformer.api.schema.RootResourceType;
import de.fhws.rdsl.query.transformer.api.schema.SubResourceType;
import de.fhws.rdsl.query.transformer.api.schema.Type;

public class AbstractSolrTransformerTest {

	protected List<Type> createTypes() {
		return getTypes();
	}

	private static List<Type> getTypes() {
		RootResourceType person = new RootResourceType("Person");
		RootResourceType company = new RootResourceType("Company");
		RootResourceType car = new RootResourceType("Car");
		SubResourceType address = new SubResourceType("Address");
		SubResourceType addressDescription = new SubResourceType("AddressDescription");
		SubResourceType addressTags = new SubResourceType("AddressTags");
		ReferenceType companyemployeesPersoncompany = new ReferenceType("CompanyemployeesPersoncompany");
		ReferenceType companymanagerPersonmanagedCompany = new ReferenceType("CompanymanagerPersonmanagedCompany");
		ReferenceType carcompaniesCompanycars = new ReferenceType("CarcompaniesCompanycars");
		SubResourceType names = new SubResourceType("Names");
		SubResourceType dummy = new SubResourceType("Dummy");

		person.getMembers().add(new Attribute("_personId", Attribute.STRING)); // Keys
		person.getMembers().add(new Attribute("_revision", Attribute.STRING));
		person.getMembers().add(new Attribute("name", Attribute.STRING));
		person.getMembers().add(new Attribute("active", Attribute.BOOLEAN));
		person.getMembers().add(new Containment("addresses", true, address, null));
		person.getMembers().add(new Reference("company", false, companyemployeesPersoncompany, "employees"));
		person.getMembers().add(new Reference("managedCompany", false, companymanagerPersonmanagedCompany, "manager"));

		address.getMembers().add(new Attribute("_personId", Attribute.STRING)); // Keys
		address.getMembers().add(new Attribute("_addressId", Attribute.STRING)); // Keys
		address.getMembers().add(new Attribute("_revision", Attribute.STRING));
		address.getMembers().add(new Attribute("code", Attribute.INTEGER));
		address.getMembers().add(new Containment("description", false, addressDescription, null));
		address.getMembers().add(new Containment("tags", true, addressTags, null));
		address.getMembers().add(new Containment("description", false, addressDescription, null));

		names.getMembers().add(new Attribute("_personId", Attribute.STRING)); // Keys
		names.getMembers().add(new Attribute("_addressId", Attribute.STRING)); // Keys
		names.getMembers().add(new Attribute("_namesId", Attribute.STRING)); // Keys
		names.getMembers().add(new Attribute("_revision", Attribute.STRING));
		names.getMembers().add(new Attribute("val", Attribute.STRING));

		addressTags.getMembers().add(new Attribute("_personId", Attribute.STRING)); // Keys
		addressTags.getMembers().add(new Attribute("_addressId", Attribute.STRING)); // Keys
		addressTags.getMembers().add(new Attribute("_addressTagsId", Attribute.STRING)); // Keys
		addressTags.getMembers().add(new Attribute("_revision", Attribute.STRING));
		addressTags.getMembers().add(new Attribute("value", Attribute.STRING));

		addressDescription.getMembers().add(new Attribute("author", Attribute.STRING));
		addressDescription.getMembers().add(new Attribute("_revision", Attribute.STRING));
		addressDescription.getMembers().add(new Containment("names", true, names, null));
		addressDescription.getMembers().add(new Containment("dummy", false, dummy, null));

		dummy.getMembers().add(new Attribute("_revision", Attribute.STRING));
		dummy.getMembers().add(new Attribute("val", Attribute.STRING));

		company.getMembers().add(new Attribute("_companyId", Attribute.STRING)); // Keys
		company.getMembers().add(new Attribute("_revision", Attribute.STRING));
		company.getMembers().add(new Attribute("name", Attribute.STRING));
		company.getMembers().add(new Reference("manager", false, companymanagerPersonmanagedCompany, "managedCompany"));
		company.getMembers().add(new Reference("employees", true, companyemployeesPersoncompany, "company"));
		company.getMembers().add(new Reference("cars", true, carcompaniesCompanycars, "companies"));

		car.getMembers().add(new Attribute("_carId", Attribute.STRING)); // Keys
		car.getMembers().add(new Attribute("_revision", Attribute.STRING));
		car.getMembers().add(new Attribute("name", Attribute.STRING));
		car.getMembers().add(new Reference("companies", true, carcompaniesCompanycars, "cars"));

		carcompaniesCompanycars.getMembers().add(new Attribute("_companyId", Attribute.STRING)); // Keys
		carcompaniesCompanycars.getMembers().add(new Reference("_company", false, company, null));
		carcompaniesCompanycars.getMembers().add(new Attribute("_carId", Attribute.STRING)); // Keys
		carcompaniesCompanycars.getMembers().add(new Reference("_car", false, car, null));
		carcompaniesCompanycars.getMembers().add(new Attribute("_revision", Attribute.STRING));
		carcompaniesCompanycars.getMembers().add(new Attribute("weight", Attribute.INTEGER));

		companyemployeesPersoncompany.getMembers().add(new Attribute("_companyId", Attribute.STRING)); // Keys
		companyemployeesPersoncompany.getMembers().add(new Reference("_company", false, company, null));
		companyemployeesPersoncompany.getMembers().add(new Attribute("_personId", Attribute.STRING)); // Keys
		companyemployeesPersoncompany.getMembers().add(new Reference("_person", false, person, null));
		companyemployeesPersoncompany.getMembers().add(new Attribute("_revision", Attribute.STRING));

		companymanagerPersonmanagedCompany.getMembers().add(new Attribute("_companyId", Attribute.STRING)); // Keys
		companymanagerPersonmanagedCompany.getMembers().add(new Reference("_company", false, company, null));
		companymanagerPersonmanagedCompany.getMembers().add(new Attribute("_personId", Attribute.STRING)); // Keys
		companymanagerPersonmanagedCompany.getMembers().add(new Reference("_person", false, person, null));
		companymanagerPersonmanagedCompany.getMembers().add(new Attribute("_revision", Attribute.STRING));

		// personManagedCompanyManager.getMembers().add(new
		// Attribute("personId", false, Attribute.STRING));
		// personManagedCompanyManager.getMembers().add(new Reference("person",
		// false, person, null, null));
		// personManagedCompanyManager.getMembers().add(new
		// Attribute("companyId", false, Attribute.STRING));
		// personManagedCompanyManager.getMembers().add(new Reference("company",
		// false, company, null, null));

		return Lists.newArrayList(person, company, car, address, addressDescription, addressTags, companyemployeesPersoncompany,
				companymanagerPersonmanagedCompany, carcompaniesCompanycars);
	}

}
