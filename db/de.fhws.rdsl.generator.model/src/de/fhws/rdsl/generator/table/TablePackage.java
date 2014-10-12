/**
 */
package de.fhws.rdsl.generator.table;

import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;

/**
 * <!-- begin-user-doc -->
 * The <b>Package</b> for the model.
 * It contains accessors for the meta objects to represent
 * <ul>
 *   <li>each class,</li>
 *   <li>each feature of each class,</li>
 *   <li>each operation of each class,</li>
 *   <li>each enum,</li>
 *   <li>and each data type</li>
 * </ul>
 * <!-- end-user-doc -->
 * @see de.fhws.rdsl.generator.table.TableFactory
 * @model kind="package"
 * @generated
 */
public interface TablePackage extends EPackage {
    /**
     * The package name.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    String eNAME = "table";

    /**
     * The package namespace URI.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    String eNS_URI = "http://www.fhws.de/rdsl/model/table";

    /**
     * The package namespace name.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    String eNS_PREFIX = "table";

    /**
     * The singleton instance of the package.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    TablePackage eINSTANCE = de.fhws.rdsl.generator.table.impl.TablePackageImpl.init();

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.TableElementImpl <em>Element</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.TableElementImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableElement()
     * @generated
     */
    int TABLE_ELEMENT = 0;

    /**
     * The number of structural features of the '<em>Element</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_ELEMENT_FEATURE_COUNT = 0;

    /**
     * The number of operations of the '<em>Element</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_ELEMENT_OPERATION_COUNT = 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.TableImpl <em>Table</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.TableImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTable()
     * @generated
     */
    int TABLE = 1;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE__NAME = TABLE_ELEMENT_FEATURE_COUNT + 0;

    /**
     * The feature id for the '<em><b>Members</b></em>' containment reference list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE__MEMBERS = TABLE_ELEMENT_FEATURE_COUNT + 1;

    /**
     * The feature id for the '<em><b>Identifiers</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE__IDENTIFIERS = TABLE_ELEMENT_FEATURE_COUNT + 2;

    /**
     * The number of structural features of the '<em>Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_FEATURE_COUNT = TABLE_ELEMENT_FEATURE_COUNT + 3;

    /**
     * The number of operations of the '<em>Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_OPERATION_COUNT = TABLE_ELEMENT_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.TableMemberImpl <em>Member</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.TableMemberImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableMember()
     * @generated
     */
    int TABLE_MEMBER = 2;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_MEMBER__NAME = TABLE_ELEMENT_FEATURE_COUNT + 0;

    /**
     * The number of structural features of the '<em>Member</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_MEMBER_FEATURE_COUNT = TABLE_ELEMENT_FEATURE_COUNT + 1;

    /**
     * The number of operations of the '<em>Member</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_MEMBER_OPERATION_COUNT = TABLE_ELEMENT_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.NamedImpl <em>Named</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.NamedImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getNamed()
     * @generated
     */
    int NAMED = 3;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int NAMED__NAME = 0;

    /**
     * The number of structural features of the '<em>Named</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int NAMED_FEATURE_COUNT = 1;

    /**
     * The number of operations of the '<em>Named</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int NAMED_OPERATION_COUNT = 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.TableAttributeImpl <em>Attribute</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.TableAttributeImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableAttribute()
     * @generated
     */
    int TABLE_ATTRIBUTE = 4;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_ATTRIBUTE__NAME = TABLE_MEMBER__NAME;

    /**
     * The feature id for the '<em><b>Flags</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_ATTRIBUTE__FLAGS = TABLE_MEMBER_FEATURE_COUNT + 0;

    /**
     * The feature id for the '<em><b>Queryable</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_ATTRIBUTE__QUERYABLE = TABLE_MEMBER_FEATURE_COUNT + 1;

    /**
     * The number of structural features of the '<em>Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_ATTRIBUTE_FEATURE_COUNT = TABLE_MEMBER_FEATURE_COUNT + 2;

    /**
     * The number of operations of the '<em>Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_ATTRIBUTE_OPERATION_COUNT = TABLE_MEMBER_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.TableReferenceImpl <em>Reference</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.TableReferenceImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableReference()
     * @generated
     */
    int TABLE_REFERENCE = 5;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_REFERENCE__NAME = TABLE_MEMBER__NAME;

    /**
     * The feature id for the '<em><b>Reference Table</b></em>' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_REFERENCE__REFERENCE_TABLE = TABLE_MEMBER_FEATURE_COUNT + 0;

    /**
     * The feature id for the '<em><b>List</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_REFERENCE__LIST = TABLE_MEMBER_FEATURE_COUNT + 1;

    /**
     * The number of structural features of the '<em>Reference</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_REFERENCE_FEATURE_COUNT = TABLE_MEMBER_FEATURE_COUNT + 2;

    /**
     * The number of operations of the '<em>Reference</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_REFERENCE_OPERATION_COUNT = TABLE_MEMBER_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.TableContainmentImpl <em>Containment</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.TableContainmentImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableContainment()
     * @generated
     */
    int TABLE_CONTAINMENT = 6;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_CONTAINMENT__NAME = TABLE_MEMBER__NAME;

    /**
     * The feature id for the '<em><b>List</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_CONTAINMENT__LIST = TABLE_MEMBER_FEATURE_COUNT + 0;

    /**
     * The feature id for the '<em><b>Sub Table</b></em>' containment reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_CONTAINMENT__SUB_TABLE = TABLE_MEMBER_FEATURE_COUNT + 1;

    /**
     * The number of structural features of the '<em>Containment</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_CONTAINMENT_FEATURE_COUNT = TABLE_MEMBER_FEATURE_COUNT + 2;

    /**
     * The number of operations of the '<em>Containment</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int TABLE_CONTAINMENT_OPERATION_COUNT = TABLE_MEMBER_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.SubTableImpl <em>Sub Table</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.SubTableImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getSubTable()
     * @generated
     */
    int SUB_TABLE = 7;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int SUB_TABLE__NAME = TABLE__NAME;

    /**
     * The feature id for the '<em><b>Members</b></em>' containment reference list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int SUB_TABLE__MEMBERS = TABLE__MEMBERS;

    /**
     * The feature id for the '<em><b>Identifiers</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int SUB_TABLE__IDENTIFIERS = TABLE__IDENTIFIERS;

    /**
     * The number of structural features of the '<em>Sub Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int SUB_TABLE_FEATURE_COUNT = TABLE_FEATURE_COUNT + 0;

    /**
     * The number of operations of the '<em>Sub Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int SUB_TABLE_OPERATION_COUNT = TABLE_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.RootTableImpl <em>Root Table</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.RootTableImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getRootTable()
     * @generated
     */
    int ROOT_TABLE = 8;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int ROOT_TABLE__NAME = TABLE__NAME;

    /**
     * The feature id for the '<em><b>Members</b></em>' containment reference list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int ROOT_TABLE__MEMBERS = TABLE__MEMBERS;

    /**
     * The feature id for the '<em><b>Identifiers</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int ROOT_TABLE__IDENTIFIERS = TABLE__IDENTIFIERS;

    /**
     * The number of structural features of the '<em>Root Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int ROOT_TABLE_FEATURE_COUNT = TABLE_FEATURE_COUNT + 0;

    /**
     * The number of operations of the '<em>Root Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int ROOT_TABLE_OPERATION_COUNT = TABLE_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.ReferenceTableImpl <em>Reference Table</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.ReferenceTableImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getReferenceTable()
     * @generated
     */
    int REFERENCE_TABLE = 9;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int REFERENCE_TABLE__NAME = TABLE__NAME;

    /**
     * The feature id for the '<em><b>Members</b></em>' containment reference list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int REFERENCE_TABLE__MEMBERS = TABLE__MEMBERS;

    /**
     * The feature id for the '<em><b>Identifiers</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int REFERENCE_TABLE__IDENTIFIERS = TABLE__IDENTIFIERS;

    /**
     * The feature id for the '<em><b>Left</b></em>' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int REFERENCE_TABLE__LEFT = TABLE_FEATURE_COUNT + 0;

    /**
     * The feature id for the '<em><b>Right</b></em>' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int REFERENCE_TABLE__RIGHT = TABLE_FEATURE_COUNT + 1;

    /**
     * The number of structural features of the '<em>Reference Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int REFERENCE_TABLE_FEATURE_COUNT = TABLE_FEATURE_COUNT + 2;

    /**
     * The number of operations of the '<em>Reference Table</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int REFERENCE_TABLE_OPERATION_COUNT = TABLE_OPERATION_COUNT + 0;


    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.FloatAttributeImpl <em>Float Attribute</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.FloatAttributeImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getFloatAttribute()
     * @generated
     */
    int FLOAT_ATTRIBUTE = 10;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int FLOAT_ATTRIBUTE__NAME = TABLE_ATTRIBUTE__NAME;

    /**
     * The feature id for the '<em><b>Flags</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int FLOAT_ATTRIBUTE__FLAGS = TABLE_ATTRIBUTE__FLAGS;

    /**
     * The feature id for the '<em><b>Queryable</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int FLOAT_ATTRIBUTE__QUERYABLE = TABLE_ATTRIBUTE__QUERYABLE;

    /**
     * The feature id for the '<em><b>Start</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int FLOAT_ATTRIBUTE__START = TABLE_ATTRIBUTE_FEATURE_COUNT + 0;

    /**
     * The feature id for the '<em><b>Stop</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int FLOAT_ATTRIBUTE__STOP = TABLE_ATTRIBUTE_FEATURE_COUNT + 1;

    /**
     * The number of structural features of the '<em>Float Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int FLOAT_ATTRIBUTE_FEATURE_COUNT = TABLE_ATTRIBUTE_FEATURE_COUNT + 2;

    /**
     * The number of operations of the '<em>Float Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int FLOAT_ATTRIBUTE_OPERATION_COUNT = TABLE_ATTRIBUTE_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.BooleanAttributeImpl <em>Boolean Attribute</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.BooleanAttributeImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getBooleanAttribute()
     * @generated
     */
    int BOOLEAN_ATTRIBUTE = 11;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int BOOLEAN_ATTRIBUTE__NAME = TABLE_ATTRIBUTE__NAME;

    /**
     * The feature id for the '<em><b>Flags</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int BOOLEAN_ATTRIBUTE__FLAGS = TABLE_ATTRIBUTE__FLAGS;

    /**
     * The feature id for the '<em><b>Queryable</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int BOOLEAN_ATTRIBUTE__QUERYABLE = TABLE_ATTRIBUTE__QUERYABLE;

    /**
     * The number of structural features of the '<em>Boolean Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int BOOLEAN_ATTRIBUTE_FEATURE_COUNT = TABLE_ATTRIBUTE_FEATURE_COUNT + 0;

    /**
     * The number of operations of the '<em>Boolean Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int BOOLEAN_ATTRIBUTE_OPERATION_COUNT = TABLE_ATTRIBUTE_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.IntAttributeImpl <em>Int Attribute</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.IntAttributeImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getIntAttribute()
     * @generated
     */
    int INT_ATTRIBUTE = 12;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int INT_ATTRIBUTE__NAME = TABLE_ATTRIBUTE__NAME;

    /**
     * The feature id for the '<em><b>Flags</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int INT_ATTRIBUTE__FLAGS = TABLE_ATTRIBUTE__FLAGS;

    /**
     * The feature id for the '<em><b>Queryable</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int INT_ATTRIBUTE__QUERYABLE = TABLE_ATTRIBUTE__QUERYABLE;

    /**
     * The feature id for the '<em><b>Start</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int INT_ATTRIBUTE__START = TABLE_ATTRIBUTE_FEATURE_COUNT + 0;

    /**
     * The feature id for the '<em><b>Stop</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int INT_ATTRIBUTE__STOP = TABLE_ATTRIBUTE_FEATURE_COUNT + 1;

    /**
     * The number of structural features of the '<em>Int Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int INT_ATTRIBUTE_FEATURE_COUNT = TABLE_ATTRIBUTE_FEATURE_COUNT + 2;

    /**
     * The number of operations of the '<em>Int Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int INT_ATTRIBUTE_OPERATION_COUNT = TABLE_ATTRIBUTE_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.StringAttributeImpl <em>String Attribute</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.StringAttributeImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getStringAttribute()
     * @generated
     */
    int STRING_ATTRIBUTE = 13;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int STRING_ATTRIBUTE__NAME = TABLE_ATTRIBUTE__NAME;

    /**
     * The feature id for the '<em><b>Flags</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int STRING_ATTRIBUTE__FLAGS = TABLE_ATTRIBUTE__FLAGS;

    /**
     * The feature id for the '<em><b>Queryable</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int STRING_ATTRIBUTE__QUERYABLE = TABLE_ATTRIBUTE__QUERYABLE;

    /**
     * The number of structural features of the '<em>String Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int STRING_ATTRIBUTE_FEATURE_COUNT = TABLE_ATTRIBUTE_FEATURE_COUNT + 0;

    /**
     * The number of operations of the '<em>String Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int STRING_ATTRIBUTE_OPERATION_COUNT = TABLE_ATTRIBUTE_OPERATION_COUNT + 0;

    /**
     * The meta object id for the '{@link de.fhws.rdsl.generator.table.impl.DateAttributeImpl <em>Date Attribute</em>}' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see de.fhws.rdsl.generator.table.impl.DateAttributeImpl
     * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getDateAttribute()
     * @generated
     */
    int DATE_ATTRIBUTE = 14;

    /**
     * The feature id for the '<em><b>Name</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int DATE_ATTRIBUTE__NAME = TABLE_ATTRIBUTE__NAME;

    /**
     * The feature id for the '<em><b>Flags</b></em>' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int DATE_ATTRIBUTE__FLAGS = TABLE_ATTRIBUTE__FLAGS;

    /**
     * The feature id for the '<em><b>Queryable</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int DATE_ATTRIBUTE__QUERYABLE = TABLE_ATTRIBUTE__QUERYABLE;

    /**
     * The number of structural features of the '<em>Date Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int DATE_ATTRIBUTE_FEATURE_COUNT = TABLE_ATTRIBUTE_FEATURE_COUNT + 0;

    /**
     * The number of operations of the '<em>Date Attribute</em>' class.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    int DATE_ATTRIBUTE_OPERATION_COUNT = TABLE_ATTRIBUTE_OPERATION_COUNT + 0;


    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.TableElement <em>Element</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Element</em>'.
     * @see de.fhws.rdsl.generator.table.TableElement
     * @generated
     */
    EClass getTableElement();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.Table <em>Table</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Table</em>'.
     * @see de.fhws.rdsl.generator.table.Table
     * @generated
     */
    EClass getTable();

    /**
     * Returns the meta object for the containment reference list '{@link de.fhws.rdsl.generator.table.Table#getMembers <em>Members</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the containment reference list '<em>Members</em>'.
     * @see de.fhws.rdsl.generator.table.Table#getMembers()
     * @see #getTable()
     * @generated
     */
    EReference getTable_Members();

    /**
     * Returns the meta object for the attribute list '{@link de.fhws.rdsl.generator.table.Table#getIdentifiers <em>Identifiers</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute list '<em>Identifiers</em>'.
     * @see de.fhws.rdsl.generator.table.Table#getIdentifiers()
     * @see #getTable()
     * @generated
     */
    EAttribute getTable_Identifiers();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.TableMember <em>Member</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Member</em>'.
     * @see de.fhws.rdsl.generator.table.TableMember
     * @generated
     */
    EClass getTableMember();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.Named <em>Named</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Named</em>'.
     * @see de.fhws.rdsl.generator.table.Named
     * @generated
     */
    EClass getNamed();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.Named#getName <em>Name</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>Name</em>'.
     * @see de.fhws.rdsl.generator.table.Named#getName()
     * @see #getNamed()
     * @generated
     */
    EAttribute getNamed_Name();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.TableAttribute <em>Attribute</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Attribute</em>'.
     * @see de.fhws.rdsl.generator.table.TableAttribute
     * @generated
     */
    EClass getTableAttribute();

    /**
     * Returns the meta object for the attribute list '{@link de.fhws.rdsl.generator.table.TableAttribute#getFlags <em>Flags</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute list '<em>Flags</em>'.
     * @see de.fhws.rdsl.generator.table.TableAttribute#getFlags()
     * @see #getTableAttribute()
     * @generated
     */
    EAttribute getTableAttribute_Flags();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.TableAttribute#isQueryable <em>Queryable</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>Queryable</em>'.
     * @see de.fhws.rdsl.generator.table.TableAttribute#isQueryable()
     * @see #getTableAttribute()
     * @generated
     */
    EAttribute getTableAttribute_Queryable();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.TableReference <em>Reference</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Reference</em>'.
     * @see de.fhws.rdsl.generator.table.TableReference
     * @generated
     */
    EClass getTableReference();

    /**
     * Returns the meta object for the reference '{@link de.fhws.rdsl.generator.table.TableReference#getReferenceTable <em>Reference Table</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the reference '<em>Reference Table</em>'.
     * @see de.fhws.rdsl.generator.table.TableReference#getReferenceTable()
     * @see #getTableReference()
     * @generated
     */
    EReference getTableReference_ReferenceTable();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.TableReference#isList <em>List</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>List</em>'.
     * @see de.fhws.rdsl.generator.table.TableReference#isList()
     * @see #getTableReference()
     * @generated
     */
    EAttribute getTableReference_List();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.TableContainment <em>Containment</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Containment</em>'.
     * @see de.fhws.rdsl.generator.table.TableContainment
     * @generated
     */
    EClass getTableContainment();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.TableContainment#isList <em>List</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>List</em>'.
     * @see de.fhws.rdsl.generator.table.TableContainment#isList()
     * @see #getTableContainment()
     * @generated
     */
    EAttribute getTableContainment_List();

    /**
     * Returns the meta object for the containment reference '{@link de.fhws.rdsl.generator.table.TableContainment#getSubTable <em>Sub Table</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the containment reference '<em>Sub Table</em>'.
     * @see de.fhws.rdsl.generator.table.TableContainment#getSubTable()
     * @see #getTableContainment()
     * @generated
     */
    EReference getTableContainment_SubTable();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.SubTable <em>Sub Table</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Sub Table</em>'.
     * @see de.fhws.rdsl.generator.table.SubTable
     * @generated
     */
    EClass getSubTable();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.RootTable <em>Root Table</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Root Table</em>'.
     * @see de.fhws.rdsl.generator.table.RootTable
     * @generated
     */
    EClass getRootTable();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.ReferenceTable <em>Reference Table</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Reference Table</em>'.
     * @see de.fhws.rdsl.generator.table.ReferenceTable
     * @generated
     */
    EClass getReferenceTable();

    /**
     * Returns the meta object for the reference '{@link de.fhws.rdsl.generator.table.ReferenceTable#getLeft <em>Left</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the reference '<em>Left</em>'.
     * @see de.fhws.rdsl.generator.table.ReferenceTable#getLeft()
     * @see #getReferenceTable()
     * @generated
     */
    EReference getReferenceTable_Left();

    /**
     * Returns the meta object for the reference '{@link de.fhws.rdsl.generator.table.ReferenceTable#getRight <em>Right</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the reference '<em>Right</em>'.
     * @see de.fhws.rdsl.generator.table.ReferenceTable#getRight()
     * @see #getReferenceTable()
     * @generated
     */
    EReference getReferenceTable_Right();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.FloatAttribute <em>Float Attribute</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Float Attribute</em>'.
     * @see de.fhws.rdsl.generator.table.FloatAttribute
     * @generated
     */
    EClass getFloatAttribute();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.FloatAttribute#getStart <em>Start</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>Start</em>'.
     * @see de.fhws.rdsl.generator.table.FloatAttribute#getStart()
     * @see #getFloatAttribute()
     * @generated
     */
    EAttribute getFloatAttribute_Start();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.FloatAttribute#getStop <em>Stop</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>Stop</em>'.
     * @see de.fhws.rdsl.generator.table.FloatAttribute#getStop()
     * @see #getFloatAttribute()
     * @generated
     */
    EAttribute getFloatAttribute_Stop();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.BooleanAttribute <em>Boolean Attribute</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Boolean Attribute</em>'.
     * @see de.fhws.rdsl.generator.table.BooleanAttribute
     * @generated
     */
    EClass getBooleanAttribute();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.IntAttribute <em>Int Attribute</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Int Attribute</em>'.
     * @see de.fhws.rdsl.generator.table.IntAttribute
     * @generated
     */
    EClass getIntAttribute();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.IntAttribute#getStart <em>Start</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>Start</em>'.
     * @see de.fhws.rdsl.generator.table.IntAttribute#getStart()
     * @see #getIntAttribute()
     * @generated
     */
    EAttribute getIntAttribute_Start();

    /**
     * Returns the meta object for the attribute '{@link de.fhws.rdsl.generator.table.IntAttribute#getStop <em>Stop</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for the attribute '<em>Stop</em>'.
     * @see de.fhws.rdsl.generator.table.IntAttribute#getStop()
     * @see #getIntAttribute()
     * @generated
     */
    EAttribute getIntAttribute_Stop();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.StringAttribute <em>String Attribute</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>String Attribute</em>'.
     * @see de.fhws.rdsl.generator.table.StringAttribute
     * @generated
     */
    EClass getStringAttribute();

    /**
     * Returns the meta object for class '{@link de.fhws.rdsl.generator.table.DateAttribute <em>Date Attribute</em>}'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the meta object for class '<em>Date Attribute</em>'.
     * @see de.fhws.rdsl.generator.table.DateAttribute
     * @generated
     */
    EClass getDateAttribute();

    /**
     * Returns the factory that creates the instances of the model.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the factory that creates the instances of the model.
     * @generated
     */
    TableFactory getTableFactory();

    /**
     * <!-- begin-user-doc -->
     * Defines literals for the meta objects that represent
     * <ul>
     *   <li>each class,</li>
     *   <li>each feature of each class,</li>
     *   <li>each operation of each class,</li>
     *   <li>each enum,</li>
     *   <li>and each data type</li>
     * </ul>
     * <!-- end-user-doc -->
     * @generated
     */
    interface Literals {
        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.TableElementImpl <em>Element</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.TableElementImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableElement()
         * @generated
         */
        EClass TABLE_ELEMENT = eINSTANCE.getTableElement();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.TableImpl <em>Table</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.TableImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTable()
         * @generated
         */
        EClass TABLE = eINSTANCE.getTable();

        /**
         * The meta object literal for the '<em><b>Members</b></em>' containment reference list feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EReference TABLE__MEMBERS = eINSTANCE.getTable_Members();

        /**
         * The meta object literal for the '<em><b>Identifiers</b></em>' attribute list feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute TABLE__IDENTIFIERS = eINSTANCE.getTable_Identifiers();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.TableMemberImpl <em>Member</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.TableMemberImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableMember()
         * @generated
         */
        EClass TABLE_MEMBER = eINSTANCE.getTableMember();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.NamedImpl <em>Named</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.NamedImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getNamed()
         * @generated
         */
        EClass NAMED = eINSTANCE.getNamed();

        /**
         * The meta object literal for the '<em><b>Name</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute NAMED__NAME = eINSTANCE.getNamed_Name();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.TableAttributeImpl <em>Attribute</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.TableAttributeImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableAttribute()
         * @generated
         */
        EClass TABLE_ATTRIBUTE = eINSTANCE.getTableAttribute();

        /**
         * The meta object literal for the '<em><b>Flags</b></em>' attribute list feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute TABLE_ATTRIBUTE__FLAGS = eINSTANCE.getTableAttribute_Flags();

        /**
         * The meta object literal for the '<em><b>Queryable</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute TABLE_ATTRIBUTE__QUERYABLE = eINSTANCE.getTableAttribute_Queryable();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.TableReferenceImpl <em>Reference</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.TableReferenceImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableReference()
         * @generated
         */
        EClass TABLE_REFERENCE = eINSTANCE.getTableReference();

        /**
         * The meta object literal for the '<em><b>Reference Table</b></em>' reference feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EReference TABLE_REFERENCE__REFERENCE_TABLE = eINSTANCE.getTableReference_ReferenceTable();

        /**
         * The meta object literal for the '<em><b>List</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute TABLE_REFERENCE__LIST = eINSTANCE.getTableReference_List();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.TableContainmentImpl <em>Containment</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.TableContainmentImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getTableContainment()
         * @generated
         */
        EClass TABLE_CONTAINMENT = eINSTANCE.getTableContainment();

        /**
         * The meta object literal for the '<em><b>List</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute TABLE_CONTAINMENT__LIST = eINSTANCE.getTableContainment_List();

        /**
         * The meta object literal for the '<em><b>Sub Table</b></em>' containment reference feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EReference TABLE_CONTAINMENT__SUB_TABLE = eINSTANCE.getTableContainment_SubTable();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.SubTableImpl <em>Sub Table</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.SubTableImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getSubTable()
         * @generated
         */
        EClass SUB_TABLE = eINSTANCE.getSubTable();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.RootTableImpl <em>Root Table</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.RootTableImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getRootTable()
         * @generated
         */
        EClass ROOT_TABLE = eINSTANCE.getRootTable();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.ReferenceTableImpl <em>Reference Table</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.ReferenceTableImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getReferenceTable()
         * @generated
         */
        EClass REFERENCE_TABLE = eINSTANCE.getReferenceTable();

        /**
         * The meta object literal for the '<em><b>Left</b></em>' reference feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EReference REFERENCE_TABLE__LEFT = eINSTANCE.getReferenceTable_Left();

        /**
         * The meta object literal for the '<em><b>Right</b></em>' reference feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EReference REFERENCE_TABLE__RIGHT = eINSTANCE.getReferenceTable_Right();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.FloatAttributeImpl <em>Float Attribute</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.FloatAttributeImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getFloatAttribute()
         * @generated
         */
        EClass FLOAT_ATTRIBUTE = eINSTANCE.getFloatAttribute();

        /**
         * The meta object literal for the '<em><b>Start</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute FLOAT_ATTRIBUTE__START = eINSTANCE.getFloatAttribute_Start();

        /**
         * The meta object literal for the '<em><b>Stop</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute FLOAT_ATTRIBUTE__STOP = eINSTANCE.getFloatAttribute_Stop();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.BooleanAttributeImpl <em>Boolean Attribute</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.BooleanAttributeImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getBooleanAttribute()
         * @generated
         */
        EClass BOOLEAN_ATTRIBUTE = eINSTANCE.getBooleanAttribute();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.IntAttributeImpl <em>Int Attribute</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.IntAttributeImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getIntAttribute()
         * @generated
         */
        EClass INT_ATTRIBUTE = eINSTANCE.getIntAttribute();

        /**
         * The meta object literal for the '<em><b>Start</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute INT_ATTRIBUTE__START = eINSTANCE.getIntAttribute_Start();

        /**
         * The meta object literal for the '<em><b>Stop</b></em>' attribute feature.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @generated
         */
        EAttribute INT_ATTRIBUTE__STOP = eINSTANCE.getIntAttribute_Stop();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.StringAttributeImpl <em>String Attribute</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.StringAttributeImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getStringAttribute()
         * @generated
         */
        EClass STRING_ATTRIBUTE = eINSTANCE.getStringAttribute();

        /**
         * The meta object literal for the '{@link de.fhws.rdsl.generator.table.impl.DateAttributeImpl <em>Date Attribute</em>}' class.
         * <!-- begin-user-doc -->
         * <!-- end-user-doc -->
         * @see de.fhws.rdsl.generator.table.impl.DateAttributeImpl
         * @see de.fhws.rdsl.generator.table.impl.TablePackageImpl#getDateAttribute()
         * @generated
         */
        EClass DATE_ATTRIBUTE = eINSTANCE.getDateAttribute();

    }

} //TablePackage
