/**
 */
package de.fhws.rdsl.generator.table.impl;

import de.fhws.rdsl.generator.table.TableAttribute;
import de.fhws.rdsl.generator.table.TablePackage;

import java.util.Collection;
import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.util.EDataTypeUniqueEList;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Attribute</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.TableAttributeImpl#getFlags <em>Flags</em>}</li>
 *   <li>{@link de.fhws.rdsl.generator.table.impl.TableAttributeImpl#isQueryable <em>Queryable</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public abstract class TableAttributeImpl extends TableMemberImpl implements TableAttribute {
    /**
     * The cached value of the '{@link #getFlags() <em>Flags</em>}' attribute list.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #getFlags()
     * @generated
     * @ordered
     */
    protected EList<String> flags;

    /**
     * The default value of the '{@link #isQueryable() <em>Queryable</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #isQueryable()
     * @generated
     * @ordered
     */
    protected static final boolean QUERYABLE_EDEFAULT = false;

    /**
     * The cached value of the '{@link #isQueryable() <em>Queryable</em>}' attribute.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @see #isQueryable()
     * @generated
     * @ordered
     */
    protected boolean queryable = QUERYABLE_EDEFAULT;

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected TableAttributeImpl() {
        super();
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    protected EClass eStaticClass() {
        return TablePackage.Literals.TABLE_ATTRIBUTE;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public EList<String> getFlags() {
        if (flags == null) {
            flags = new EDataTypeUniqueEList<String>(String.class, this, TablePackage.TABLE_ATTRIBUTE__FLAGS);
        }
        return flags;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public boolean isQueryable() {
        return queryable;
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public void setQueryable(boolean newQueryable) {
        boolean oldQueryable = queryable;
        queryable = newQueryable;
        if (eNotificationRequired())
            eNotify(new ENotificationImpl(this, Notification.SET, TablePackage.TABLE_ATTRIBUTE__QUERYABLE, oldQueryable, queryable));
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @Override
    public Object eGet(int featureID, boolean resolve, boolean coreType) {
        switch (featureID) {
            case TablePackage.TABLE_ATTRIBUTE__FLAGS:
                return getFlags();
            case TablePackage.TABLE_ATTRIBUTE__QUERYABLE:
                return isQueryable();
        }
        return super.eGet(featureID, resolve, coreType);
    }

    /**
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    @SuppressWarnings("unchecked")
    @Override
    public void eSet(int featureID, Object newValue) {
        switch (featureID) {
            case TablePackage.TABLE_ATTRIBUTE__FLAGS:
                getFlags().clear();
                getFlags().addAll((Collection<? extends String>)newValue);
                return;
            case TablePackage.TABLE_ATTRIBUTE__QUERYABLE:
                setQueryable((Boolean)newValue);
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
            case TablePackage.TABLE_ATTRIBUTE__FLAGS:
                getFlags().clear();
                return;
            case TablePackage.TABLE_ATTRIBUTE__QUERYABLE:
                setQueryable(QUERYABLE_EDEFAULT);
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
            case TablePackage.TABLE_ATTRIBUTE__FLAGS:
                return flags != null && !flags.isEmpty();
            case TablePackage.TABLE_ATTRIBUTE__QUERYABLE:
                return queryable != QUERYABLE_EDEFAULT;
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
        result.append(" (flags: ");
        result.append(flags);
        result.append(", queryable: ");
        result.append(queryable);
        result.append(')');
        return result.toString();
    }

} //TableAttributeImpl
