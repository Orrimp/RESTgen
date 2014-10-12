/**
 */
package de.fhws.rdsl.generator.table.impl;

import de.fhws.rdsl.generator.table.BooleanAttribute;
import de.fhws.rdsl.generator.table.DateAttribute;
import de.fhws.rdsl.generator.table.FloatAttribute;
import de.fhws.rdsl.generator.table.IntAttribute;
import de.fhws.rdsl.generator.table.Named;
import de.fhws.rdsl.generator.table.ReferenceTable;
import de.fhws.rdsl.generator.table.RootTable;
import de.fhws.rdsl.generator.table.StringAttribute;
import de.fhws.rdsl.generator.table.SubTable;
import de.fhws.rdsl.generator.table.Table;
import de.fhws.rdsl.generator.table.TableAttribute;
import de.fhws.rdsl.generator.table.TableContainment;
import de.fhws.rdsl.generator.table.TableElement;
import de.fhws.rdsl.generator.table.TableFactory;
import de.fhws.rdsl.generator.table.TableMember;
import de.fhws.rdsl.generator.table.TablePackage;
import de.fhws.rdsl.generator.table.TableReference;

import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;

import org.eclipse.emf.ecore.impl.EPackageImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model <b>Package</b>.
 * <!-- end-user-doc -->
 * @generated
 */
public class TablePackageImpl extends EPackageImpl implements TablePackage {
    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass tableElementEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass tableEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass tableMemberEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass namedEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass tableAttributeEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass tableReferenceEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass tableContainmentEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass subTableEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass rootTableEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass referenceTableEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass floatAttributeEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass booleanAttributeEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass intAttributeEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass stringAttributeEClass = null;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private EClass dateAttributeEClass = null;

    /**
     * Creates an instance of the model <b>Package</b>, registered with
     * {@link org.eclipse.emf.ecore.EPackage.Registry EPackage.Registry} by the package
     * package URI value.
     * <p>Note: the correct way to create the package is via the static
     * factory method {@link #init init()}, which also performs
     * initialization of the package, or returns the registered package,
     * if one already exists.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see org.eclipse.emf.ecore.EPackage.Registry
     * @see de.fhws.rdsl.generator.table.TablePackage#eNS_URI
     * @see #init()
     * @generated
     */
    private TablePackageImpl() {
        super(eNS_URI, TableFactory.eINSTANCE);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private static boolean isInited = false;

    /**
     * Creates, registers, and initializes the <b>Package</b> for this model, and for any others upon which it depends.
     * 
     * <p>This method is used to initialize {@link TablePackage#eINSTANCE} when that field is accessed.
     * Clients should not invoke it directly. Instead, they should simply access that field to obtain the package.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #eNS_URI
     * @see #createPackageContents()
     * @see #initializePackageContents()
     * @generated
     */
    public static TablePackage init() {
        if (isInited) return (TablePackage)EPackage.Registry.INSTANCE.getEPackage(TablePackage.eNS_URI);

        // Obtain or create and register package
        TablePackageImpl theTablePackage = (TablePackageImpl)(EPackage.Registry.INSTANCE.get(eNS_URI) instanceof TablePackageImpl ? EPackage.Registry.INSTANCE.get(eNS_URI) : new TablePackageImpl());

        isInited = true;

        // Create package meta-data objects
        theTablePackage.createPackageContents();

        // Initialize created meta-data
        theTablePackage.initializePackageContents();

        // Mark meta-data to indicate it can't be changed
        theTablePackage.freeze();

  
        // Update the registry and return the package
        EPackage.Registry.INSTANCE.put(TablePackage.eNS_URI, theTablePackage);
        return theTablePackage;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getTableElement() {
        return tableElementEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getTable() {
        return tableEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EReference getTable_Members() {
        return (EReference)tableEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getTable_Identifiers() {
        return (EAttribute)tableEClass.getEStructuralFeatures().get(1);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getTableMember() {
        return tableMemberEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getNamed() {
        return namedEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getNamed_Name() {
        return (EAttribute)namedEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getTableAttribute() {
        return tableAttributeEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getTableAttribute_Flags() {
        return (EAttribute)tableAttributeEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getTableAttribute_Queryable() {
        return (EAttribute)tableAttributeEClass.getEStructuralFeatures().get(1);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getTableReference() {
        return tableReferenceEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EReference getTableReference_ReferenceTable() {
        return (EReference)tableReferenceEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getTableReference_List() {
        return (EAttribute)tableReferenceEClass.getEStructuralFeatures().get(1);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getTableContainment() {
        return tableContainmentEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getTableContainment_List() {
        return (EAttribute)tableContainmentEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EReference getTableContainment_SubTable() {
        return (EReference)tableContainmentEClass.getEStructuralFeatures().get(1);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getSubTable() {
        return subTableEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getRootTable() {
        return rootTableEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getReferenceTable() {
        return referenceTableEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EReference getReferenceTable_Left() {
        return (EReference)referenceTableEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EReference getReferenceTable_Right() {
        return (EReference)referenceTableEClass.getEStructuralFeatures().get(1);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getFloatAttribute() {
        return floatAttributeEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getFloatAttribute_Start() {
        return (EAttribute)floatAttributeEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getFloatAttribute_Stop() {
        return (EAttribute)floatAttributeEClass.getEStructuralFeatures().get(1);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getBooleanAttribute() {
        return booleanAttributeEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getIntAttribute() {
        return intAttributeEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getIntAttribute_Start() {
        return (EAttribute)intAttributeEClass.getEStructuralFeatures().get(0);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EAttribute getIntAttribute_Stop() {
        return (EAttribute)intAttributeEClass.getEStructuralFeatures().get(1);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getStringAttribute() {
        return stringAttributeEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EClass getDateAttribute() {
        return dateAttributeEClass;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableFactory getTableFactory() {
        return (TableFactory)getEFactoryInstance();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private boolean isCreated = false;

    /**
     * Creates the meta-model objects for the package.  This method is
     * guarded to have no affect on any invocation but its first.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void createPackageContents() {
        if (isCreated) return;
        isCreated = true;

        // Create classes and their features
        tableElementEClass = createEClass(TABLE_ELEMENT);

        tableEClass = createEClass(TABLE);
        createEReference(tableEClass, TABLE__MEMBERS);
        createEAttribute(tableEClass, TABLE__IDENTIFIERS);

        tableMemberEClass = createEClass(TABLE_MEMBER);

        namedEClass = createEClass(NAMED);
        createEAttribute(namedEClass, NAMED__NAME);

        tableAttributeEClass = createEClass(TABLE_ATTRIBUTE);
        createEAttribute(tableAttributeEClass, TABLE_ATTRIBUTE__FLAGS);
        createEAttribute(tableAttributeEClass, TABLE_ATTRIBUTE__QUERYABLE);

        tableReferenceEClass = createEClass(TABLE_REFERENCE);
        createEReference(tableReferenceEClass, TABLE_REFERENCE__REFERENCE_TABLE);
        createEAttribute(tableReferenceEClass, TABLE_REFERENCE__LIST);

        tableContainmentEClass = createEClass(TABLE_CONTAINMENT);
        createEAttribute(tableContainmentEClass, TABLE_CONTAINMENT__LIST);
        createEReference(tableContainmentEClass, TABLE_CONTAINMENT__SUB_TABLE);

        subTableEClass = createEClass(SUB_TABLE);

        rootTableEClass = createEClass(ROOT_TABLE);

        referenceTableEClass = createEClass(REFERENCE_TABLE);
        createEReference(referenceTableEClass, REFERENCE_TABLE__LEFT);
        createEReference(referenceTableEClass, REFERENCE_TABLE__RIGHT);

        floatAttributeEClass = createEClass(FLOAT_ATTRIBUTE);
        createEAttribute(floatAttributeEClass, FLOAT_ATTRIBUTE__START);
        createEAttribute(floatAttributeEClass, FLOAT_ATTRIBUTE__STOP);

        booleanAttributeEClass = createEClass(BOOLEAN_ATTRIBUTE);

        intAttributeEClass = createEClass(INT_ATTRIBUTE);
        createEAttribute(intAttributeEClass, INT_ATTRIBUTE__START);
        createEAttribute(intAttributeEClass, INT_ATTRIBUTE__STOP);

        stringAttributeEClass = createEClass(STRING_ATTRIBUTE);

        dateAttributeEClass = createEClass(DATE_ATTRIBUTE);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    private boolean isInitialized = false;

    /**
     * Complete the initialization of the package and its meta-model.  This
     * method is guarded to have no affect on any invocation but its first.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void initializePackageContents() {
        if (isInitialized) return;
        isInitialized = true;

        // Initialize package
        setName(eNAME);
        setNsPrefix(eNS_PREFIX);
        setNsURI(eNS_URI);

        // Create type parameters

        // Set bounds for type parameters

        // Add supertypes to classes
        tableEClass.getESuperTypes().add(this.getTableElement());
        tableEClass.getESuperTypes().add(this.getNamed());
        tableMemberEClass.getESuperTypes().add(this.getTableElement());
        tableMemberEClass.getESuperTypes().add(this.getNamed());
        tableAttributeEClass.getESuperTypes().add(this.getTableMember());
        tableReferenceEClass.getESuperTypes().add(this.getTableMember());
        tableContainmentEClass.getESuperTypes().add(this.getTableMember());
        subTableEClass.getESuperTypes().add(this.getTable());
        rootTableEClass.getESuperTypes().add(this.getTable());
        referenceTableEClass.getESuperTypes().add(this.getTable());
        floatAttributeEClass.getESuperTypes().add(this.getTableAttribute());
        booleanAttributeEClass.getESuperTypes().add(this.getTableAttribute());
        intAttributeEClass.getESuperTypes().add(this.getTableAttribute());
        stringAttributeEClass.getESuperTypes().add(this.getTableAttribute());
        dateAttributeEClass.getESuperTypes().add(this.getTableAttribute());

        // Initialize classes, features, and operations; add parameters
        initEClass(tableElementEClass, TableElement.class, "TableElement", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

        initEClass(tableEClass, Table.class, "Table", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEReference(getTable_Members(), this.getTableMember(), null, "members", null, 0, -1, Table.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_COMPOSITE, !IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
        initEAttribute(getTable_Identifiers(), ecorePackage.getEString(), "identifiers", null, 0, -1, Table.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(tableMemberEClass, TableMember.class, "TableMember", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

        initEClass(namedEClass, Named.class, "Named", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEAttribute(getNamed_Name(), ecorePackage.getEString(), "name", null, 0, 1, Named.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(tableAttributeEClass, TableAttribute.class, "TableAttribute", IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEAttribute(getTableAttribute_Flags(), ecorePackage.getEString(), "flags", null, 0, -1, TableAttribute.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
        initEAttribute(getTableAttribute_Queryable(), ecorePackage.getEBoolean(), "queryable", null, 0, 1, TableAttribute.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(tableReferenceEClass, TableReference.class, "TableReference", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEReference(getTableReference_ReferenceTable(), this.getReferenceTable(), null, "referenceTable", null, 0, 1, TableReference.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
        initEAttribute(getTableReference_List(), ecorePackage.getEBoolean(), "list", null, 0, 1, TableReference.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(tableContainmentEClass, TableContainment.class, "TableContainment", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEAttribute(getTableContainment_List(), ecorePackage.getEBoolean(), "list", null, 0, 1, TableContainment.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
        initEReference(getTableContainment_SubTable(), this.getSubTable(), null, "subTable", null, 0, 1, TableContainment.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_COMPOSITE, !IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(subTableEClass, SubTable.class, "SubTable", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

        initEClass(rootTableEClass, RootTable.class, "RootTable", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

        initEClass(referenceTableEClass, ReferenceTable.class, "ReferenceTable", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEReference(getReferenceTable_Left(), this.getTableReference(), null, "left", null, 0, 1, ReferenceTable.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
        initEReference(getReferenceTable_Right(), this.getTableReference(), null, "right", null, 0, 1, ReferenceTable.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(floatAttributeEClass, FloatAttribute.class, "FloatAttribute", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEAttribute(getFloatAttribute_Start(), ecorePackage.getEFloat(), "start", null, 0, 1, FloatAttribute.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
        initEAttribute(getFloatAttribute_Stop(), ecorePackage.getEFloat(), "stop", null, 0, 1, FloatAttribute.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(booleanAttributeEClass, BooleanAttribute.class, "BooleanAttribute", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

        initEClass(intAttributeEClass, IntAttribute.class, "IntAttribute", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
        initEAttribute(getIntAttribute_Start(), ecorePackage.getEInt(), "start", null, 0, 1, IntAttribute.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
        initEAttribute(getIntAttribute_Stop(), ecorePackage.getEInt(), "stop", null, 0, 1, IntAttribute.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

        initEClass(stringAttributeEClass, StringAttribute.class, "StringAttribute", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

        initEClass(dateAttributeEClass, DateAttribute.class, "DateAttribute", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

        // Create resource
        createResource(eNS_URI);
    }

} //TablePackageImpl
