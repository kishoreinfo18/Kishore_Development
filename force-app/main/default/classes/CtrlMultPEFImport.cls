public class CtrlMultPEFImport {
    public Blob csvFileBody{get;set;}
    public String csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public CtrlMultPEFImport(){
        csvFileLines = New String[]{};
    }
    public void importCSVFile(){
        csvAsString = csvFileBody.toString();
        csvFileLines = csvAsString.split('\n');
        for(Integer i=0;i<csvFileLines.size();i++){
            try {
                String currentRecord = csvFileLines[i];
                List<String> csvRecordData = currentRecord.split(',');
                
            }catch (Exception ce) {
            }
        }
    }

}