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
 * An implementation of the model object '<em><b>Reference</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.TableReferenceImpl#getReferenceTable <em>Reference Table</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.TableReferenceImpl#isList <em>List</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class TableReferenceImpl extends TableMemberImpl implements TableReference {
    /**
     * The cached value of the '{@link #getReferenceTable() <em>Reference Table</em>}' reference.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getReferenceTable()
     * @generated
     * @ordered
     */
    protected ReferenceTable referenceTable;

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
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected TableReferenceImpl() {
        super();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    protected EClass eStaticClass() {
        return TablePackage.Literals.TABLE_REFERENCE;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public ReferenceTable getReferenceTable() {
        if (referenceTable != null && referenceTable.eIsProxy()) {
            InternalEObject oldReferenceTable = (InternalEObject)referenceTable;
            referenceTable = (ReferenceTable)eResolveProxy(oldReferenceTable);
            if (referenceTable != oldReferenceTable) {
                if (eNotificationRequired())
                    eNotify(new ENotificationImpl(this, Notification.RESOLVE, TablePackage.TABLE_REFERENCE__REFERENCE_TABLE, oldReferenceTable, referenceTable));
            }
        }
        return referenceTable;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public ReferenceTable basicGetReferenceTable() {
        return referenceTable;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setReferenceTable(ReferenceTable newReferenceTable) {
        ReferenceTable oldReferenceTable = referenceTable;
        referenceTable = newReferenceTable;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.TABLE_REFERENCE__REFERENCE_TABLE, oldReferenceTable, referenceTable));
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
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.TABLE_REFERENCE__LIST, oldList, list));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public Object eGet(int featureID, boolean resolve, boolean coreType) {
        switch (featureID) {
            case TablePackage.TABLE_REFERENCE__REFERENCE_TABLE:
                if (resolve) return getReferenceTable();
                return basicGetReferenceTable();
            case TablePackage.TABLE_REFERENCE__LIST:
                return isList();
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
            case TablePackage.TABLE_REFERENCE__REFERENCE_TABLE:
                setReferenceTable((ReferenceTable)newValue);
                return;
            case TablePackage.TABLE_REFERENCE__LIST:
                setList((Boolean)newValue);
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
            case TablePackage.TABLE_REFERENCE__REFERENCE_TABLE:
                setReferenceTable((ReferenceTable)null);
                return;
            case TablePackage.TABLE_REFERENCE__LIST:
                setList(LIST_EDEFAULT);
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
            case TablePackage.TABLE_REFERENCE__REFERENCE_TABLE:
                return referenceTable != null;
            case TablePackage.TABLE_REFERENCE__LIST:
                return list != LIST_EDEFAULT;
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

} //TableReferenceImpl
