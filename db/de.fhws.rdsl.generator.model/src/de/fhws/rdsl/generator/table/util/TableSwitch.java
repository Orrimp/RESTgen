/**
 */
package de.fhws.rdsl.generator.table.util;

import de.fhws.rdsl.generator.table.*;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;

import org.eclipse.emf.ecore.util.Switch;

/**
 * <!-- begin-user-doc -->
 * The <b>Switch</b> for the model's inheritance hierarchy.
 * It supports the call {@link #doSwitch(EObject) doSwitch(object)}
 * to invoke the <code>caseXXX</code> method for each class of the model,
 * starting with the actual class of the object
 * and proceeding up the inheritance hierarchy
 * until a non-null result is returned,
 * which is the result of the switch.
 * <!-- end-user-doc -->
 * @see de.fhws.rdsl.generator.table.TablePackage
 * @generated
 */
public class TableSwitch<T> extends Switch<T> {
    /**
     * The cached model package
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    protected static TablePackage modelPackage;

    /**
     * Creates an instance of the switch.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @generated
     */
    public TableSwitch() {
        if (modelPackage == null) {
            modelPackage = TablePackage.eINSTANCE;
        }
    }

    /**
     * Checks whether this is a switch for the given package.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @parameter ePackage the package in question.
     * @return whether this is a switch for the given package.
     * @generated
     */
    @Override
    protected boolean isSwitchFor(EPackage ePackage) {
        return ePackage == modelPackage;
    }

    /**
     * Calls <code>caseXXX</code> for each class of the model until one returns a non null result; it yields that result.
     * <!-- begin-user-doc -->
     * <!-- end-user-doc -->
     * @return the first non-null result returned by a <code>caseXXX</code> call.
     * @generated
     */
    @Override
    protected T doSwitch(int classifierID, EObject theEObject) {
        switch (classifierID) {
            case TablePackage.TABLE_ELEMENT: {
                TableElement tableElement = (TableElement)theEObject;
                T result = caseTableElement(tableElement);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.TABLE: {
                Table table = (Table)theEObject;
                T result = caseTable(table);
                if (result == null) result = caseTableElement(table);
                if (result == null) result = caseNamed(table);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.TABLE_MEMBER: {
                TableMember tableMember = (TableMember)theEObject;
                T result = caseTableMember(tableMember);
                if (result == null) result = caseTableElement(tableMember);
                if (result == null) result = caseNamed(tableMember);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.NAMED: {
                Named named = (Named)theEObject;
                T result = caseNamed(named);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.TABLE_ATTRIBUTE: {
                TableAttribute tableAttribute = (TableAttribute)theEObject;
                T result = caseTableAttribute(tableAttribute);
                if (result == null) result = caseTableMember(tableAttribute);
                if (result == null) result = caseTableElement(tableAttribute);
                if (result == null) result = caseNamed(tableAttribute);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.TABLE_REFERENCE: {
                TableReference tableReference = (TableReference)theEObject;
                T result = caseTableReference(tableReference);
                if (result == null) result = caseTableMember(tableReference);
                if (result == null) result = caseTableElement(tableReference);
                if (result == null) result = caseNamed(tableReference);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.TABLE_CONTAINMENT: {
                TableContainment tableContainment = (TableContainment)theEObject;
                T result = caseTableContainment(tableContainment);
                if (result == null) result = caseTableMember(tableContainment);
                if (result == null) result = caseTableElement(tableContainment);
                if (result == null) result = caseNamed(tableContainment);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.SUB_TABLE: {
                SubTable subTable = (SubTable)theEObject;
                T result = caseSubTable(subTable);
                if (result == null) result = caseTable(subTable);
                if (result == null) result = caseTableElement(subTable);
                if (result == null) result = caseNamed(subTable);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.ROOT_TABLE: {
                RootTable rootTable = (RootTable)theEObject;
                T result = caseRootTable(rootTable);
                if (result == null) result = caseTable(rootTable);
                if (result == null) result = caseTableElement(rootTable);
                if (result == null) result = caseNamed(rootTable);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.REFERENCE_TABLE: {
                ReferenceTable referenceTable = (ReferenceTable)theEObject;
                T result = caseReferenceTable(referenceTable);
                if (result == null) result = caseTable(referenceTable);
                if (result == null) result = caseTableElement(referenceTable);
                if (result == null) result = caseNamed(referenceTable);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.FLOAT_ATTRIBUTE: {
                FloatAttribute floatAttribute = (FloatAttribute)theEObject;
                T result = caseFloatAttribute(floatAttribute);
                if (result == null) result = caseTableAttribute(floatAttribute);
                if (result == null) result = caseTableMember(floatAttribute);
                if (result == null) result = caseTableElement(floatAttribute);
                if (result == null) result = caseNamed(floatAttribute);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.BOOLEAN_ATTRIBUTE: {
                BooleanAttribute booleanAttribute = (BooleanAttribute)theEObject;
                T result = caseBooleanAttribute(booleanAttribute);
                if (result == null) result = caseTableAttribute(booleanAttribute);
                if (result == null) result = caseTableMember(booleanAttribute);
                if (result == null) result = caseTableElement(booleanAttribute);
                if (result == null) result = caseNamed(booleanAttribute);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.INT_ATTRIBUTE: {
                IntAttribute intAttribute = (IntAttribute)theEObject;
                T result = caseIntAttribute(intAttribute);
                if (result == null) result = caseTableAttribute(intAttribute);
                if (result == null) result = caseTableMember(intAttribute);
                if (result == null) result = caseTableElement(intAttribute);
                if (result == null) result = caseNamed(intAttribute);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.STRING_ATTRIBUTE: {
                StringAttribute stringAttribute = (StringAttribute)theEObject;
                T result = caseStringAttribute(stringAttribute);
                if (result == null) result = caseTableAttribute(stringAttribute);
                if (result == null) result = caseTableMember(stringAttribute);
                if (result == null) result = caseTableElement(stringAttribute);
                if (result == null) result = caseNamed(stringAttribute);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            case TablePackage.DATE_ATTRIBUTE: {
                DateAttribute dateAttribute = (DateAttribute)theEObject;
                T result = caseDateAttribute(dateAttribute);
                if (result == null) result = caseTableAttribute(dateAttribute);
                if (result == null) result = caseTableMember(dateAttribute);
                if (result == null) result = caseTableElement(dateAttribute);
                if (result == null) result = caseNamed(dateAttribute);
                if (result == null) result = defaultCase(theEObject);
                return result;
            }
            default: return defaultCase(theEObject);
        }
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Element</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Element</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseTableElement(TableElement object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Table</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Table</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseTable(Table object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Member</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Member</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseTableMember(TableMember object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Named</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Named</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseNamed(Named object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Attribute</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Attribute</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseTableAttribute(TableAttribute object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Reference</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Reference</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseTableReference(TableReference object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Containment</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Containment</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseTableContainment(TableContainment object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Sub Table</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Sub Table</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseSubTable(SubTable object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Root Table</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Root Table</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseRootTable(RootTable object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Reference Table</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Reference Table</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseReferenceTable(ReferenceTable object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Float Attribute</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Float Attribute</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseFloatAttribute(FloatAttribute object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Boolean Attribute</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Boolean Attribute</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseBooleanAttribute(BooleanAttribute object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Int Attribute</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Int Attribute</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseIntAttribute(IntAttribute object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>String Attribute</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>String Attribute</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseStringAttribute(StringAttribute object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>Date Attribute</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>Date Attribute</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
     * @generated
     */
    public T caseDateAttribute(DateAttribute object) {
        return null;
    }

    /**
     * Returns the result of interpreting the object as an instance of '<em>EObject</em>'.
     * <!-- begin-user-doc -->
     * This implementation returns null;
     * returning a non-null result will terminate the switch, but this is the last case anyway.
     * <!-- end-user-doc -->
     * @param object the target of the switch.
     * @return the result of interpreting the object as an instance of '<em>EObject</em>'.
     * @see #doSwitch(org.eclipse.emf.ecore.EObject)
     * @generated
     */
    @Override
    public T defaultCase(EObject object) {
        return null;
    }

} //TableSwitch
