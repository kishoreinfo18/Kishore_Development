import { LightningElement, track, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getRecords from '@salesforce/apex/FetchRecord.getRecords';
import getIconName from '@salesforce/apex/GetObjectIconDetails.getIconDetails';
import getLoginUserPrivileges from '@salesforce/apex/FetchRecord.getLoginUserPrivileges';
import deleteSelectedRecord from '@salesforce/apex/FetchRecord.deleteSelectedRecord';
import getObjectRelationShipField from '@salesforce/apex/FetchRecord.getObjectRelationShipField';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RelatedListHelper extends NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;
    @track dataLst;
    @track errorLst;
    @track viewAllVar;
    @api title = 'Enter the title';
    @api objectFields;
    @track objectColumns = [];

    @api maxRecords = '200';
    //For filters
    @api filter1fieldName;
    @api Filter1Value;
    @api filter2fieldName;
    @api filter2Value;
    @api filter3fieldName;
    @api filter3Value;
    @api firstOperatorType;
    @api secondOperatorType;
    @api thirdOperatorType;
    @api firstfilterOperator = 'AND';
    @api secondfilterOperator = 'AND';
    @api sortFieldName;
    @api sortOperator;


    @track sortBy;
    @track sortDirection;
    @track ButtonValue;

    objectName = '--None--';
    relationAPIFieldNames;
    parentFieldName;
    saveDraftValues = [];

    @track iconName;
    @track privilegeCreateObj = false;
    @track privilegeDeleteObj = false;
    @track hideDeleteButton;
    @track hideNewButton;
    parentAPIFied = '';
    objectType;
    selectedIdsArray = [];
    recordToDelete;


    // getter and setter for object lookup fields
    @api
    get hideOrUnhideDelete() {
        return this.hideDelete;
    }
    set hideOrUnhideDelete(value) {
        this.hideDeleteButton = value == 'Default' ? true : false;
    }

    @api
    get hideOrUnhideNew() {
        return this.hideNewButton;
    }
    set hideOrUnhideNew(value) {
        this.hideNewButton = value == 'Default' ? true : false;
    }

    @api
    get objectlookupField() {
        return this.objectRelationField;
    }
    set objectlookupField(value) {

        this.relationAPIFieldNames = value;

        const parentRelationobjLookupSplitVal = this.relationAPIFieldNames.split('  :  ');
        for (var k = 0; k < parentRelationobjLookupSplitVal.length; k++) {
            this.parentAPIFied = parentRelationobjLookupSplitVal[1];
        }

        const objectRelationField = value.toUpperCase();
        const objLookupSplitVal = objectRelationField.split('  :  ');
        for (var i = 0; i < objLookupSplitVal.length; i++) {
            this.objectName = objLookupSplitVal[0];
            this.parentFieldName = objLookupSplitVal[1];
        }
        const objectType = this.objectName.substr(this.objectName.length - 3);
    }


    connectedCallback() {
        getRecords({
            parentRecordId: this.recordId,
            fieldName1: this.filter1fieldName,
            firstOperatorType: this.firstOperatorType,
            fieldvalue1: this.Filter1Value,
            firstfilterOperator: this.firstfilterOperator,
            fieldName2: this.filter2fieldName,
            secondOperatorType: this.secondOperatorType,
            fieldvalue2: this.filter2Value,
            secondfilterOperator: this.secondfilterOperator,
            fieldName3: this.filter3fieldName,
            thirdOperatorType: this.thirdOperatorType,
            fieldvalue3: this.filter3Value,
            object_Name: this.objectName,
            field_Names: this.objectFields,
            parentRelationShipField: this.parentFieldName,
            sortFieldName: this.sortFieldName,
            sortOperator: this.sortOperator
        }).then(result => {
            if (JSON.stringify(result.columns).includes('Errors')) {
                throw new Error("Object API/Field API name is invalid");
            } else if (JSON.stringify(result.columns).includes('ObjectNotfound')) {
                throw new Error("Object API is invalid or object should not be null");
            } else if (JSON.stringify(result.columns).includes('NoSuchColumn') || (JSON.stringify(result.columns).includes('unexpectedtoken'))) {
                throw new Error("No such column exist in object");
            } else if (JSON.stringify(result.columns).includes('no viable alternative at character')) {
                throw new Error("% should not be used for integer. search values should be strings");
            } else if (JSON.stringify(result.columns).includes('NOTHING')) {
                //
            } else {
                this.dataLst = result.data;
                this.objectColumns = result.columns;
                console.log('tempAllRecords is££££:' + JSON.stringify(result.columns));
                let tempAllRecords = Object.assign([], result.columns);
                let tempfieldName2 = [];
                let tempfieldName;
                console.log('tempAllRecords is:' + result.columns.length);
                for (let j = 0; j < result.columns.length; j++) {
                    let tempRec = Object.assign({}, tempAllRecords[j]);
                    console.log('tempAllRecords is211213:' + JSON.stringify(tempRec.fieldName));
                    tempfieldName = JSON.stringify(tempRec.fieldName).replace(/"/g, '');
                    tempfieldName2.push(tempfieldName);
                    if (tempRec.type != 'CURRENCY') {
                        tempRec.label = tempRec.label,
                            tempRec.fieldName = 'recordLink',
                            //   tempRec.editable = true,
                            tempRec.type = 'url',
                            tempRec['typeAttributes'] = { label: { fieldName: tempfieldName }, target: '_blank', default: ' ' };
                    } else {
                        tempRec.label = tempRec.label,
                            tempRec.fieldName = tempfieldName,
                            tempRec.type = 'currency'
                    }
                    tempAllRecords[j] = tempRec;
                }
                this.objectColumns = tempAllRecords;
                if (result.data) {
                    var tempObjectLst = [];
                    let recordCount = 0;
                    for (var i = 0; i < result.data.length; i++) {
                        if (recordCount < this.maxRecords) {
                            recordCount = recordCount + 1;
                            var tempFieldsArray = [];
                            var objectFieldName = [];
                            let tempRecord = Object.assign({}, result.data[i]);
                            objectFieldName = Object.keys(tempRecord);
                            var missing = String(tempfieldName2.filter(e => !objectFieldName.includes(e)));
                            if (missing != null) {
                                var myarray = missing.split(',');
                                for (var a = 0; a < myarray.length; a++) {
                                    const splitElements = myarray[a];
                                    tempRecord[splitElements] = ' ';
                                }
                                tempRecord.recordLink = '/' + tempRecord.Id;
                            } else {
                                tempRecord.recordLink = '/' + tempRecord.Id;
                            }
                            tempObjectLst.push(tempRecord);
                        }
                    }
                    this.dataLst = tempObjectLst;
                    if (result.data.length > this.maxRecords) {
                        this.viewAllVar = true;
                    }
                }
                this.error = undefined;
            }
        })

        getIconName({
            sObjectName: this.objectName
        }).then(result => {
            this.iconName = JSON.parse(JSON.stringify(result.iconURL));
            alert('iconName is :' + this.iconName);
        })


        getLoginUserPrivileges({
                sObjectName: this.objectName
            }).then(result => {
                var privilegeMap = result;
                for (let key in privilegeMap) {
                    if (key == 'createPrivilege' && privilegeMap[key] == true && this.hideNewButton) {
                        this.privilegeCreateObj = true;
                    }
                    if (key == 'deletePrivilege' && privilegeMap[key] == true && this.hideDeleteButton) {
                        this.privilegeDeleteObj = true;
                    }
                }
            })
            .catch(error => {
                console.log('privilege data not exists');
            });

    }


    handleSortdata(event) {
        //field name
        this.sortBy = event.detail.fieldName;
        // sort direction
        this.sortDirection = event.detail.sortDirection;
        // call sortdata function
        this.sortData(event.detail.fieldName, event.detail.sortDirection);

    }

    //sort function    
    sortData(fieldname, direction) {
        // serialize the data before calling sort function
        let parseData = JSON.parse(JSON.stringify(this.dataLst));

        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };

        // cheking reverse direction 
        let isReverse = direction === 'asc' ? 1 : -1;

        // sorting data 
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';

            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });

        // set the sorted data to data table data
        this.dataLst = parseData;

    }
    handleDelete() {
        let datatoBeDelete = this.template.querySelector('lightning-datatable').getSelectedRows();
        let conIds = new Set();
        for (var i = 0; i < datatoBeDelete.length; i++) {
            conIds.add(datatoBeDelete[i].Id);
        }
        this.selectedIdsArray = Array.from(conIds);
        deleteSelectedRecord({
            Idset: this.selectedIdsArray
        }).then(result => {
            if (result == 'Success') {
                const event = new ShowToastEvent({
                    title: 'Record deleted',
                    message: 'Selected records has been deleted successfully.',
                    variant: 'success'
                });
                this.dispatchEvent(event);
            }
        })
        window.location.reload();
    }

    navigateToCreate() {
        let childObjectName;
        const objLookupSplitVal = this.relationAPIFieldNames.split('  :  ');

        for (var i = 0; i < objLookupSplitVal.length; i++) {
            childObjectName = objLookupSplitVal[0];
        }

        var urlPathArray = window.location.pathname.split('/');

        let defualtValues = '';
        defualtValues = this.parentAPIFied + '=' + urlPathArray[urlPathArray.length - 2];

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: childObjectName,
                actionName: 'new',
            },
            state: {
                defaultFieldValues: defualtValues
            }
        });
    }

    navigateRelatedListView() {
        const objName = this.objectName.toLowerCase();
        const objectApiNameVar = objName.charAt(0).toUpperCase() + objName.slice(1);
        const parentobjName = this.objectApiName.toLowerCase();
        const parentobjectApiName = parentobjName.charAt(0).toUpperCase() + parentobjName.slice(1);
        let relationShipFieldAPI;
        getObjectRelationShipField({
            parentObjectApiName: parentobjectApiName,
            ChildObjectApiName: objectApiNameVar
        }).then(result => {
            relationShipFieldAPI = result;
            if (result != null) {
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordRelationshipPage',
                    attributes: {
                        recordId: this.recordId,
                        objectApiName: this.objectApiName,
                        relationshipApiName: result,
                        actionName: 'view'
                    },
                });
            }
        });
    }
}