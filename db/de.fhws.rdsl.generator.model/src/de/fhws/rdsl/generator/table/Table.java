/**
 */
package de.fhws.rdsl.generator.table;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Table</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.Table#getMembers <em>Members</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.Table#getIdentifiers <em>Identifiers</em>}</li>
 * </ul>
 * </p>
 *
 * @see de.fhws.rdsl.generator.table.TablePackage#getTable()
 * @model
 * @generated
 */
public interface Table extends TableElement, Named {
    /**
     * Returns the value of the '<em><b>Members</b></em>' containment reference list.
     * The list contents are of type {@link de.fhws.rdsl.generator.table.TableMember}.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Members</em>' containment reference list isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Members</em>' containment reference list.
     * @see de.fhws.rdsl.generator.table.TablePackage#getTable_Members()
     * @model containment="true"
     * @generated
     */
    EList<TableMember> getMembers();

    /**
     * Returns the value of the '<em><b>Identifiers</b></em>' attribute list.
     * The list contents are of type {@link java.lang.String}.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Identifiers</em>' attribute list isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Identifiers</em>' attribute list.
     * @see de.fhws.rdsl.generator.table.TablePackage#getTable_Identifiers()
     * @model
     * @generated
     */
    EList<String> getIdentifiers();

} // Table
