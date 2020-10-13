@RestResource (urlMapping='/xero/webhook')
global class XeroWebhook {
    @HttpPost
    global static void processIntentToReceive () {
        system.debug('kishore reddy');
        // Retrieve the Xero signature from the headers
        String xeroSignature = RestContext.request.headers.get('x-xero-signature');

        // Retrieve the Xero payload body
        String xeroPayload = RestContext.request.requestBody.toString();
        system.debug('kishore reddy xeroPayload '+xeroPayload);

        // Verify the signature using 'hmacSHA256'. I have the Webhook key stored in a Custom Setting
        //Blob signedPayload = Crypto.generateMac('hmacSHA256', Blob.valueOf(xeroPayload), Blob.valueOf(Xero_Config__c.getInstance().Webhook_Key__c));
        Blob signedPayload = Crypto.generateMac('hmacSHA256', Blob.valueOf(xeroPayload), Blob.valueOf('fL39BRv2bkgpO/omLBYT7mYcKtUQ6i1vvKOxc4b3Rztf6eGgI1kuDYPRf4NtUyW56q1woWD+zD3KmOWrjFmUUQ=='));
       

        // Once we have the signed payload, encode it using base64 to convert back to a string
        String encodedPayload = EncodingUtil.base64Encode(signedPayload);

        // Return status code based on whether signed payload matches or not
        RestContext.response.statusCode = encodedPayload == xeroSignature ? 200 : 401;
        if(RestContext.response.statusCode == 200){
            getXeroInvoices(xeroPayload);
        } 
        
    }
    public static void getXeroInvoices(String xeroPayload){
         system.debug('xeroPayload is:'+xeroPayload);
         EventObjects evObj = new EventObjects();
         
         //SL_EnrollmentObjects.Patient patientObj = (SL_EnrollmentObjects.Patient) System.JSON.deserialize(jsonString,SL_EnrollmentObjects.Patient.class); 
         EventObjects eventsData = (EventObjects)JSON.deserialize(xeroPayload,EventObjects.class);
         system.debug('eventsData is:'+eventsData);
         
         String resourceId;
         String tenantId;
         String eventType;
         Map<String,Invoice__c> invoicExterMap = new Map<String,Invoice__c>();
         for(EventObjects.Events eventObj : eventsData.events){
             system.debug('eventObj  is:'+eventObj );
             resourceId = eventObj.resourceId;
             tenantId = eventObj.tenantId;
             eventType = eventObj.eventType;
         }
         system.debug('resourceId is:'+resourceId);
         
         HttpRequest req = new HttpRequest();
         string endPoint = 'callout:XeroSalesforceNamed/api.xro/2.0/Invoices/'+resourceId;
         req.setEndpoint(endPoint);
         req.setMethod('GET');
         //req.setHeader('xero-tenant-id','1a4b8714-534e-4ad2-b676-b5708e5ca4fd');
         req.setHeader('xero-tenant-id',tenantId);
         Http http = new Http();
         HTTPResponse res = http.send(req);
         System.debug(res.getBody());
         //05ee5ea8-14fc-4152-89ac-1af0a66f1d77
         
         Invoice__c inv = new Invoice__c();
         JSON2Invoice invoiceRes = (JSON2Invoice)JSON.deserialize(res.getBody(),JSON2Invoice.class);
         system.debug('invoiceRes  is :'+invoiceRes );
         
         for(Invoice__c invObj : [SELECT Id,Name,AmountDue__c,InvoiceNumber__c,ExternalId__c,Total__c from Invoice__c where ExternalId__c =: resourceId]){
             invoicExterMap.put(invObj.ExternalId__c ,invObj);
         }
         
         
         // Invoice Contacts 
         String ContactExternalId; 
         for(JSON2Invoice.Invoices invSObj : invoiceRes.Invoices){
             ContactExternalId = invSObj.Contact.ContactID;    
         } 
         //End
         
         system.debug('invoicExterMap :'+invoicExterMap);
         
         //Invoice item logic
         List<invoiceItems__c> invItemLst = new List<invoiceItems__c>();
         List<invoiceItems__c> invItemUpdLst = new List<invoiceItems__c>();
         map<String,invoiceItems__c> invoiceExternIdmap = new map<String,invoiceItems__c>();
         for(invoiceItems__c itemObj : [Select Id,InvItemExternalId__c from invoiceItems__c]){
             invoiceExternIdmap.put(itemObj.InvItemExternalId__c,itemObj);
         }
         //End
        
         //Xero Account Logic
         Map<String,String> xeroexternalIdMap = new Map<string,String>();
         Map<String,Contact> xeroexternalContactIdMap = new Map<string,Contact>();
         for(Contact contSObj : [select id,XeroContactExternalId__c,AccountId,Account.XeroAccntExternalId__c From Contact where XeroContactExternalId__c = : ContactExternalId]){
             xeroexternalIdMap.put(contSObj.Account.XeroAccntExternalId__c,contSObj.AccountId);
             xeroexternalContactIdMap.put(contSObj.XeroContactExternalId__c,contSObj);
         }
         //End
         
         
         Account acct = new Account();
         Contact cont = new Contact();
         for(JSON2Invoice.Invoices invSObj : invoiceRes.Invoices){
             
             ContactExternalId = invSObj.Contact.ContactID;
             if(!xeroexternalContactIdMap.containsKey(invSObj.Contact.ContactID)){
                 acct.Name=invSObj.Contact.Name;
                 insert acct;
                 
                 cont.LastName = invSObj.Contact.Name;
                 cont.AccountId=acct.Id;
                 cont.AccountName__c = acct.Id;
                 cont.XeroContactExternalId__c = invSObj.Contact.ContactID;
                 
                 insert cont;
             }
             system.debug(invSObj.Contact.Name);
             system.debug('invSObj.LineItems :'+invSObj.LineItems);
             
             if(invoicExterMap.containskey(invSObj.InvoiceID)){
                 inv.Id = invoicExterMap.get(invSObj.InvoiceID).Id;
                 inv.AmountDue__c = invSObj.AmountDue;
                 inv.Total__c = invSObj.Total;
                 //inv.Quantity = invoicExterMap.get(invSObj.InvoiceID).Quantity;
                 update inv;
                 for(JSON2Invoice.LineItems invLineItemObj: invSObj.LineItems){
                     if(invoiceExternIdmap.containsKey(invLineItemObj.LineItemID)){
                         invItemUpdLst.add(new invoiceItems__c(Id=invoiceExternIdmap.get(invLineItemObj.LineItemID).Id,InvItemExternalId__c = invLineItemObj.LineItemID,Invoices__c = inv.Id,Name = invLineItemObj.ItemCode,TotalPrice__c = invLineItemObj.LineAmount,UnitAmount__c = invLineItemObj.UnitAmount));
                     }
                     else
                     {
                         invItemLst.add(new invoiceItems__c(Invoices__c = inv.Id,Name = invLineItemObj.ItemCode,InvItemExternalId__c = invLineItemObj.LineItemID,TotalPrice__c = invLineItemObj.LineAmount,UnitAmount__c = invLineItemObj.UnitAmount)); 
                     }
                 }
             }
             else
             {
                 
                 inv.AmountDue__c = invSObj.AmountDue;
                 //inv.Quantity = invoicExterMap.get(invSObj.InvoiceID).Quantity__c;
                 inv.InvoiceNumber__c = invSObj.InvoiceNumber;
                 inv.ExternalId__c = invSObj.InvoiceID;
                 inv.Total__c = invSObj.Total;
                 inv.XeroAccountId__c = acct.Id;
                 inv.XeroContact__c = cont.Id;
                 insert inv;
                 for(JSON2Invoice.LineItems invLineItemObj: invSObj.LineItems){
                     if(invoiceExternIdmap.containsKey(invLineItemObj.LineItemID)){
                         invItemUpdLst.add(new invoiceItems__c(Id=invoiceExternIdmap.get(invLineItemObj.LineItemID).Id,InvItemExternalId__c = invLineItemObj.LineItemID,Invoices__c = inv.Id,Name = invLineItemObj.ItemCode,TotalPrice__c = invLineItemObj.LineAmount,UnitAmount__c = invLineItemObj.UnitAmount));
                     }
                     else
                     {
                         invItemLst.add(new invoiceItems__c(Invoices__c = inv.Id,InvItemExternalId__c = invLineItemObj.LineItemID,Name = invLineItemObj.ItemCode,TotalPrice__c = invLineItemObj.LineAmount,UnitAmount__c = invLineItemObj.UnitAmount)); 
                     }
                 }
             }       
         }
         if(!invItemLst.isEmpty()){
             database.insert(invItemLst);
         }
         if(!invItemUpdLst.isEmpty()){
             database.update(invItemUpdLst);
         }
         
    }
}