global class Concur extends Auth.AuthProviderPluginClass {
     private static final String CODE_PARAMETER                  = 'code';
     private static final String STATE_PARAMETER                 = 'state';
     private static final String CLIENT_ID_KEY                   = 'ClientId__c';
     private static final String CLIENT_SECERET_KEY              = 'ClientSecret__c';
     private static final String REST_CONTENT_TYPE_HEADER        = 'Content-Type';
     private static final String REST_CONTENT_TYPE_VALUE         = 'application/x-www-form-urlencoded';
     private static final String REST_AUTHORIZATION              = 'Authorization';
     private static final String AUTHORIZATION_TYPE              = 'Basic ';
     private static final String REST_METHOD_POST                = 'POST';
     private static final String REST_ACCEPT_HEADER              = 'Accept';
     private static final String CONTENT_TYPE_VALUE              = 'application/vnd.alertme.zoo-6.5.0+json';
     private static final String REST_OMNIA_HEADER               = 'X-Omnia-Client';
     private static final String REST_CLIENT_VALUE               = 'salesforce';
     private static final string AUTHORIZATION_TYPE_BEARER       = 'Bearer ';
     private static final String REST_METHOD_GET                 = 'GET';
     private static final String PROVIDER                        = 'AWS_Cognito_Consumer_Link_Dummy';
     private static final String EXCEPTION_MESSAGE               = 'Problem in logging.For help, contact your administrator.';
     public String redirectUrl; // use this URL for the endpoint that the authentication provider calls back to for configuration
     private String key;
     private String secret;
     private String authUrl;    // application redirection to the Concur website for authentication and authorization
     private String accessTokenUrl; // uri to get the new access token from concur  using the GET verb
     private String customMetadataTypeApiName; // api name for the custom metadata type created for this auth provider
     private String userAPIUrl; // api url to access the user in concur
     private String userAPIVersionUrl; // version of the user api url to access data from concur
    
    global String getCustomMetadataType() {
        return 'AWSCognitoConsumerLink__mdt';
    }
    global PageReference initiate(Map<string,string> authProviderConfiguration, String stateToPropagate) {
        system.debug('stateToPropagate is:'+stateToPropagate);
        system.debug('authUrl  is :'+authProviderConfiguration.get('CognitoLoginURL__c'));
        system.debug('key is :'+ authProviderConfiguration.get('ClientId__c'));
        system.debug('redirectUrl '+EncodingUtil.urlEncode(authProviderConfiguration.get('redirectUrl__c'), 'UTF-8'));
        system.debug('responsetype'+authProviderConfiguration.get('ResponseType__c'));
        system.debug('sCOPE IS: '+authProviderConfiguration.get('scope__c'));
        
        String url = authProviderConfiguration.get('CognitoLoginURL__c')
            + 'response_type=' + authProviderConfiguration.get('ResponseType__c')
            + '&client_id='     + authProviderConfiguration.get('ClientId__c')
            + '&redirect_uri='  + EncodingUtil.urlEncode(authProviderConfiguration.get('redirectUrl__c'), 'UTF-8')
            + '&scope='         + authProviderConfiguration.get('scope__c')
            + '&state='         + stateToPropagate;
        system.debug('url is :'+url);           
       return new PageReference(url);  
    }
        
    global Auth.AuthProviderTokenResponse handleCallback(Map<string,string> authProviderConfiguration, Auth.AuthProviderCallbackState callbackState ) {
        try{
            Map<String,String> queryParams = callbackState.queryParameters; 
            String code = queryParams.get(CODE_PARAMETER); 
            String state = queryParams.get(STATE_PARAMETER);
            String clientId = authProviderConfiguration.get('ClientId__c');
            String secret = authProviderConfiguration.get('secret__c');
            Blob headerValue = Blob.valueOf(clientId+':'+secret);
            String authCode  = EncodingUtil.base64Encode(headerValue);
            String accessTokenURL = authProviderConfiguration.get('accessTokenUrl__c'); 
            String endpoint  = authProviderConfiguration.get('accessTokenUrl__c')
                              +'?grant_type='+'authorization_code'
                              +'&code='+code
                              +'&redirect_uri='+authProviderConfiguration.get('redirectUrl__c');
            system.debug('endpoint is : '+endpoint);
            HttpRequest req = new HttpRequest(); 
            req.setHeader(REST_CONTENT_TYPE_HEADER, REST_CONTENT_TYPE_VALUE); 
            req.setHeader(REST_AUTHORIZATION, AUTHORIZATION_TYPE+authCode);
            req.setMethod(REST_METHOD_POST);
            req.setEndpoint(endpoint);
            Http http = new Http(); 
            HTTPResponse res = http.send(req); 
            system.debug('res is :'+res);
            String responseBody = res.getBody(); 
            system.debug('responseBody is :'+responseBody);
            createDebugMessages(req, res, null);   
            String token = getValueFromResponse(responseBody, 'access_token');
            system.debug('Token is :'+token);
            String refreshToken = getValueFromResponse(responseBody, 'refresh_token'); 
            system.debug('refreshToken is :'+refreshToken);
            return new Auth.AuthProviderTokenResponse('Concur', token, refreshToken, state);  
        
        } catch (Exception e) {
            createDebugMessages(null, null, e);
            throw new Auth.AuthProviderPluginException(EXCEPTION_MESSAGE);
        }   
        
      
    }
    
    global Auth.UserData getUserInfo(Map<string,string> authProviderConfiguration, Auth.AuthProviderTokenResponse response) { 
        try{
            String bodyRequestJson = JSON.serialize(new CreateSessionWithCognito(response.oauthToken));
            system.debug('bodyRequestJson '+bodyRequestJson );
            HttpRequest req = new HttpRequest ();
            req.setEndpoint(authProviderConfiguration.get('userAPIUrl__c')); 
           // req.setHeader(REST_ACCEPT_HEADER, CONTENT_TYPE_VALUE);
           // req.setHeader(REST_OMNIA_HEADER, REST_CLIENT_VALUE);
            req.setHeader(REST_AUTHORIZATION, AUTHORIZATION_TYPE_BEARER+response.oauthToken);           
            req.setMethod(REST_METHOD_GET);
            Http http = new Http(); 
            HTTPResponse res = http.send(req);
            createDebugMessages(req, res, null);   
            String responseBody = res.getBody();
            system.debug('responseBody is:'+responseBody);
            // untyped converstion
            
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(responseBody);
            system.debug('responseMap is:'+responseMap);
            
            Map<String, String> values = (Map<String, String>)JSON.deserialize(res.getBody(), Map<String, String>.class);
            String email = values.get('email');
            String username = values.get('username');
            String sub = values.get('sub');
            String email_verified = values.get('email_verified');
            String sfdc_networkid = values.get('sfdc_networkid');
            system.debug('email is :'+email);
            
            //String uId = [select Id from User where email = :email limit 1].Id; 
            
           // List<Object> userList = (List<Object>)responseMap.get('users');
           // system.debug('userList is'+userList);
            
         //   Map<String,Object> userMap      = (Map<String,Object>) userList[0];

          Map<String,String> attributeMap  = new Map<String, String>();
            attributeMap.put('email',(String)values.get('email'));  
            attributeMap.put('email_verified',(String) values.get('email_verified')); 
            attributeMap.put('sfdc_networkid',(String) values.get('sfdc_networkid')); 
            attributeMap.put('sub',(string) values.get('sub')); 
            attributeMap.put('username',(String)values.get('username'));
           // attributeMap.put('lastName',(String) userMap.get('lastName'));  
           // attributeMap.put('firstName',(String) userMap.get('firstName'));
           // attributeMap.put('timeZone',(String) userMap.get('timeZone')); 
           // attributeMap.put('profileId', authProviderConfiguration.get('ProfileId__c'));
            
            system.debug(attributeMap.get('id')+'    '+attributeMap.get('email')+'       '+attributeMap.get('username'));
            return new Auth.UserData(attributeMap.get('sub'),  //identifier
                                     null,                    // firstName
                                     null,                  // lastName
                                     null,                 // fullName
                                     attributeMap.get('email'),                // email
                                     null,               // link
                                     null,              // userName
                                     null,             // locale
                                     'Custom',        // provider
                                     null,           //siteLoginUrl
                                     attributeMap); // attributeMap*
        }
        Catch(exception e){
            createDebugMessages(null, null, e);
            throw new Auth.AuthProviderPluginException(EXCEPTION_MESSAGE);
        }    
    }
//Here the developer is responsible for constructing an Auth.UserData object
    private String getTokenValueFromResponse(String response, String token, String ns) {
        Dom.Document docx = new Dom.Document();
        docx.load(response);
        String ret = null;
        dom.XmlNode xroot = docx.getrootelement() ;
        if(xroot != null){
            ret = xroot.getChildElement(token, ns).getText();
        }
        return ret;
    }
    public void createDebugMessages(HttpRequest req, HttpResponse res, Exception exceptionMessage) {
        String debugMessage = '=========>Request=======>'+req
            +'\n'+'========>Response=====>'+res
            +'\n'+'========>Resbody======>'+res.getBody()!=null ? res.getBody() : ''
            +'\n'+'========>Exception====>'+exceptionMessage;

        System.debug(debugMessage);
    }  
    public String getValueFromResponse(String response, String key) { 
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        return (String)responseMap.get(key); 
    } 
     public class CreateSessionWithCognito {
        public String AccessToken;
        public CreateSessionWithCognito(String AccessToken) {
            this.AccessToken = AccessToken;
        }
    }
}