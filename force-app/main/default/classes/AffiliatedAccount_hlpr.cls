public without Sharing class AffiliatedAccount_hlpr{
    public static void encryptingContactName(List<Contact> conLst)
    {
         Blob key = Crypto.generateAesKey(128);
         Blob exampleIv = Blob.valueOf('Example of IV123');
        for(contact cont:conLst)
        {
         Blob data = Blob.valueOf('cont.Name');
         Blob Lang = Blob.valueOf('cont.Languages__c');
        // Blob mphone = Blob.valueOf('cont.MobilePhone');
        Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);
        Blob encryptedLang = Crypto.encrypt('AES128', key, exampleIv, Lang);
      //  Blob encryptedMphone = Crypto.encrypt('AES128', key, exampleIv, mphone);
        String encryptedString = EncodingUtil.base64Encode(encrypted);
        String encrypLang = EncodingUtil.base64Encode(encryptedLang);
       // String encrypPhone = EncodingUtil.base64Encode(encryptedMphone);
         system.debug('encryptedString is ------->'+encryptedString);
         cont.Fax = encryptedString; 
         cont.Languages__c=encrypLang;
        // cont.MobilePhone= encrypPhone;  
        }
        
    }
   /* public static void resolveSelfAffiliatedAccount(Map<Id,Contact> pOldContact_map,List<Contact > pNewContact_List)
    {
    Boolean found = false;
    String key;
     Set<String>  keyToUpsert_set = new Set<String>(); 
     Set<String>  keyToDelete_set = new set<String>();
     List<Affiliated_Account__c> affAcctCurrent_list = new List<Affiliated_Account__c>();
     List<Affiliated_Account__c> affAcctToDelete_list    = new List<Affiliated_Account__c>();
     List<Affiliated_Account__c> affAcctToUpsert_list    = new List<Affiliated_Account__c>(); 
     for(Contact c_i:pNewContact_List)
     {
         if(c_i.AccountId!=null)
         {
              keyToUpsert_set.add(string.ValueOf(c_i.AccountId)+string.ValueOf(c_i.id));
              system.debug('Account and Contact values are : '+ keyToUpsert_set);
              system.debug('Account id values are :'+pOldContact_map.get(c_i.Id));
              system.debug('Account id values are 2:'+pOldContact_map.get(c_i.Id).AccountId);
         }
         if(pOldContact_map!=null && pOldContact_map.get(c_i.Id).AccountId!=null && pOldContact_map.get(c_i.Id).AccountId!=c_i.AccountId)
         {
           keyToDelete_set.add(String.valueOf(pOldContact_map.get(c_i.Id).AccountId)+String.valueOf(pOldContact_map.get(c_i.Id).Id));
         }
     }
     
     affAcctCurrent_list =[select Id,Key_On_Account_And_Contact__c
                            FROM
                            Affiliated_Account__c
                            WHERE
                            Key_On_Account_And_Contact__c IN :keyToUpsert_set];
                            
      affAcctToDelete_list = [SELECT
                                Id,
                                Key_On_Account_And_Contact__c
                                FROM
                                Affiliated_Account__c
                                WHERE Key_On_Account_And_Contact__c IN :keyToDelete_set];
        for(Contact c_i:pNewContact_list)
        {
        found = false;
            if(c_i.AccountId!=null)
            {
            key=string.valueOf(c_i.AccountId)+String.valueOf(c_i.Id);
                for(Affiliated_Account__c aa_i : affAcctCurrent_list)
                 {
                  if(key==aa_i.Key_On_Account_And_Contact__c)
                  {
                  found=true;
                  }
                 }
              if(!found)
              {
              affAcctToUpsert_list.add(new Affiliated_Account__c(Account__c=c_i.AccountId,
                                                            Contact__c=c_i.Id,
                                                            Key_On_Account_And_Contact__c=key));
              }   
            }
         }
          //If lists aren't empty, upsert/delete
        if(!affAcctToUpsert_list.isEmpty())
        {
            List<Database.Upsertresult> affAcctToUpsert_list_sr = Database.upsert(affAcctToUpsert_list, Affiliated_Account__c.Key_On_Account_And_Contact__c, false);
        }
    }
 public static void resolveSelfAffiliatedAccoun(Map<Id,Contact> pOldContact_map,Map<Id,Contact>  pNewContact_map)
 { 
   List<contact> newContactList=new list<Contact>();
   List<Contact> OldContactList=new List<Contact>();
   Contact OldContact;
   system.debug('New Contact values are:'+ pNewContact_map.values());     
 } */  
}