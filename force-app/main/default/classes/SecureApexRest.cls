@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {    
    @HttpGet
    global static Contact doGet(){
        /* GET ID FROM QUERY STRING */
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        List<Contact> results;
        
        if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
        
        try {
            results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId WITH SECURITY_ENFORCED];
        }
        catch (System.QueryException ex)
        {
            throw new SecurityException('You don\'t have access to all contact fields required to use this API');       
        }
        
        if (!results.isEmpty()) {
            result = results[0];
            
        } else{
            throw new SecurityException('You don\'t have access to all contact fields required to use this API');
        }
        return result;
    }
    public class FunctionalException extends Exception{}
    public class SecurityException extends Exception{}
}