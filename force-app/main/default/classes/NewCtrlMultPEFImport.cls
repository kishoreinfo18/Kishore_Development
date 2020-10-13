public class NewCtrlMultPEFImport {
    public Blob csvFileBody{get;set;}
    public String csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    private String fieldDelimiter;
    public NewCtrlMultPEFImport(){
        csvFileLines = New String[]{};
            MultPEFImportSettings__mdt MySettings = [SELECT fieldDelimiter__c, ImportIdPos__c, lineDelimiter__c, ReportNumberPos__c, RTName__c
	    											FROM MultPEFImportSettings__mdt
	    											WHERE MasterLabel = 'DefaultSettings'];
        fieldDelimiter = MySettings.fieldDelimiter__c;
        
    }
    public void importCSVFile(){
        csvAsString = csvFileBody.toString();
        csvFileLines = csvAsString.split('\n'); 
        List<String> nextcsvRecordData= new List<String>();
        String nextRecord; 
        for(Integer i=0;i<csvFileLines.size();i++){
            try{
                String currentRecord = csvFileLines[i];
            	List<String> csvRecordData = currentRecord.split(',');
            }
            catch(exception e){
                system.debug('1234'+e);
            }
            
            
    	}

	}
}