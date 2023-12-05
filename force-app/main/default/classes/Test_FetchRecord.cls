@isTest
public Class Test_FetchRecord {
    static testmethod void tst_GetRecords() {
        
        List<Contact> contLst = new List<Contact>();
        Map<String, Object> dataRecords = new Map<String,object>();
        //Create Account test record
        Account acc = new Account(AccountNumber='2345452',Name='TestAccount');
        insert acc;
        //Create contact test record
        Contact cont = new Contact(FirstName='testFname',LastName='testLName',Phone='9875332356',AccountId=acc.Id);
        contLst.add(cont);
        Contact cont1 = new Contact(FirstName='testFname1',LastName='testLName1',Phone='9875331356',AccountId=acc.Id);
        contLst.add(cont1);
        test.startTest();
        insert contLst;
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Equals','testFname','AND','phone','Not equal to','9875332356','OR','Lastname','Contains','testL%','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Not equal to','testFname','OR','phone','Equals','9875332356','OR','Lastname','Includes','testLName','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Contains','test%','OR','phone','Contains','98753323%','OR','Lastname','Does not contain','testLN%,testLNa%','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Contains','testFn%','OR','phone','Contains','9875332%','OR','Lastname','Not equal to','testLName1','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Contains','testFna%','OR','phone','Contains','9875332%,98753313%','OR','Lastname','Excludes','testLName','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Contains','testFn%','OR','phone','Includes','9875332356,9875331356','OR','Lastname','Excludes','testLName','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Contains','testFn%','OR','phone','Excludes','9875332356,9875331356','OR','Createddate','Less than','Today','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Includes','testFname,testFname1','OR','phone','Excludes','9875332356,9875331356','OR','Lastname','Excludes','testLName','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Excludes','testFname,testFname1','OR','phone','Equals','null','OR','Lastname','Equals','null','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'CreatedDate','Greater or equal','today','OR','phone','Excludes','null','OR','Lastname','Excludes','null','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Does not contain','testFname%','AND','Createddate','Less or equal','TODAY','OR','Lastname','Does not contain','null','--None--','FirstName,LastName,CreatedDate','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'Created','Less than','today','AND','lastmodifiedDate','Less than','TODAY','OR','CreatedDate','Greater than','today','contact','FirstName,LastName,CreatedDate','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'CreatedDate','Greater than','today','OR','phone','Excludes','null','OR','Lastname','Excludes','null','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'CreatedDate','Less or equal','today','OR','phone','Excludes','null','OR','Lastname','Excludes','null','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Contains','testFn%','OR','CreatedDate','Greater than','today','OR','Lastname','Excludes','null','Contact','FirstName,LastName','accountId','FirstName','ASC');
        dataRecords = FetchRecord.getRecords(acc.Id,'FirstName','Does not contain','testFname%,testF%','OR','Lastname','Does not contain','testLN%,testLNa%','OR','Lastname','Excludes','null','Contact','FirstName,LastName','accountId','FirstName','ASC');
        test.stopTest();
    }
    
    static testMethod void tst_getIconDetails(){
        String objectName = 'Contact';
        String customobjectname;
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            if(objTyp.getDescribe().isCustom()){
                customobjectname = objTyp.getDescribe().getName();
                break;
            }   
        }
        //for tabs
        String standardtabName; 
        String emptyTabName;
        List<Schema.DescribeTabResult> tabDesc = new List<Schema.DescribeTabResult>();
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        for(DescribeTabSetResult tsr : tabSetDesc) {
            tabDesc = tsr.getTabs();
        }
        for(Schema.DescribeTabResult tr : tabDesc) {
            if(tr.isCustom()){
                standardtabName = tr.getLabel();
                break;
            }
        }
        //for empty tab Icon
        for(Schema.DescribeTabResult tr : tabDesc) {
            if(tr.getIcons().isempty()){
                emptyTabName = tr.getLabel();
                break;
            }
        }
        
        //end
    
        Test.startTest();
        Map<String,String> iconNameMap = GetObjectIconDetails.getIconDetails(objectName);
        Map<String,String> iconNameMap1 = GetObjectIconDetails.getIconDetails(customobjectname);
        Map<String,String> iconNameMap2 = GetObjectIconDetails.getIconDetails(standardtabName);
        Map<String,String> iconNameMap3 = GetObjectIconDetails.getIconDetails(emptyTabName);
        Test.stopTest();
    }
    
    static testmethod void testReferenceFieldPicklistDefaultValue() {
        VisualEditor.DesignTimePageContext context = new VisualEditor.DesignTimePageContext();
        context.entityName = 'Contact';
        ReferenceFieldPickList refeLstclass = new ReferenceFieldPickList(context);
        Test.startTest();
         VisualEditor.DataRow defaultValue = refeLstclass.getDefaultValue();
        Test.stopTest();

    }  

    static testmethod void testReferenceFieldPicklistValues() {
        VisualEditor.DesignTimePageContext context = new VisualEditor.DesignTimePageContext();
        context.entityName = 'Contact';
        ReferenceFieldPickList refeLstclass = new ReferenceFieldPickList(context);
        Test.startTest();
        VisualEditor.DynamicPickListRows picklistValues = refeLstclass.getValues();
        Test.stopTest();
        System.assert(picklistValues.size() > 0, 'No parent picklist values found for Contact');
    }
    static testmethod void testgetObjectRelationShipField() {
        test.startTest();
        String pobjectName = 'Account';
        String cobjectName = 'Contact';
        String msg = FetchRecord.getObjectRelationShipField(pobjectName,cobjectName); 
        test.stopTest();
    }
    static testmethod void testgetLoginUserPrivileges() {
        String objectName = 'Contact';
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles',UserName=uniqueUserName);
        test.startTest();
        System.runAs(u) {
            Map<String,Boolean> usrPriv = FetchRecord.getLoginUserPrivileges(objectName);
        }   
        test.stopTest();        
    }
    static testmethod void testdeleteSelectedRecord() {
        Contact cont= new Contact(Firstname='Fname',Lastname='Lname');
        Contact cont1= new Contact(Firstname='Fnamecont',Lastname='Lnamecont');
        List<Contact> contLst = new List<Contact>();
        contLst.add(cont);
        contLst.add(cont1);
        insert contLst;
        List<Id> idsLst = new List<Id>();
        for(Contact contSObj : [SELECT Id FROM COntact]){
                idsLst.add(contSObj.id);
        }
        test.startTest();
        String returnMsg = FetchRecord.deleteSelectedRecord(idsLst);
        test.stopTest();
    }
}