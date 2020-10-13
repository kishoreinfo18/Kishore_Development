public class importDataFromCSVController {
    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public List<account> acclist{get;set;}
    public List<Contact> conList{get;set;}
    public Integer postionOfName{get;set;}
    public Integer assignedval{get;set;}
        public importDataFromCSVController(){
            csvFileLines = new String[]{};
            acclist = New List<Account>();
            conList = new List<Contact>();
        }
        public void importCSVFile(){
            try{
                csvAsString = csvFileBody.toString();
                csvFileLines = csvAsString.split('\n'); 
                system.debug('Account list of file data is:'+csvFileLines+'    '+csvFileLines.size());
                for(Integer i=0;i<csvFileLines.size();i++){
                    string[] csvRecordData = csvFileLines[i].split(',');
                    system.debug('csvRecordData is :'+csvRecordData);
                    if(csvRecordData[i] == '﻿Account Data'){
                        for(Integer j=1;j<csvFileLines.size();j++){
                            string[] csvRecordData1 = csvFileLines[j].split(',');
                            system.debug('csvRecordData1 is :'+csvRecordData1+'       '+csvFileLines.size());
                            if(csvRecordData1[j] != 'Contact Data'){
                                Account accObj = new Account();
                                accObj.name = csvRecordData1[0];
                                accObj.Type = csvRecordData1[1];
                                accObj.shippingstreet = csvRecordData1[2];
                                accObj.shippingCity = csvRecordData1[3];
                                accObj.shippingPostalCode= csvRecordData1[4];
                                accObj.shippingCountry= csvRecordData1[5];
                                accObj.ISCUSTOMERPORTAL__c= csvRecordData1[6];
                                acclist.add(accObj);
                                assignedval = j;
                                }
                        }
                         system.debug('account list is :'+acclist+'    assignedval    '+assignedval);
                    }
                   
                    //insert acclist;
                    if(csvRecordData[i] == 'Contact Data'){
                        for(Integer k = assignedval+1; k<csvFileLines.size(); k++){
                            string[] csvRecordData2 = csvFileLines[i].split(',');
                            Contact cont = new Contact();
                            cont.Lastname=csvRecordData2[0];
                            conList.add(cont);
                        }
                    }
                    system.debug('contact list is '+ conList);
                }
            }
            catch(Exception e){
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
                ApexPages.addMessage(errorMessage);
            }
        }
}