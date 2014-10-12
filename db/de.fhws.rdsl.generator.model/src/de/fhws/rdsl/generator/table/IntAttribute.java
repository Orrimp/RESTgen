/**
 */
package de.fhws.rdsl.generator.table;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Int Attribute</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.IntAttribute#getStart <em>Start</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.IntAttribute#getStop <em>Stop</em>}</li>
 * </ul>
 * </p>
 *
 * @see de.fhws.rdsl.generator.table.TablePackage#getIntAttribute()
 * @model
 * @generated
 */
public interface IntAttribute extends TableAttribute {
    /**
     * Returns the value of the '<em><b>Start</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Start</em>' attribute isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Start</em>' attribute.
     * @see #setStart(int)
     * @see de.fhws.rdsl.generator.table.TablePackage#getIntAttribute_Start()
     * @model
     * @generated
     */
    int getStart();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.IntAttribute#getStart <em>Start</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Start</em>' attribute.
     * @see #getStart()
     * @generated
     */
    void setStart(int value);

    /**
     * Returns the value of the '<em><b>Stop</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Stop</em>' attribute isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Stop</em>' attribute.
     * @see #setStop(int)
     * @see de.fhws.rdsl.generator.table.TablePackage#getIntAttribute_Stop()
     * @model
     * @generated
     */
    int getStop();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.IntAttribute#getStop <em>Stop</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Stop</em>' attribute.
     * @see #getStop()
     * @generated
     */
    void setStop(int value);

} // IntAttribute
