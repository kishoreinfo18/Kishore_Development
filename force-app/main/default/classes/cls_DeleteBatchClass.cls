global class cls_DeleteBatchClass implements Database.Batchable<sobject> {
    public string query;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return database.getQueryLocator(query);
    } 
    global void execute(Database.BatchableContext bc, list<sObject> scope)
    {
        delete scope;
    }
    global void finish(Database.BatchableContext bc)
    {
        
    }
}