Public class AccountCallHandler
{
    public static void restrictAccCallBeforeUpdateDelete(list<Account_call__c> laccntcall,boolean isUpdate,boolean isDelete)
    {
        Id adminProfileId = [select id,name from profile where name=:'System Administrator'].id;
        id modifieduserId=userInfo.getProfileId();
        for(Account_call__c acccall:laccntCall)
            {
                if((isUpdate) && adminProfileId !=modifiedUserId && (acccall.status__c=='Submitted' || acccall.status__c=='Appointed' || (acccall.SAP_EXTRACT_FLAG__c)))
                {
                acccall.addError('You are nor allowed to modify the account call');
                }
                if((isDelete) && adminProfileId !=modifiedUserId && (acccall.status__c=='Submitted' || acccall.status__c=='Appointed'|| (acccall.SAP_EXTRACT_FLAG__c)))
                {
                acccall.addError('You are nor allowed to Delete the account call');
                }
            }        
    } 
}