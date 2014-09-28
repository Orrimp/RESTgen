/**
 */
package de.fhws.rdsl.generator.table;

import org.eclipse.emf.common.util.EList;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Attribute</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.TableAttribute#getType <em>Type</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.TableAttribute#getFlags <em>Flags</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.TableAttribute#isQueryable <em>Queryable</em>}</li>
 * </ul>
 * </p>
 *
 * @see de.fhws.rdsl.generator.table.TablePackage#getTableAttribute()
 * @model
 * @generated
 */
public interface TableAttribute extends TableMember {
    /**
     * Returns the value of the '<em><b>Type</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Type</em>' attribute isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Type</em>' attribute.
     * @see #setType(String)
     * @see de.fhws.rdsl.generator.table.TablePackage#getTableAttribute_Type()
     * @model
     * @generated
     */
    String getType();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.TableAttribute#getType <em>Type</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Type</em>' attribute.
     * @see #getType()
     * @generated
     */
    void setType(String value);

    /**
     * Returns the value of the '<em><b>Flags</b></em>' attribute list.
     * The list contents are of type {@link java.lang.String}.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Flags</em>' attribute list isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Flags</em>' attribute list.
     * @see de.fhws.rdsl.generator.table.TablePackage#getTableAttribute_Flags()
     * @model
     * @generated
     */
    EList<String> getFlags();

    /**
     * Returns the value of the '<em><b>Queryable</b></em>' attribute.
     * <!-- begin-user-doc -->
     * <p>
     * If the meaning of the '<em>Queryable</em>' attribute isn't clear,
     * there really should be more of a description here...
     * </p>
     * <!-- end-user-doc -->
     * @return the value of the '<em>Queryable</em>' attribute.
     * @see #setQueryable(boolean)
     * @see de.fhws.rdsl.generator.table.TablePackage#getTableAttribute_Queryable()
     * @model
     * @generated
     */
    boolean isQueryable();

    /**
     * Sets the value of the '{@link de.fhws.rdsl.generator.table.TableAttribute#isQueryable <em>Queryable</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @param value the new value of the '<em>Queryable</em>' attribute.
     * @see #isQueryable()
     * @generated
     */
    void setQueryable(boolean value);

} // TableAttribute
