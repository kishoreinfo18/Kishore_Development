global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful
{    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id,Name,LeadSource FROM Lead');
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        List<lead> ldsLstObj = new List<Lead>();
        for(Lead ldsObj : scope){
            ldsObj.LeadSource = 'Dreamforce';
            ldsLstObj.add(ldsObj);
        }
        database.update(ldsLstObj);
    }
    global void finish(Database.BatchableContext bc){
    }
    
}