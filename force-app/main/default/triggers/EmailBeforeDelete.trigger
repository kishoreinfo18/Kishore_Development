trigger EmailBeforeDelete on Email__c (before delete) {
  EmailHelper EHelper = new EmailHelper();
  EHelper.validateDeleteUser(trigger.old);
}