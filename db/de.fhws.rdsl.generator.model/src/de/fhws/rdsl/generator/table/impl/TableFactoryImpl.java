/**
 */
package de.fhws.rdsl.generator.table.impl;

import de.fhws.rdsl.generator.table.*;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;

import org.eclipse.emf.ecore.impl.EFactoryImpl;

import org.eclipse.emf.ecore.plugin.EcorePlugin;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model <b>Factory</b>.
 * <!-- end-user-doc -->
 * @generated
 */
public class TableFactoryImpl extends EFactoryImpl implements TableFactory {
    /**
     * Creates the default factory implementation.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public static TableFactory init() {
        try {
            TableFactory theTableFactory = (TableFactory)EPackage.Registry.INSTANCE.getEFactory(TablePackage.eNS_URI);
            if (theTableFactory != null) {
                return theTableFactory;
            }
        }
        catch (Exception exception) {
            EcorePlugin.INSTANCE.log(exception);
        }
        return new TableFactoryImpl();
    }

    /**
     * Creates an instance of the factory.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableFactoryImpl() {
        super();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public EObject create(EClass eClass) {
        switch (eClass.getClassifierID()) {
            case TablePackage.TABLE_ELEMENT: return createTableElement();
            case TablePackage.TABLE: return createTable();
            case TablePackage.TABLE_MEMBER: return createTableMember();
            case TablePackage.NAMED: return createNamed();
            case TablePackage.TABLE_ATTRIBUTE: return createTableAttribute();
            case TablePackage.TABLE_REFERENCE: return createTableReference();
            case TablePackage.TABLE_CONTAINMENT: return createTableContainment();
            case TablePackage.SUB_TABLE: return createSubTable();
            case TablePackage.ROOT_TABLE: return createRootTable();
            case TablePackage.REFERENCE_TABLE: return createReferenceTable();
            default:
                throw new IllegalArgumentException("The class '" + eClass.getName() + "' is not a valid classifier");
        }
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableElement createTableElement() {
        TableElementImpl tableElement = new TableElementImpl();
        return tableElement;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public Table createTable() {
        TableImpl table = new TableImpl();
        return table;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableMember createTableMember() {
        TableMemberImpl tableMember = new TableMemberImpl();
        return tableMember;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public Named createNamed() {
        NamedImpl named = new NamedImpl();
        return named;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableAttribute createTableAttribute() {
        TableAttributeImpl tableAttribute = new TableAttributeImpl();
        return tableAttribute;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableReference createTableReference() {
        TableReferenceImpl tableReference = new TableReferenceImpl();
        return tableReference;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableContainment createTableContainment() {
        TableContainmentImpl tableContainment = new TableContainmentImpl();
        return tableContainment;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public SubTable createSubTable() {
        SubTableImpl subTable = new SubTableImpl();
        return subTable;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public RootTable createRootTable() {
        RootTableImpl rootTable = new RootTableImpl();
        return rootTable;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public ReferenceTable createReferenceTable() {
        ReferenceTableImpl referenceTable = new ReferenceTableImpl();
        return referenceTable;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TablePackage getTablePackage() {
        return (TablePackage)getEPackage();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @deprecated
     * @generated
     */
    @Deprecated
    public static TablePackage getPackage() {
        return TablePackage.eINSTANCE;
    }

} //TableFactoryImpl
