/**
 */
package de.fhws.rdsl.generator.table;

import org.eclipse.emf.ecore.EFactory;

/**
 * <!-- begin-user-doc -->
 * The <b>Factory</b> for the model.
 * It provides a create method for each non-abstract class of the model.
 * <!-- end-user-doc -->
 * @see de.fhws.rdsl.generator.table.TablePackage
 * @generated
 */
public interface TableFactory extends EFactory {
    /**
     * The singleton instance of the factory.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    TableFactory eINSTANCE = de.fhws.rdsl.generator.table.impl.TableFactoryImpl.init();

    /**
     * Returns a new object of class '<em>Element</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Element</em>'.
     * @generated
     */
    TableElement createTableElement();

    /**
     * Returns a new object of class '<em>Table</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Table</em>'.
     * @generated
     */
    Table createTable();

    /**
     * Returns a new object of class '<em>Member</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Member</em>'.
     * @generated
     */
    TableMember createTableMember();

    /**
     * Returns a new object of class '<em>Named</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Named</em>'.
     * @generated
     */
    Named createNamed();

    /**
     * Returns a new object of class '<em>Attribute</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Attribute</em>'.
     * @generated
     */
    TableAttribute createTableAttribute();

    /**
     * Returns a new object of class '<em>Reference</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Reference</em>'.
     * @generated
     */
    TableReference createTableReference();

    /**
     * Returns a new object of class '<em>Containment</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Containment</em>'.
     * @generated
     */
    TableContainment createTableContainment();

    /**
     * Returns a new object of class '<em>Sub Table</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Sub Table</em>'.
     * @generated
     */
    SubTable createSubTable();

    /**
     * Returns a new object of class '<em>Root Table</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Root Table</em>'.
     * @generated
     */
    RootTable createRootTable();

    /**
     * Returns a new object of class '<em>Reference Table</em>'.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return a new object of class '<em>Reference Table</em>'.
     * @generated
     */
    ReferenceTable createReferenceTable();

    /**
     * Returns the package supported by this factory.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the package supported by this factory.
     * @generated
     */
    TablePackage getTablePackage();

} //TableFactory
