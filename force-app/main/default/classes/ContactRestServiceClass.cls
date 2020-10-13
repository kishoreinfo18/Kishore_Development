@RestResource(urlMapping='/api/Contact/*')
global class ContactRestServiceClass
{
    @HttpGet
    global static Contact getContactByEmail() { 
        RestRequest req = RestContext.request;
        String contactEmailaddr = RestContext.request.params.get('Email');
        RestResponse res = RestContext.response;
        String contactEmail = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Contact contactDetails = [SELECT Id, Salutation ,FirstName,LastName,Title,MailingCountry,MailingStreet,MailingCity,MailingPostalCode,
                                MailingState,Email,MobilePhone,Phone,Fax FROM Contact WHERE Email = : contactEmail];
        return contactDetails;
    }
}