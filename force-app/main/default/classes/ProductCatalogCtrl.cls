public with sharing class ProductCatalogCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts(String whereclause){
        if(whereclause == null || whereclause == ''){
            system.debug('2222222');
            return ([SELECT Name FROM Product2]);
        }
        else {   
            List<Product2> prdlst = [SELECT Id,Name,ProductCode FROM Product2 WHERE Name  like : ('%'+whereclause +'%')];  
            system.debug('2222222111'+prdlst);     
            return ([SELECT Id,Name,ProductCode FROM Product2 WHERE Name  like : ('%'+whereclause +'%')]);
        }
        
    }
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductDetails(String productName){
        system.debug('productName :'+productName);
        List<Product2> prdlst = [SELECT Id,Name,ProductCode FROM Product2 WHERE Name = :productName];
        return ([SELECT Id,Name,ProductCode FROM Product2 WHERE Name = :productName]);
    }
}