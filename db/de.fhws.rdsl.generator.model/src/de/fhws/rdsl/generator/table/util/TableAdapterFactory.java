/**
 */
package de.fhws.rdsl.generator.table.util;

import de.fhws.rdsl.generator.table.*;

import org.eclipse.emf.common.notify.Adapter;
import org.eclipse.emf.common.notify.Notifier;

import org.eclipse.emf.common.notify.impl.AdapterFactoryImpl;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * The <b>Adapter Factory</b> for the model.
 * It provides an adapter <code>createXXX</code> method for each class of the model.
 * <!-- end-user-doc -->
 * @see de.fhws.rdsl.generator.table.TablePackage
 * @generated
 */
public class TableAdapterFactory extends AdapterFactoryImpl {
    /**
     * The cached model package.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected static TablePackage modelPackage;

    /**
     * Creates an instance of the adapter factory.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableAdapterFactory() {
        if (modelPackage == null) {
            modelPackage = TablePackage.eINSTANCE;
        }
    }

    /**
     * Returns whether this factory is applicable for the type of the object.
     * <!-- begin-user-doc -->
     * This implementation returns <code>true</code> if the object is either the model's package or is an instance object of the model.
     * <!-- end-user-doc -->
     * @return whether this factory is applicable for the type of the object.
     * @generated
     */
    @Override
    public boolean isFactoryForType(Object object) {
        if (object == modelPackage) {
            return true;
        }
        if (object instanceof EObject) {
            return ((EObject)object).eClass().getEPackage() == modelPackage;
        }
        return false;
    }

    /**
     * The switch that delegates to the <code>createXXX</code> methods.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected TableSwitch<Adapter> modelSwitch =
        new TableSwitch<Adapter>() {
            @Override
            public Adapter caseTableElement(TableElement object) {
                return createTableElementAdapter();
            }
            @Override
            public Adapter caseTable(Table object) {
                return createTableAdapter();
            }
            @Override
            public Adapter caseTableMember(TableMember object) {
                return createTableMemberAdapter();
            }
            @Override
            public Adapter caseNamed(Named object) {
                return createNamedAdapter();
            }
            @Override
            public Adapter caseTableAttribute(TableAttribute object) {
                return createTableAttributeAdapter();
            }
            @Override
            public Adapter caseTableReference(TableReference object) {
                return createTableReferenceAdapter();
            }
            @Override
            public Adapter caseTableContainment(TableContainment object) {
                return createTableContainmentAdapter();
            }
            @Override
            public Adapter caseSubTable(SubTable object) {
                return createSubTableAdapter();
            }
            @Override
            public Adapter caseRootTable(RootTable object) {
                return createRootTableAdapter();
            }
            @Override
            public Adapter caseReferenceTable(ReferenceTable object) {
                return createReferenceTableAdapter();
            }
            @Override
            public Adapter defaultCase(EObject object) {
                return createEObjectAdapter();
            }
        };

    /**
     * Creates an adapter for the <code>target</code>.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param target the object to adapt.
     * @return the adapter for the <code>target</code>.
     * @generated
     */
    @Override
    public Adapter createAdapter(Notifier target) {
        return modelSwitch.doSwitch((EObject)target);
    }


    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.TableElement <em>Element</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.TableElement
     * @generated
     */
    public Adapter createTableElementAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.Table <em>Table</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.Table
     * @generated
     */
    public Adapter createTableAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.TableMember <em>Member</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.TableMember
     * @generated
     */
    public Adapter createTableMemberAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.Named <em>Named</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.Named
     * @generated
     */
    public Adapter createNamedAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.TableAttribute <em>Attribute</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.TableAttribute
     * @generated
     */
    public Adapter createTableAttributeAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.TableReference <em>Reference</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.TableReference
     * @generated
     */
    public Adapter createTableReferenceAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.TableContainment <em>Containment</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.TableContainment
     * @generated
     */
    public Adapter createTableContainmentAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.SubTable <em>Sub Table</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.SubTable
     * @generated
     */
    public Adapter createSubTableAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.RootTable <em>Root Table</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.RootTable
     * @generated
     */
    public Adapter createRootTableAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for an object of class '{@link de.fhws.rdsl.generator.table.ReferenceTable <em>Reference Table</em>}'.
     * <!-- begin-user-doc -->
     * This default implementation returns null so that we can easily ignore cases;
     * it's useful to ignore a case when inheritance will catch all the cases anyway.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @see de.fhws.rdsl.generator.table.ReferenceTable
     * @generated
     */
    public Adapter createReferenceTableAdapter() {
        return null;
    }

    /**
     * Creates a new adapter for the default case.
     * <!-- begin-user-doc -->
     * This default implementation returns null.
     * <!-- end-user-doc -->
     * @return the new adapter.
     * @generated
     */
    public Adapter createEObjectAdapter() {
        return null;
    }

} //TableAdapterFactory
