Public class EmailHelper{    
public void validateDeleteUser(list<Email__c> emaillist){
boolean allowed=false;
Id  currentUserId = userInfo.getUserId();
system.debug('currentUserId ***'+currentUserId );
Id currentUserProfileId=userinfo.getProfileId();
Date today=date.newInstance(date.today().year(),date.today().month(),date.today().day());
for(email__c e:emailList){
 if(currentUserid==System.Label.AdminId){
 allowed=true;
 }
if(!allowed){
e.adderror('You do not have permission to delete the record');
} 
}
}
// For validating records after delete operation
public void updateParticipantEmail(List<Email__c> EmailList)
{
List<Id> ConIds=new List<ID>();
List<Candidate__c> contactUpdate=new List<Candidate__c>();
   for (Email__c s:EmailList){
        ConIds.add(s.CandidateName__c);
     }
//For each contact retrieve a list of emails exists
  for(Candidate__c c:[select id,Email__c,(select id,Primary__c,CandidateName__c,Email__c,Last_Web_Login__c,LastModifiedDate from Emails__r
   where Ph_Status__c='Valid' order by LastModifiedDate desc) from Candidate__c where id in :ConIds])
   {
   Email__C newEmail=getProperEmailRecord(c.Emails__r);
   if(newEmail.Email__C!=c.Email__c){
   c.Email__c=newEmail.Email__C;
   contactUpdate.add(c);
   }
   }
     update contactUpdate;
}
//This would return winning email
private Email__C getProperEmailRecord(List<Email__c> emailList){
   Email__C EmailPrimary;
   Email__C EmailNonPrimary;
   for(Email__c e:emailList){
   if(e.Primary__C==true &&(EmailPrimary==null||e.LastModifiedDate > EmailPrimary.LastModifiedDate)){
       EmailPrimary=e;
       }
     else if(e.Primary__C==false &&(EmailNonPrimary==null||e.LastModifiedDate >EmailNonPrimary.LastModifiedDate ))
       {
        EmailNonPrimary=e;
       }
    }
    if(EmailPrimary!=null)
       return EmailPrimary;
      else if(EmailNonPrimary!=null)
        Return EmailNonPrimary;
        else
             return null;
   }
   // For resolving primary email if a candiate has 2 primary emails
   public void resolvePrimaryConflicts(List<Email__c> emailList){
    List<Id> ConIds= new List<Id>();
    List<Id> EmailIds= new List<Id>();
    List<Email__c> emailUpdate=new List<Email__C>();
    for(Email__c e:emailList){
        if(e.primary__c==true){
             ConIds.add(e.CandidateName__c);
             EmailIds.add(e.Id);
          }
      }
      for(Email__c e:[select id,primary__c from Email__C where id not in :EmailIds and primary__c=true and CandidateName__c=:ConIds]){
      e.primary__c=false;      
      emailUpdate.add(e);
      }
      update emailUpdate;
   }
}