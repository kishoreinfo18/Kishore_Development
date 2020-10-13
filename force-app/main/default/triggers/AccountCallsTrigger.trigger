trigger AccountCallsTrigger on Account_Call__c (before insert,after insert,before delete,after delete,before update,after Update)
{
  if(trigger.isBefore || trigger.isUpdate)
  {
   AccountCallHandler.restrictAccCallBeforeUpdateDelete(Trigger.new, Trigger.isUpdate, Trigger.isDelete);
  }
  if(trigger.isBefore || trigger.isDelete)
  {
   AccountCallHandler.restrictAccCallBeforeUpdateDelete(Trigger.new, Trigger.isUpdate, Trigger.isDelete);
  }
}