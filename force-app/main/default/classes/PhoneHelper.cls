Public class PhoneHelper{
// For validating delete user
public void validateDeleteUser(List<phone__c> phoneList){
  Id  currentUserProfileId;
  for(phone__c p:phoneList){
  if(currentUserProfileId==system.label.AdminId && (p.source__c=='SLX' || p.source__c=='Manually Entered')){
     }
      else{
       p.addError('You do not have right to delete the records');
      }
  }
 }
public void validatePhoneformat(list<Phone__c> phonelist){
 String strPhone;
 String specialChars = '&|^|@|*|#|%|!|$|(|)|-'; 
 for (Phone__c objTemp:phoneList){
    if(objTemp.number__c!=null){
       strPhone=objTemp.number__c;
        for(string s : specialChars .split('|')){
                    strPhone = strphone.remove(s).replaceAll( '\\s+', '');
                }
       if(strPhone.length()>10 && strPhone.isalphanumeric())
       objTemp.number__c=objTemp.number__c;
       else
        objTemp.number__c=strPhone;
     }
   }
 }
}