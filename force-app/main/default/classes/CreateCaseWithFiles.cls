public class CreateCaseWithFiles {

    public class RelatedFile {
        public string pathOnClient;
        public string title;
        public Blob versionData;
    }

    public class Casewrapper{
        @AuraEnabled
        public string accountId{get;set;}

        @AuraEnabled
        public string requestType{get;set;}

        @AuraEnabled
        public string accountType{get;set;}

        @AuraEnabled
        public string fundingType{get;set;}

        @AuraEnabled
        public Decimal fundingAmount{get;set;}

        @AuraEnabled
        public string priority{get;set;}

        @AuraEnabled
        public string additionalDetails{get;set;}

        @AuraEnabled
        public string fromAccount{get;set;}

        @AuraEnabled
        public string toAccount{get;set;}
        
        @AuraEnabled
        public Decimal transferAmount{get;set;}
        
    }

    @AuraEnabled
    public static String createCase(String caseDetails,List<Map<String, Object>> files){
        Boolean isSuccess = false;
        List<ContentVersion> relatedDocuments = new List<ContentVersion>();
        Case caseObj;
        
        User clientUser = getClientUser();
        
        Casewrapper caseDetailsToInsert=(Casewrapper)System.JSON.deserialize(caseDetails,Casewrapper.class);
        if(caseDetails!=null){
            caseObj = insertCase(caseDetailsToInsert,clientUser.Id);
        }

        for (Map<String, Object> file : files) {
            String fileJson = JSON.serialize(file);
            relatedFile relatedDocument = (relatedFile) JSON.deserialize(fileJson, relatedFile.class);
            ContentVersion contentVersionFile = new ContentVersion();
            ContentVersion cvInserted = createContentVersion(relatedDocument.VersionData,relatedDocument.Title,relatedDocument.PathOnClient);
            ContentDocumentLink contentDocLinkInserted = createContentDocumentLink(cvInserted.Id,caseObj.Id);
            if(cvInserted==null || contentDocLinkInserted==null ){
                return null;
            }
        }
        String caseNumbmer = [SELECT CaseNumber FROM Case WHERE Id =:caseObj.Id].CaseNumber;
        return caseNumbmer;
    }

    //for creating contentdocumentlink
    public static ContentDocumentLink createContentDocumentLink(String contentVersionId, String parentRecordId){
        ContentDocumentLink cdlink = New ContentDocumentLink();
        Id conDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId].ContentDocumentId;
        try{
            cdlink.LinkedEntityId = parentRecordId;
            cdlink.ContentDocumentId = conDocId;
            cdlink.shareType = 'V';
            Insert cdlink;
            return cdlink;
        }catch(DMLException e){
            system.debug('exception message'+e.getMessage());
            return null;
        }
    }

    //for creating contentversion
    public static ContentVersion createContentVersion(Blob versionData,String fileName,String pathOnClient){
        ContentVersion contVersion = new ContentVersion();
        try{
            contVersion.Title= fileName;
            contVersion.versionData = versionData;
            contVersion.pathOnClient = PathOnClient;
            insert contVersion;
            return contVersion;
        }catch(DMLException e){
            System.debug('exception message'+e.getMessage());
            return null;
        }
    }
    //used for creating case
    public static case insertCase(Casewrapper caseDetailsToInsert,Id userId){
        Case caseObj = new Case();
        caseObj.AccountId = caseDetailsToInsert.AccountId;
        caseObj.Request_Type__c=caseDetailsToInsert.requestType;
        caseObj.Account_Type__c = caseDetailsToInsert.accountType;
        caseObj.Funding_Type__c = caseDetailsToInsert.fundingType;
        caseObj.Funding_Amount__c =caseDetailsToInsert.fundingAmount;
        caseObj.Priority=caseDetailsToInsert.priority;
        caseObj.Additional_Details__c = caseDetailsToInsert.additionalDetails;
        caseObj.From_Account__c = caseDetailsToInsert.fromAccount;
        caseObj.To_Account__c = caseDetailsToInsert.toAccount;
        caseObj.Transfer_Amount__c = caseDetailsToInsert.transferAmount;
        caseObj.OwnerId=userId;
        insert caseObj; 

        return caseObj;

    }

    //used to fetch client user details
    public static User getClientUser(){
        User userDetails=[SELECT Id FROM User WHERE Id='0050I000009eowrQAA']; //here we case use custom label
        return userDetails;
    }
}