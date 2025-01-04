@RestResource(urlMapping='/tasks')
global with sharing class TaskRestService {

    @HttpGet
    global static List<Task__c> getTasks() {
        try {
            return [SELECT Id, Name, Due_Date__c, Completed__c FROM Task__c ORDER BY Due_Date__c ASC];
        } catch (Exception e) {
            // Return an HTTP 500 error with message
            RestResponse res = RestContext.response;
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Internal Server Error: ' + e.getMessage());
            return null; // Return null since an error occurred
        }
    }
}

