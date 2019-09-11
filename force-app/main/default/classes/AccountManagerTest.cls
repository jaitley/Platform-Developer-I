@IsTest
private class AccountManagerTest {
    // private static String baseUrl = 'https://curious-panda-lzl1hg-dev-ed.lightning.force.com/services/apexrest/';
    private static String baseUrl = 'https://playful-badger-rv1rje-dev-ed.lightning.force.com/services/apexrest/';

    @isTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = baseUrl + 'Accounts/' + recordId;
        request.httpMethod = 'GET';
        // injected into context
        RestContext.request = request;
        // Call the method to test
        Account acct = AccountManager.getAccount();
        // Verify results
        System.assert(acct != null);
        System.assertEquals('Test Account', acct.Name);
    }
    
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account acctTest = new Account(Name='Test Account');
        insert acctTest;
        return acctTest.Id;
    }          
}