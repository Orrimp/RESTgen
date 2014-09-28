/**
 */
package de.fhws.rdsl.generator.table;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Reference Table</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.ReferenceTable#getLeft <em>Left</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.ReferenceTable#getRight <em>Right</em>}</li>
 * </ul>
 * </p>
 *
 * @see de.fhws.rdsl.generator.table.TablePackage#getReferenceTable()
 * @model
 * @generated
 */
public interface ReferenceTable extends Table {
    /**
     * Returns the value of the '<em><b>Left</b></em>' reference.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Left</em>' reference isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Left</em>' reference.
     * @see #setLeft(TableReference)
     * @see de.fhws.rdsl.generator.table.TablePackage#getReferenceTable_Left()
     * @model
     * @generated
     */
    TableReference getLeft();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.ReferenceTable#getLeft <em>Left</em>}' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Left</em>' reference.
     * @see #getLeft()
     * @generated
     */
    void setLeft(TableReference value);

    /**
     * Returns the value of the '<em><b>Right</b></em>' reference.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Right</em>' reference isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Right</em>' reference.
     * @see #setRight(TableReference)
     * @see de.fhws.rdsl.generator.table.TablePackage#getReferenceTable_Right()
     * @model
     * @generated
     */
    TableReference getRight();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.ReferenceTable#getRight <em>Right</em>}' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Right</em>' reference.
     * @see #getRight()
     * @generated
     */
    void setRight(TableReference value);

} // ReferenceTable
