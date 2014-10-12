/**
 */
package de.fhws.rdsl.generator.table.impl;

import de.fhws.rdsl.generator.table.IntAttribute;
import de.fhws.rdsl.generator.table.TablePackage;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Int Attribute</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.IntAttributeImpl#getStart <em>Start</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.IntAttributeImpl#getStop <em>Stop</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class IntAttributeImpl extends TableAttributeImpl implements IntAttribute {
    /**
     * The default value of the '{@link #getStart() <em>Start</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStart()
     * @generated
     * @ordered
     */
    protected static final int START_EDEFAULT = 0;

    /**
     * The cached value of the '{@link #getStart() <em>Start</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStart()
     * @generated
     * @ordered
     */
    protected int start = START_EDEFAULT;

    /**
     * The default value of the '{@link #getStop() <em>Stop</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStop()
     * @generated
     * @ordered
     */
    protected static final int STOP_EDEFAULT = 0;

    /**
     * The cached value of the '{@link #getStop() <em>Stop</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStop()
     * @generated
     * @ordered
     */
    protected int stop = STOP_EDEFAULT;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected IntAttributeImpl() {
        super();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    protected EClass eStaticClass() {
        return TablePackage.Literals.INT_ATTRIBUTE;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public int getStart() {
        return start;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setStart(int newStart) {
        int oldStart = start;
        start = newStart;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.INT_ATTRIBUTE__START, oldStart, start));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public int getStop() {
        return stop;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setStop(int newStop) {
        int oldStop = stop;
        stop = newStop;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.INT_ATTRIBUTE__STOP, oldStop, stop));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public Object eGet(int featureID, boolean resolve, boolean coreType) {
        switch (featureID) {
            case TablePackage.INT_ATTRIBUTE__START:
                return getStart();
            case TablePackage.INT_ATTRIBUTE__STOP:
                return getStop();
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
            case TablePackage.INT_ATTRIBUTE__START:
                setStart((Integer)newValue);
                return;
            case TablePackage.INT_ATTRIBUTE__STOP:
                setStop((Integer)newValue);
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
            case TablePackage.INT_ATTRIBUTE__START:
                setStart(START_EDEFAULT);
                return;
            case TablePackage.INT_ATTRIBUTE__STOP:
                setStop(STOP_EDEFAULT);
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
            case TablePackage.INT_ATTRIBUTE__START:
                return start != START_EDEFAULT;
            case TablePackage.INT_ATTRIBUTE__STOP:
                return stop != STOP_EDEFAULT;
        }
        return super.eIsSet(featureID);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public String toString() {
        if (eIsProxy()) return super.toString();

        StringBuffer result = new StringBuffer(super.toString());
        result.append(" (start: ");
        result.append(start);
        result.append(", stop: ");
        result.append(stop);
        result.append(')');
        return result.toString();
    }

} //IntAttributeImpl
