/**
 */
package de.fhws.rdsl.generator.table;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Reference</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.TableReference#getReferenceTable <em>Reference Table</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.TableReference#isList <em>List</em>}</li>
 * </ul>
 * </p>
 *
 * @see de.fhws.rdsl.generator.table.TablePackage#getTableReference()
 * @model
 * @generated
 */
public interface TableReference extends TableMember {
    /**
     * Returns the value of the '<em><b>Reference Table</b></em>' reference.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Reference Table</em>' reference isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Reference Table</em>' reference.
     * @see #setReferenceTable(ReferenceTable)
     * @see de.fhws.rdsl.generator.table.TablePackage#getTableReference_ReferenceTable()
     * @model
     * @generated
     */
    ReferenceTable getReferenceTable();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.TableReference#getReferenceTable <em>Reference Table</em>}' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Reference Table</em>' reference.
     * @see #getReferenceTable()
     * @generated
     */
    void setReferenceTable(ReferenceTable value);

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
     * @see de.fhws.rdsl.generator.table.TablePackage#getTableReference_List()
     * @model
     * @generated
     */
    boolean isList();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.TableReference#isList <em>List</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>List</em>' attribute.
     * @see #isList()
     * @generated
     */
    void setList(boolean value);

} // TableReference
