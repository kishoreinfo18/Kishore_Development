trigger EmailAfterInsertUpdateDelete on Email__c (after delete, after insert, after update) {
    
    EmailHelper emailHelper = new  EmailHelper();
    if (Trigger.isDelete) {
    EmailHelper.updateParticipantEmail(trigger.old);
    }
    else {
    EmailHelper.resolvePrimaryConflicts(trigger.new);
    //EmailHelper.updateParticipantEmail(trigger.new);
    }
}