/**
 */
package de.fhws.rdsl.generator.table.impl;

import de.fhws.rdsl.generator.table.ReferenceTable;
import de.fhws.rdsl.generator.table.TablePackage;
import de.fhws.rdsl.generator.table.TableReference;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Reference Table</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.ReferenceTableImpl#getLeft <em>Left</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.ReferenceTableImpl#getRight <em>Right</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class ReferenceTableImpl extends TableImpl implements ReferenceTable {
    /**
     * The cached value of the '{@link #getLeft() <em>Left</em>}' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getLeft()
     * @generated
     * @ordered
     */
    protected TableReference left;

    /**
     * The cached value of the '{@link #getRight() <em>Right</em>}' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getRight()
     * @generated
     * @ordered
     */
    protected TableReference right;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected ReferenceTableImpl() {
        super();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    protected EClass eStaticClass() {
        return TablePackage.Literals.REFERENCE_TABLE;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableReference getLeft() {
        if (left != null && left.eIsProxy()) {
            InternalEObject oldLeft = (InternalEObject)left;
            left = (TableReference)eResolveProxy(oldLeft);
            if (left != oldLeft) {
                if (eNotificationRequired())
                    eNotify(new ENotificationImpl(this, Notification.RESOLVE, TablePackage.REFERENCE_TABLE__LEFT, oldLeft, left));
            }
        }
        return left;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableReference basicGetLeft() {
        return left;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setLeft(TableReference newLeft) {
        TableReference oldLeft = left;
        left = newLeft;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.REFERENCE_TABLE__LEFT, oldLeft, left));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableReference getRight() {
        if (right != null && right.eIsProxy()) {
            InternalEObject oldRight = (InternalEObject)right;
            right = (TableReference)eResolveProxy(oldRight);
            if (right != oldRight) {
                if (eNotificationRequired())
                    eNotify(new ENotificationImpl(this, Notification.RESOLVE, TablePackage.REFERENCE_TABLE__RIGHT, oldRight, right));
            }
        }
        return right;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableReference basicGetRight() {
        return right;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setRight(TableReference newRight) {
        TableReference oldRight = right;
        right = newRight;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.REFERENCE_TABLE__RIGHT, oldRight, right));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public Object eGet(int featureID, boolean resolve, boolean coreType) {
        switch (featureID) {
            case TablePackage.REFERENCE_TABLE__LEFT:
                if (resolve) return getLeft();
                return basicGetLeft();
            case TablePackage.REFERENCE_TABLE__RIGHT:
                if (resolve) return getRight();
                return basicGetRight();
        }
        return super.eGet(featureID, resolve, coreType);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public void eSet(int featureID, Object newValue) {
        switch (featureID) {
            case TablePackage.REFERENCE_TABLE__LEFT:
                setLeft((TableReference)newValue);
                return;
            case TablePackage.REFERENCE_TABLE__RIGHT:
                setRight((TableReference)newValue);
                return;
        }
        super.eSet(featureID, newValue);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public void eUnset(int featureID) {
        switch (featureID) {
            case TablePackage.REFERENCE_TABLE__LEFT:
                setLeft((TableReference)null);
                return;
            case TablePackage.REFERENCE_TABLE__RIGHT:
                setRight((TableReference)null);
                return;
        }
        super.eUnset(featureID);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public boolean eIsSet(int featureID) {
        switch (featureID) {
            case TablePackage.REFERENCE_TABLE__LEFT:
                return left != null;
            case TablePackage.REFERENCE_TABLE__RIGHT:
                return right != null;
        }
        return super.eIsSet(featureID);
    }

} //ReferenceTableImpl
