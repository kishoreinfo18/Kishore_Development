trigger trgonAccount on Account (After insert,before update,after update) {
    if(trigger.isInsert || trigger.isUpdate)
    {
        AccountHandler.updateExample(trigger.old,trigger.new,trigger.oldMap,trigger.newMap);
    }

/*If (trigger.isInsert || trigger.isUpdate)
 {
 AccountHandler.populateSalesRepName(trigger.new);
 }
 if(trigger.isInsert || trigger.isUpdate)
 {
  AccountHandler.DuplicateAccountNameChk(trigger.New);
 }
 if(trigger.isInsert || trigger.isUpdate)
 {
 AccountHandler.AddRelatedRecords(trigger.new);
 }*/
    /* if(trigger.IsUpdate && trigger.isAfter)
     {
      AccountHandler.updateAccntContactDescription(trigger.new);
     }
     if(trigger.isUpdate && trigger.isBefore)
     {
     accountHandler.updateRelatedContactAddress(trigger.new,trigger.newMap,trigger.oldMap,trigger.isUpdate);
     }*/
    /* if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
     {
         AccountHandler.populateAccountRating(trigger.new,trigger.oldMap);
     }
     if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
     {
      AccountHandler.populateproductp1p2p3(trigger.new,trigger.newMap);
     }*/
 }