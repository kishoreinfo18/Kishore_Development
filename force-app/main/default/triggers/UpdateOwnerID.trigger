trigger UpdateOwnerID on Opportunity (before insert, before update) {
     Set<string> aliasscope = new Set<String>();
      for(opportunity opp : trigger.new)
      {
              aliasscope.add(opp.Account_Manager__c);
       }
    map<string,id> userIdbyAlias = new map<string,id>();  //Keep in mind this will only store one user id per alias
    for(User u : [Select id from user where Alias IN :aliasscope])
    {
            userIdbyAlias.put(u.Alias,u.Id);
     }
    for (Opportunity objOpportunity : Trigger.new)
    {
        if(userIdbyAlias.containskey(objOpportunity.Account_Manager__c))
        {

             if (objOpportunity.OwnerId <> userIdByAlias.get(objOpportunity.Account_Manager__c) )           
             {
                   objOpportunity.OwnerId = userIdByAlias.get(objOpportunity.Account_Manager__c);
              }
         }
    }

}