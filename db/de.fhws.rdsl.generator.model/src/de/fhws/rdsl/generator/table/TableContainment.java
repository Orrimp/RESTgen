/**
 */
package de.fhws.rdsl.generator.table;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Containment</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.TableContainment#isList <em>List</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.TableContainment#getSubTable <em>Sub Table</em>}</li>
 * </ul>
 * </p>
 *
 * @see de.fhws.rdsl.generator.table.TablePackage#getTableContainment()
 * @model
 * @generated
 */
public interface TableContainment extends TableMember {
    /**
     * Returns the value of the '<em><b>List</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>List</em>' attribute isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>List</em>' attribute.
     * @see #setList(boolean)
     * @see de.fhws.rdsl.generator.table.TablePackage#getTableContainment_List()
     * @model
     * @generated
     */
    boolean isList();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.TableContainment#isList <em>List</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>List</em>' attribute.
     * @see #isList()
     * @generated
     */
    void setList(boolean value);

    /**
     * Returns the value of the '<em><b>Sub Table</b></em>' containment reference.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Sub Table</em>' containment reference isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Sub Table</em>' containment reference.
     * @see #setSubTable(SubTable)
     * @see de.fhws.rdsl.generator.table.TablePackage#getTableContainment_SubTable()
     * @model containment="true"
     * @generated
     */
    SubTable getSubTable();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.TableContainment#getSubTable <em>Sub Table</em>}' containment reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Sub Table</em>' containment reference.
     * @see #getSubTable()
     * @generated
     */
    void setSubTable(SubTable value);

} // TableContainment
