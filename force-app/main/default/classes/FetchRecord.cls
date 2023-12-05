/*
Class Name : FetchRecord
Author     : persistent
Description : For populating dynamically and filtering records. 
*/
public with sharing class FetchRecord {
    @AuraEnabled(cacheable=true)
    public static  Map<String, Object> getRecords(Id parentRecordId,String fieldName1,String firstOperatorType, String fieldvalue1,String firstfilterOperator,String fieldName2,String secondOperatorType,String fieldvalue2,
                                                    String secondfilterOperator,String fieldName3,String thirdOperatorType,String fieldvalue3,
                                                    String object_Name,String field_Names,String parentRelationShipField,
                                                    String sortFieldName,String sortOperator){
        Map<String, Object> objColumnsMap = new  Map<String, Object>();
        Map<String, Map<String, Object>> columnsMap = new Map<String, Map<String, Object>>();
        String SOQLOperator;
        String SOQL2Operator;
        String SOQL3Operator;
        try{
            SOQLOperator = findOperatorType(firstOperatorType);
            SOQL2Operator = findOperatorType(secondOperatorType);
            SOQL3Operator = findOperatorType(thirdOperatorType);
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            if(object_Name == '--None--'){
                Contact cont = new Contact();
                return new map<String,Object>{'columns'=>'NOTHING','data'=>cont};  
            }
            Schema.SObjectType objSchema = schemaMap.get(object_Name);
            Map<String, Schema.SObjectField> fieldMap = objSchema.getDescribe().fields.getMap();
            String soqlQuery;
            Schema.SObjectField relationField;
            if(objSchema == null) {
                Contact cont1 = new Contact();
                return new map<String,Object>{'columns'=>'ObjectNotfound', 'data'=>cont1};
            }
            if(field_Names == null){
                System.debug('nothing to do');
            }
            else {
                
                for (String fieldName : field_Names.split(',')) {
                    system.debug('fieldMap.get(fieldName)'+fieldMap.get(fieldName));
                    Map<String, Object> columnDetails = new Map<String, Object>{
                        'label' => fieldMap.get(fieldName).getDescribe().getLabel(),
                        'fieldName' => fieldMap.get(fieldName).getDescribe().getName(),
                        //'type' => String.valueOf( fieldMap.get(fieldName).getDescribe().getType()).toLowerCase(),
                        'type' => String.valueOf(fieldMap.get(fieldName).getDescribe().getType()),
                        'sortable'=>true
                    };
                    columnsMap.put(fieldName,columnDetails);
                }
                system.debug('columnsMap is : '+columnsMap);
            }
            //for finding field data types
            Schema.DisplayType firstFieldDataType = findingFieldDataType(fieldName1,object_Name);
            Schema.DisplayType secondFieldDataType = findingFieldDataType(fieldName2,object_Name);
            Schema.DisplayType thirdFieldDataType = findingFieldDataType(fieldName3,object_Name);
            //end 
                //For first field Values
                String firstFieldValues;
                String firstSearchFieldValues;
                if(string.isNotBlank(fieldvalue1)){
                    firstFieldValues = arrangeFieldValues(fieldvalue1,firstFieldDataType);
                }
                if(string.isNotBlank(fieldvalue1) && !fieldvalue1.contains('$')){
                    firstSearchFieldValues = arrangeSearchFieldValues(fieldvalue1,firstFieldDataType);
                } 
                //for second field Values to
                String secondFieldValues;
                string secondSearchFieldValues;
                if(string.isNotBlank(fieldvalue2) && !fieldvalue2.contains('%')){
                    secondFieldValues = arrangeFieldValues(fieldvalue2,secondFieldDataType);
                }
                if(string.isNotBlank(fieldvalue2) && !fieldvalue2.contains('$')){
                    secondSearchFieldValues = arrangeSearchFieldValues(fieldvalue2,secondFieldDataType);
                } 
                //for third field Values to
                String thirdFieldValues;
                string thirdSearchFieldValues;
                if(string.isNotBlank(fieldvalue3) && !fieldvalue3.contains('%')){
                    thirdFieldValues = arrangeFieldValues(fieldvalue3,thirdFieldDataType);
                }
                if(string.isNotBlank(fieldvalue3) && !fieldvalue3.contains('$')){
                    thirdSearchFieldValues = arrangeSearchFieldValues(fieldvalue3,thirdFieldDataType);
                } 
                String selectQuery = 'SELECT '+field_Names+' FROM '+object_Name;
                if(String.isNotBlank(fieldName1) || String.isNotBlank(fieldName2) || String.isNotBlank(fieldName3)){
                    if(parentRelationShipField!=null){
                        soqlQuery = selectQuery+' WHERE '+parentRelationShipField+' = \''+parentRecordId+'\'';
                    }
                    if(String.isNotBlank(fieldName1)){
                        if(firstOperatorType == 'Equals' || firstOperatorType == 'Not equal to' || firstOperatorType == 'Starts with' || 
                            firstOperatorType == 'Less than' || firstOperatorType == 'Greater than' || firstOperatorType == 'Less or equal' || firstOperatorType == 'Greater or equal'){
                            if(firstfilterOperator == 'AND'){
                                soqlQuery = soqlQuery+' AND '+fieldName1+' '+SOQLOperator+' '+firstFieldValues;
                            }
                            else {
                                soqlQuery = soqlQuery+' AND (('+fieldName1+' '+SOQLOperator+' '+firstFieldValues+')';
                            }                         
                        }
                        else if(String.isNotBlank(firstFieldValues) && firstFieldValues!=null && firstOperatorType.contains('Includes')){
                            if(firstfilterOperator == 'AND'){
                                soqlQuery = soqlQuery+' AND ('+fieldName1+' '+SOQLOperator+' ('+firstFieldValues+')'+')';
                            }
                            else
                            {
                                soqlQuery = soqlQuery+' AND (('+fieldName1+' '+SOQLOperator+' ('+firstFieldValues+')'+')';
                            }    
                        }
                        else if(String.isNotBlank(firstFieldValues) && firstFieldValues!=null && firstOperatorType.contains('Excludes')){
                            if(firstfilterOperator == 'AND'){
                                soqlQuery = soqlQuery+' AND ('+fieldName1+' '+SOQLOperator+' ('+firstFieldValues+')';
                            }
                            else {
                                soqlQuery = soqlQuery+' AND (('+fieldName1+' '+SOQLOperator+' ('+firstFieldValues+')';
                            }
                            soqlQuery = soqlQuery + ')';
                        }else if(String.isNotBlank(firstSearchFieldValues) && firstOperatorType.contains('Contains')){
                                Boolean firstSearch=true;
                                for(String searchValues : firstSearchFieldValues.split(',')){
                                    if(firstSearch){
                                        if(String.isBlank(firstFieldValues) || searchValues.contains('%'))    {
                                            if(firstfilterOperator == 'AND'){
                                                soqlQuery = soqlQuery + ' AND ('+fieldName1+' Like '+ searchValues;
                                            }
                                            else {
                                                soqlQuery = soqlQuery + ' AND (('+fieldName1+' Like '+ searchValues;
                                            }
                                        }else {
                                            soqlQuery = soqlQuery + ' OR ('+fieldName1+' Like '+ searchValues;
                                        }   
                                    }
                                    else {
                                        soqlQuery = soqlQuery +' OR '+fieldName1+' Like '+ searchValues;
                                    }
                                    firstSearch=false; 
                                }
                                //soqlQuery = soqlQuery + ')';
                                String fildvalue =  String.isNotBlank(firstFieldValues) ? ')' :'';
                                soqlQuery = soqlQuery+fildvalue;
                        }else if(String.isNotBlank(firstSearchFieldValues) && firstOperatorType.contains('Does not contain')){
                            Boolean firstSearch=true;
                            List<String> strSize = firstSearchFieldValues.split(',');
                            Integer strlength = strSize.size();
                            if(strlength <=1){
                                soqlQuery = soqlQuery + ' AND (NOT '+fieldName1+' Like '+ firstSearchFieldValues;
                            }
                            else {
                                for(String searchValues : firstSearchFieldValues.split(',')){
                                    if(firstSearch){
                                        if(firstfilterOperator == 'OR'){
                                            soqlQuery = soqlQuery + ' AND (((NOT '+fieldName1+' Like '+ searchValues+')';
                                        }
                                        else {
                                            soqlQuery = soqlQuery + ' AND ((NOT '+fieldName1+' Like '+ searchValues+')';
                                        }
                                    }
                                    else {
                                        soqlQuery = soqlQuery + ' AND (NOT '+fieldName1+' Like '+ searchValues+')';
                                    }
                                    firstSearch=false; 
                                }
                            }
                                String fildvalue =  String.isNotBlank(firstFieldValues) ? ')' :'';
                                soqlQuery = soqlQuery+fildvalue;
                        }
                    }
                    //second filter
                    if(String.isNotBlank(fieldName2) && String.isNotBlank(fieldvalue2)){
                        if((String.isNotBlank(secondFieldValues) || string.isNotBlank(secondSearchFieldValues)) && String.isNotBlank(fieldName1)){
                            if(secondfilterOperator == 'OR' && firstfilterOperator == 'AND'){
                                soqlQuery = soqlQuery+' '+firstfilterOperator+' ((';
                            }
                            else {
                                soqlQuery = soqlQuery+' '+firstfilterOperator+' (';
                            }
                        }
                        if(secondOperatorType == 'Equals' || secondOperatorType == 'Not equal to' || secondOperatorType == 'Starts with' || 
                        secondOperatorType == 'Less than' || secondOperatorType == 'Greater than' || secondOperatorType == 'Less or equal' || secondOperatorType == 'Greater or equal'){
                                soqlQuery = soqlQuery+ fieldName2 +' '+SOQL2Operator+' '+secondFieldValues+')'; 
                        }
                        else if(String.isNotBlank(secondFieldValues) && secondFieldValues!=null && secondOperatorType.contains('Includes')){
                            soqlQuery = soqlQuery+fieldName2+' '+SOQL2Operator+' ('+secondFieldValues+')'+')';
                        }
                        else if(String.isNotBlank(secondFieldValues) && secondFieldValues!=null && secondOperatorType.contains('Excludes')){
                        soqlQuery = soqlQuery+fieldName2+' '+SOQL2Operator+' ('+secondFieldValues+')'+')';
                        }
                        else if(string.isNotBlank(secondSearchFieldValues)  && secondOperatorType.contains('Contains')){
                            Boolean secondSearch=true;
                            for(String searchValues : secondSearchFieldValues.split(',')){
                                if(secondSearch){
                                    if(String.isBlank(secondFieldValues) || searchValues.contains('%')){
                                        soqlQuery = soqlQuery + fieldName2+' Like '+ searchValues;
                                    }
                                    else {
                                        soqlQuery = soqlQuery + ' OR ('+fieldName2+' Like '+ searchValues;
                                    }      
                                }
                                else {
                                    soqlQuery = soqlQuery + ' OR '+fieldName2+' Like '+ searchValues;
                                }
                                secondSearch=false;
                            }
                            String fildvalue =  String.isBlank(secondFieldValues) ? ')' :'';
                            soqlQuery = soqlQuery+fildvalue;
                        }else if(String.isNotBlank(secondSearchFieldValues) && secondOperatorType.contains('Does not contain')){
                            Boolean firstSarch=true;
                                for(String searchValues : secondSearchFieldValues.split(',')){
                                    if(firstSarch){
                                        if(String.isBlank(secondFieldValues) || searchValues.contains('%')){
                                            soqlQuery = soqlQuery + '(NOT '+fieldName2+' Like '+ searchValues+')';
                                        }else {
                                            soqlQuery = soqlQuery + ' OR (NOT '+fieldName2+' Like '+ searchValues;
                                        }   
                                    }else {
                                        soqlQuery = soqlQuery +' AND (NOT '+fieldName2+' Like '+ searchValues+')';
                                    }
                                    firstSarch=false; 
                                }
                                soqlQuery = soqlQuery + ')';
                                String fildvalue =  String.isNotBlank(secondFieldValues) ? ')' :'';
                                soqlQuery = soqlQuery+fildvalue;
                        }
                    }
                    if(firstfilterOperator == 'OR' && secondfilterOperator == 'AND') {
                        soqlQuery = soqlQuery+')';
                    }
                    if(String.isNotBlank(fieldName3) && String.isNotBlank(fieldvalue3)){
                        if((String.isNotBlank(thirdFieldValues) || string.isNotBlank(thirdSearchFieldValues)) && String.isNotBlank(fieldName2)){
                            soqlQuery = soqlQuery+' '+secondfilterOperator +' (';
                        }
                        if(thirdOperatorType == 'Equals' || thirdOperatorType == 'Not equal to' || thirdOperatorType == 'Starts with' || 
                        thirdOperatorType == 'Less than' || thirdOperatorType == 'Greater than' || thirdOperatorType == 'Less or equal' || thirdOperatorType == 'Greater or equal'){
                            soqlQuery = soqlQuery+ fieldName3 +' '+SOQL3Operator+' '+thirdFieldValues+')';        
                        }
                        else if(String.isNotBlank(thirdFieldValues) && thirdFieldValues!=null && thirdOperatorType.contains('Includes')){
                            soqlQuery = soqlQuery+fieldName3+' '+SOQL3Operator+' ('+thirdFieldValues+')'+')';
                        }
                        else if(String.isNotBlank(thirdFieldValues) && thirdFieldValues!=null && thirdOperatorType.contains('Excludes')){
                        soqlQuery = soqlQuery+fieldName3+' '+SOQL3Operator+' ('+thirdFieldValues+')'+')';
                        }
                        else if(string.isNotBlank(thirdSearchFieldValues)  && thirdOperatorType.contains('Contains')){ 
                            Boolean secondSearch=true;
                            for(String searchValues : thirdSearchFieldValues.split(',')){
                                if(secondSearch){
                                    if(String.isBlank(thirdFieldValues) || searchValues.contains('%')){
                                        soqlQuery = soqlQuery + '('+fieldName3+' Like '+ searchValues;
                                    }
                                    else {
                                        soqlQuery = soqlQuery + ' OR ('+fieldName3+' Like '+ searchValues;
                                    }      
                                }
                                else {
                                    soqlQuery = soqlQuery + ' OR '+fieldName3+' Like '+ searchValues;
                                }
                                secondSearch=false;
                            }
                            soqlQuery = soqlQuery + ')';
                            String fildvalue =  String.isBlank(thirdFieldValues) ? ')' :'';
                            soqlQuery = soqlQuery+fildvalue;
                        }else if(String.isNotBlank(thirdSearchFieldValues) && thirdOperatorType.contains('Does not contain')){ 
                            Boolean firstSarch=true;
                                for(String searchValues : thirdSearchFieldValues.split(',')){
                                    if(firstSarch){
                                        if(String.isBlank(thirdFieldValues)  || searchValues.contains('%')){
                                            soqlQuery = soqlQuery + '(NOT '+fieldName3+' Like '+ searchValues+')';
                                        }else {
                                            soqlQuery = soqlQuery + ' OR (NOT '+fieldName3+' Like '+ searchValues;
                                        }   
                                    }else {
                                        soqlQuery = soqlQuery +' AND (NOT '+fieldName3+' Like '+ searchValues+')';
                                    }
                                    firstSarch=false; 
                                }
                                soqlQuery = soqlQuery + ')';
                                String fildvalue =  String.isNotBlank(thirdFieldValues) ? ')' :'';
                                soqlQuery = soqlQuery+fildvalue;
                        }
                    }
                    if(secondfilterOperator == 'OR' && firstfilterOperator == 'OR') {
                        soqlQuery = soqlQuery+')';
                    }else if(secondfilterOperator == 'OR') {
                        soqlQuery = soqlQuery+')';
                    }
                    soqlQuery = soqlQuery;//;+' LIMIT '+recordLimitVar;
            } 
            else {
                    if(parentRelationShipField!=null){
                        soqlQuery = selectQuery+' WHERE '+parentRelationShipField+' =\''+parentRecordId+'\'';
                    }else {
                        soqlQuery = selectQuery;
                    }        
            }
            if(String.isNotBlank(sortFieldName)){
                soqlQuery = soqlQuery+' ORDER BY '+sortFieldName + ' '+sortOperator;
            }
            else{
                soqlQuery = soqlQuery;
            }
            
            system.debug('soqlQuery is : '+soqlQuery);
                return new map<String,Object>{'columns'=>columnsMap.values(),'data'=>Database.query(soqlQuery)};
        }
        Catch(Exception e){
            Contact cont = new Contact();
            if((e.getMessage() == 'Attempt to de-reference a null object') && object_Name != '--None--' && String.isNotBlank(field_Names) &&
                                    ((String.isBlank(object_Name) || String.isEmpty(object_Name) || String.isNotBlank(object_Name)))){
                return new map<String,Object>{'columns'=>'Errors'+e.getMessage(),'data'=>cont};
            }else if(e.getMessage().substring(0,14)=='No such column') {
                return new map<String,Object>{'columns'=>'NoSuchColumn'+e.getMessage(),'data'=>cont};
            }
            else if(e.getMessage().substring(0,25)=='unexpected token: \'<EOF>\''){
                return new map<String,Object>{'columns'=>'unexpectedtoken'+e.getMessage(),'data'=>cont};
            }else if(e.getMessage().contains('no viable alternative at character')){
                return new map<String,Object>{'columns'=>'no viable alternative at character'+e.getMessage(),'data'=>cont};
            }
            else {
                return new map<String,Object>{'columns'=>'NOTHING','data'=>cont};
            }
        }
    }
    //For finding data type 
    public static Schema.DisplayType findingFieldDataType(String fieldName, String object_Name){
        Schema.DisplayType firstFieldDataType;
        if(string.isnotBlank(fieldName) && string.isnotBlank(object_Name)){
            firstFieldDataType = Schema.getGlobalDescribe().get(object_Name).getDescribe().fields.getMap().get(fieldName).getDescribe().getType();
        }
        return firstFieldDataType;
    }
    
    //For finding operator type below function is used for 3 inputs 
    public static string  findOperatorType(String operatorType){
        String SOQLOperator;
        Switch on operatorType {
            when 'Not equal to'{
                SOQLOperator = '!=';
            }
            when 'Includes'{
                SOQLOperator = 'IN';
            }			
            when 'Excludes'{
                SOQLOperator='Not IN';
            }
            when 'Less than'{
                SOQLOperator = '<';
            }		
            when 'Greater than'{
                SOQLOperator = '>';
            }		
            when 'Less or equal'{
                SOQLoperator = '<=';
            }
            when 'Greater or equal'{
                SOQLOperator = '>=';
            }
            When else {
                SOQLOperator = '=';
            }
        }
        return SOQLOperator;
    }
    //For arranging field values.
    public static string arrangeFieldValues(String fieldvalue1,Schema.DisplayType firstFieldDataType){
        String firstFieldValues;
        if(fieldvalue1.contains('$')){
            firstFieldValues = '\''+UserInfo.getUserID()+'\'';
        }
        else {
            for(String str: fieldvalue1.split(',')){
                if(string.isBlank(firstFieldValues)){
                    if(string.valueOf(firstFieldDataType) == 'DOUBLE' || string.valueOf(firstFieldDataType) == 'Integer' || string.valueOf(firstFieldDataType) == 'DATETIME' || string.valueOf(firstFieldDataType) == 'DATE'|| fieldvalue1 == 'null'){
                        firstFieldValues=str;
                    }
                    else
                    {
                        firstFieldValues='\''+ str + '\'';
                    }
                }
                else {
                    if(string.valueOf(firstFieldDataType) == 'DOUBLE' || string.valueOf(firstFieldDataType) == 'Integer' || string.valueOf(firstFieldDataType) == 'DATETIME' || string.valueOf(firstFieldDataType) == 'DATE'){
                        firstFieldValues= str +','+firstFieldValues;    
                    }
                    else
                    {
                        firstFieldValues='\''+ str + '\''+','+firstFieldValues;
                    }
                }
            }
        }
        return firstFieldValues;
    }
    //For arranging field values.
    public static string arrangeSearchFieldValues(String fieldvalue1,Schema.DisplayType firstFieldDataType){
        String firstSearchFieldValues;
        for(String str: fieldvalue1.split(',')){
            if(str.contains('%')){
                if(string.isBlank(firstSearchFieldValues)){
                    if(string.valueOf(firstFieldDataType) == 'DOUBLE' || string.valueOf(firstFieldDataType) == 'Integer' || string.valueOf(firstFieldDataType) == 'DATETIME' || string.valueOf(firstFieldDataType) == 'DATE'){
                        firstSearchFieldValues = str;
                    }
                    else{
                        firstSearchFieldValues = '\''+ str + '\'';
                    }
                }
                else {
                    firstSearchFieldValues = '\''+ str + '\''+','+firstSearchFieldValues;
                }
            }
        }
        return firstSearchFieldValues;
    }
    //To check login user privileges for create and delete records. 
    @AuraEnabled(cacheable=true)
    public static  Map<String,Boolean> getLoginUserPrivileges(String sObjectName){
        Map<String,Boolean> findCreateDeletePermissionMap = new map<String,Boolean>();
        for(ObjectPermissions pbjPermission : [SELECT PermissionsRead, PermissionsCreate,PermissionsDelete FROM ObjectPermissions WHERE ParentId in (
                                               SELECT PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId =: UserInfo.getUserId()) 
                                               AND SobjectType=:sObjectName]){
            if(pbjPermission.PermissionsCreate){
                findCreateDeletePermissionMap.put('createPrivilege',true);
            }
            if(pbjPermission.PermissionsDelete){
                findCreateDeletePermissionMap.put('deletePrivilege',true);
            }
            //usrPriv = new UserPrivileges(pbjPermission.PermissionsCreate,pbjPermission.PermissionsDelete);
        }
        return findCreateDeletePermissionMap;
    }

   
    //For deleting record 
    @AuraEnabled
    public static String deleteSelectedRecord(list<Id> Idset){
        string returnMsg;
        String inpStr = String.valueOf(Idset);
        String inpStr1 =  inpStr.substring(1,inpStr.length()-1);
        Integer i = 1;
        Id IdStr;
        string FirstIdValue;
        for(String ids : inpStr1.split(',')){
            if(i==1){
                IdStr = ids;
                i=i+1;
            }
            if(string.isBlank(FirstIdValue)){
                FirstIdValue = '\''+ ids.trim() + '\'';
            }
            else {
                FirstIdValue = '\''+ ids.trim() + '\''+','+FirstIdValue;
            }
        }
        String firstId = String.valueOf(IdStr).substring(0,3);
        String objectName;
        Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe(); 
        for(Schema.SObjectType sObjtype : gd.values()){
            Schema.DescribeSObjectResult ObjResult = sObjtype.getDescribe();
            String prefix = ObjResult.getKeyPrefix();
            if(prefix!=null && prefix.equals(firstId)){
                objectName = ObjResult.getName();
                break;
            }
        }
            string soqlQuery = 'SELECT Id FROM '+objectName+' WHERE ID IN ('+FirstIdValue+')';
            List<sObject> sobjList = Database.query(soqlQuery);
            if(!sobjList.isEmpty()){
                database.delete(sobjList);
                returnMsg = 'Success';
            }
            return returnMsg;
    }
    //For populating object relation
    @AuraEnabled(cacheable=true)
    public static String getObjectRelationShipField(String parentObjectApiName,String ChildObjectApiName){
        string objectrelationApi;
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType parentobjectName=schemaMap.get(parentObjectApiName);
        Schema.DescribeSObjectResult objDescribe=parentobjectName.getdescribe();
        for(Schema.ChildRelationship cr: objDescribe.getChildRelationships()){
            if(String.valueOf(cr.getChildSObject()) == childObjectApiName){
                objectrelationApi = string.valueOf(cr.getRelationshipName());
                break;
            }
        }
        return objectrelationApi;
    }
}