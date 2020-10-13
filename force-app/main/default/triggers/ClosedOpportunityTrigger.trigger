trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> tsklst = new List<Task>();
    for(opportunity oppr : trigger.new){
        if(oppr.StageName == 'Closed Won'){
            tsklst.add(new task(WhatId = oppr.Id, Subject = 'Follow Up Test Task'));
        }
    }
    if(!tsklst.isEMpty()){
        database.insert(tsklst);
    }

}