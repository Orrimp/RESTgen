/**
 */
package de.fhws.rdsl.generator.table.impl;

import de.fhws.rdsl.generator.table.SubTable;
import de.fhws.rdsl.generator.table.TableContainment;
import de.fhws.rdsl.generator.table.TablePackage;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Containment</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.TableContainmentImpl#isList <em>List</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.TableContainmentImpl#getSubTable <em>Sub Table</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class TableContainmentImpl extends TableMemberImpl implements TableContainment {
    /**
     * The default value of the '{@link #isList() <em>List</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #isList()
     * @generated
     * @ordered
     */
    protected static final boolean LIST_EDEFAULT = false;

    /**
     * The cached value of the '{@link #isList() <em>List</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #isList()
     * @generated
     * @ordered
     */
    protected boolean list = LIST_EDEFAULT;

    /**
     * The cached value of the '{@link #getSubTable() <em>Sub Table</em>}' containment reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getSubTable()
     * @generated
     * @ordered
     */
    protected SubTable subTable;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected TableContainmentImpl() {
        super();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    protected EClass eStaticClass() {
        return TablePackage.Literals.TABLE_CONTAINMENT;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public boolean isList() {
        return list;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setList(boolean newList) {
        boolean oldList = list;
        list = newList;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.TABLE_CONTAINMENT__LIST, oldList, list));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public SubTable getSubTable() {
        return subTable;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public NotificationChain basicSetSubTable(SubTable newSubTable, NotificationChain msgs) {
        SubTable oldSubTable = subTable;
        subTable = newSubTable;
        if (eNotificationRequired()) {
            ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, TablePackage.TABLE_CONTAINMENT__SUB_TABLE, oldSubTable, newSubTable);
            if (msgs == null) msgs = notification; else msgs.add(notification);
        }
        return msgs;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setSubTable(SubTable newSubTable) {
        if (newSubTable != subTable) {
            NotificationChain msgs = null;
            if (subTable != null)
                msgs = ((InternalEObject)subTable).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - TablePackage.TABLE_CONTAINMENT__SUB_TABLE, null, msgs);
            if (newSubTable != null)
                msgs = ((InternalEObject)newSubTable).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - TablePackage.TABLE_CONTAINMENT__SUB_TABLE, null, msgs);
            msgs = basicSetSubTable(newSubTable, msgs);
            if (msgs != null) msgs.dispatch();
        }
        else if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.TABLE_CONTAINMENT__SUB_TABLE, newSubTable, newSubTable));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
        switch (featureID) {
            case TablePackage.TABLE_CONTAINMENT__SUB_TABLE:
                return basicSetSubTable(null, msgs);
        }
        return super.eInverseRemove(otherEnd, featureID, msgs);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public Object eGet(int featureID, boolean resolve, boolean coreType) {
        switch (featureID) {
            case TablePackage.TABLE_CONTAINMENT__LIST:
                return isList();
            case TablePackage.TABLE_CONTAINMENT__SUB_TABLE:
                return getSubTable();
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
            case TablePackage.TABLE_CONTAINMENT__LIST:
                setList((Boolean)newValue);
                return;
            case TablePackage.TABLE_CONTAINMENT__SUB_TABLE:
                setSubTable((SubTable)newValue);
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
            case TablePackage.TABLE_CONTAINMENT__LIST:
                setList(LIST_EDEFAULT);
                return;
            case TablePackage.TABLE_CONTAINMENT__SUB_TABLE:
                setSubTable((SubTable)null);
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
            case TablePackage.TABLE_CONTAINMENT__LIST:
                return list != LIST_EDEFAULT;
            case TablePackage.TABLE_CONTAINMENT__SUB_TABLE:
                return subTable != null;
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
        result.append(" (list: ");
        result.append(list);
        result.append(')');
        return result.toString();
    }

} //TableContainmentImpl
