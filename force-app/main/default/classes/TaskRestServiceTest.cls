@isTest
global class TaskRestServiceTest {
    @testSetup
    static void setupTestData() {
        insert new Task__c(Name = 'Test Task', Due_Date__c = Date.today(), Completed__c = false);
    }

    @isTest
    static void testGetTasks() {
        Test.startTest();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestUri = '/services/apexrest/tasks';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        List<Task__c> tasks = TaskRestService.getTasks();
        Test.stopTest();

        System.assert(tasks.size() > 0, 'There should be at least one task returned');
    }
}
