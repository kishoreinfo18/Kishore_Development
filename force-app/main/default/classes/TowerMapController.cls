public inherited sharing class TowerMapController { 
     @AuraEnabled 
	public static List<Tower__c> getAllTowers() {
        String theObject = 'Tower__c';
        List<String> theFields = new List<String>{'Id', 'Name', 'State__r.Name', 'Location__Latitude__s', 'Location__Longitude__s'};
            String theFilter = ''; 
			String sortField = 'Name';
        	String sortOrder = 'ASC'; 
        List<Tower__c> allTowers = TowerMapUtilClass.queryObjects(theObject, theFields, theFilter, sortField, sortOrder);
        return allTowers; 
    }

}