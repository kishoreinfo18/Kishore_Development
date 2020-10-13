public class CreateInvoiceQuickActionVF {
    public Id Id { get; set; }
    public Opportunity Oppor { get; set; }
    //constructor to get the Opportunity record
    public CreateInvoiceQuickActionVF(ApexPages.StandardController controller) {
    Oppor =  (Opportunity)controller.getRecord();
    Id = Oppor.Id;
    System.debug('The case record: ' + Oppor);
    }
    //Method that can is called from the Visual Force page action attribute
   /* public PageReference createInvoice() {
        System.debug('Case Id: ' + Id);
        //build your code logic here
       PageReference pageRef = new PageReference('/'+Id);
       Invoice__c inv = new Invoice__c(OpportunityInvoice__c = Id);
       insert inv;
       OpportunityLineItem oppLineItem = [select Id,OpportunityId,TotalPrice from OpportunityLineItem where  OpportunityId=:Id];
       invoiceItems__c inItem = new invoiceItems__c(Invoices__c = inv.id,TotalPrice__c = oppLineItem.TotalPrice); 
        insert inItem;
       system.debug('pageRef is:'+pageRef);
        pageRef.setRedirect(true);
       return pageRef; //Returns to the case page
    }*/
}