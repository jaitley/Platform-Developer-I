// REF: https://trailhead.salesforce.com/content/learn/modules/apex_integration_services/apex_integration_webservices
@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        
        RestRequest request = System.RestContext.request;
        // get account id from url
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        
        Account result = [SELECT   Id, Name,
                                (SELECT Id, Name FROM Contacts)
                      FROM      Account
                      WHERE     Id = :accountId];
        return result;
    }

}