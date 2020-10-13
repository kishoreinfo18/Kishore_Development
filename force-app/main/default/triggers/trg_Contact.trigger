trigger trg_Contact on Contact (before insert,before Update,before delete,After Insert,After Update,After delete) {
 /*if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate || trigger.Isdelete))
 {
 }
 if(trigger.isAfter && trigger.isUpdate)
 {
  AffiliatedAccount_hlpr.resolveSelfAffiliatedAccount(
                null,
                (List<Contact>)Trigger.new);*/
  if(trigger.isBefore && trigger.isUpdate)
      {
  AffiliatedAccount_hlpr.encryptingContactName(trigger.new);
     }
 /*
 if(trigger.isAfter && trigger.isUpdate)
 {
   AffiliatedAccount_hlpr.resolveSelfAffiliatedAccount(Trigger.oldMap,trigger.new); 
 }*/
 
 /* If(trigger.isInsert)
  {
   ContactHandler.ContactDuplicateEmail(trigger.new);
  }
  If(trigger.isInsert || trigger.isUpdate) 
  {
   ContactHandler.newContactRelationshipRecord(trigger.new);
  }
  if(trigger.isdelete)
  {
   ContactHandler.newContactRelationshipRecord(trigger.old);
  }
  ContactHandler.RollupContactsOfAccount(trigger.new,trigger.old);
  if(trigger.isupdate || trigger.isBefore)
  {
  ContactHandler.AssignToDummyAccount(trigger.new,trigger.oldmap,true,true);
  }
  if((trigger.isUpdate && trigger.isBefore) || (trigger.isBefore && trigger.IsInsert))
  {
   ContactHandler.deleteInactiveConInAccntContactRole(trigger.new);
  } */
  
}