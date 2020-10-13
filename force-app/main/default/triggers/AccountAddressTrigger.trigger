trigger AccountAddressTrigger on Account (before Insert,before update) {
    system.debug('before 1insert on triggr'+trigger.new+' trigger old os '+trigger.old);
   for(Account a : Trigger.new){
        If (a.Match_Billing_Address__c == true && a.BillingPostalCode!=Null) {
            a.ShippingPostalCode = a.BillingPostalCode;
        }   
    }   
}