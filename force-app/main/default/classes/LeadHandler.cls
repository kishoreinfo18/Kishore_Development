public Class LeadHandler
{
 public static void ChkDuplicateEmail(List<lead> lstLead)
 {
  set<String> setLId=new set<String>();
  map<Id,set<String>> mapLead=new Map<Id,set<string>>();
  for(Lead lId:lstLead)
  {
   setlId.add(lId.Email);
  }
  List<Lead> leadEmailId=[select Id from lead where email in:setlId];
   for (Lead mapId:leadEmailId)
   {
    system.debug(mapId.Id); 
      if(mapLead.get(mapId.Id).size()>0)
      {
       mapId.addError('Email already exist to another Lead');
      }
   }
 }
}