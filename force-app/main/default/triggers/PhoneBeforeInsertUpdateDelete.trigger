trigger PhoneBeforeInsertUpdateDelete on Phone__c(before Insert,before Delete,before Update) {
PhoneHelper PHelper=new PhoneHelper();
 if(Trigger.isDelete){
 PHelper.validateDeleteUser(Trigger.old);
    }
   else if(Trigger.isInsert){
   PHelper.validatePhoneformat(trigger.new);
 }
}