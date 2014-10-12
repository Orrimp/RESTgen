/**
 */
package de.fhws.rdsl.generator.table.impl;

import de.fhws.rdsl.generator.table.FloatAttribute;
import de.fhws.rdsl.generator.table.TablePackage;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Float Attribute</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.FloatAttributeImpl#getStart <em>Start</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.FloatAttributeImpl#getStop <em>Stop</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class FloatAttributeImpl extends TableAttributeImpl implements FloatAttribute {
    /**
     * The default value of the '{@link #getStart() <em>Start</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStart()
     * @generated
     * @ordered
     */
    protected static final float START_EDEFAULT = 0.0F;

    /**
     * The cached value of the '{@link #getStart() <em>Start</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStart()
     * @generated
     * @ordered
     */
    protected float start = START_EDEFAULT;

    /**
     * This is true if the Start attribute has been set.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    protected boolean startESet;

    /**
     * The default value of the '{@link #getStop() <em>Stop</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStop()
     * @generated
     * @ordered
     */
    protected static final float STOP_EDEFAULT = 0.0F;

    /**
     * The cached value of the '{@link #getStop() <em>Stop</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getStop()
     * @generated
     * @ordered
     */
    protected float stop = STOP_EDEFAULT;

    /**
     * This is true if the Stop attribute has been set.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     * @ordered
     */
    protected boolean stopESet;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected FloatAttributeImpl() {
        super();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    protected EClass eStaticClass() {
        return TablePackage.Literals.FLOAT_ATTRIBUTE;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public float getStart() {
        return start;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setStart(float newStart) {
        float oldStart = start;
        start = newStart;
        boolean oldStartESet = startESet;
        startESet = true;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.FLOAT_ATTRIBUTE__START, oldStart, start, !oldStartESet));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void unsetStart() {
        float oldStart = start;
        boolean oldStartESet = startESet;
        start = START_EDEFAULT;
        startESet = false;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.UNSET, TablePackage.FLOAT_ATTRIBUTE__START, oldStart, START_EDEFAULT, oldStartESet));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public boolean isSetStart() {
        return startESet;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public float getStop() {
        return stop;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setStop(float newStop) {
        float oldStop = stop;
        stop = newStop;
        boolean oldStopESet = stopESet;
        stopESet = true;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.FLOAT_ATTRIBUTE__STOP, oldStop, stop, !oldStopESet));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void unsetStop() {
        float oldStop = stop;
        boolean oldStopESet = stopESet;
        stop = STOP_EDEFAULT;
        stopESet = false;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.UNSET, TablePackage.FLOAT_ATTRIBUTE__STOP, oldStop, STOP_EDEFAULT, oldStopESet));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public boolean isSetStop() {
        return stopESet;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public Object eGet(int featureID, boolean resolve, boolean coreType) {
        switch (featureID) {
            case TablePackage.FLOAT_ATTRIBUTE__START:
                return getStart();
            case TablePackage.FLOAT_ATTRIBUTE__STOP:
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
            case TablePackage.FLOAT_ATTRIBUTE__START:
                setStart((Float)newValue);
                return;
            case TablePackage.FLOAT_ATTRIBUTE__STOP:
                setStop((Float)newValue);
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
            case TablePackage.FLOAT_ATTRIBUTE__START:
                unsetStart();
                return;
            case TablePackage.FLOAT_ATTRIBUTE__STOP:
                unsetStop();
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
            case TablePackage.FLOAT_ATTRIBUTE__START:
                return isSetStart();
            case TablePackage.FLOAT_ATTRIBUTE__STOP:
                return isSetStop();
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
        if (startESet) result.append(start); else result.append("<unset>");
        result.append(", stop: ");
        if (stopESet) result.append(stop); else result.append("<unset>");
        result.append(')');
        return result.toString();
    }

} //FloatAttributeImpl
