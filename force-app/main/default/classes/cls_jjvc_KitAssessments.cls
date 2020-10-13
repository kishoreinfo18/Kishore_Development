public Class cls_jjvc_KitAssessments{
public String kitsType{get;set;}
public string theValue { get; set; }
public Id userid{get;set;}
public Account acc{get;set;}
public List<Kit_Assessment__c> kitsAssesmentList { get; set; } 
    public cls_jjvc_KitAssessments(ApexPages.StandardController controller)
    {
    system.debug('theValue' + theValue);
    kitsType='JJVC';
    acc=(Account) controller.getRecord();
    userid=userInfo.getUserId();
    }
    
    public void getAssessmentKits(){
        if(String.isnotBlank(kitsType)){
         kitsAssesmentList= [
                    SELECT Id, Name, Account__c, Assessed_By__c, Assessed_By__r.Alias, Assessed_Date__c, Product__r.IsActive, Has_Kit__c, Needs_Kit__c, KitOrder__c, Product__r.name, Type__c, Vendor_From_Product__c, Shipped_Date__c
                    FROM Kit_Assessment__c
                    WHERE Account__c = :acc.Id AND Vendor_From_Product__c = :kitsType AND Product__r.IsActive = true
                    order by KitOrder__c asc
            ];
        }
    }
}