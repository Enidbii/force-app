@isTest
public class MarkOverdueTasksBatchTest {
    @testSetup
    static void setupTestData() {
        List<Task__c> tasks = new List<Task__c>{
            new Task__c(Name = 'Overdue Task 1', Due_Date__c = Date.today().addDays(-1), Completed__c = false),
            new Task__c(Name = 'Overdue Task 2', Due_Date__c = Date.today().addDays(-2), Completed__c = false),
            new Task__c(Name = 'Future Task', Due_Date__c = Date.today().addDays(5), Completed__c = false)
        };
        insert tasks;
    }

    @isTest
    static void testBatchExecution() {
        Test.startTest();
        MarkOverdueTasksBatch batchJob = new MarkOverdueTasksBatch();
        Database.executeBatch(batchJob);
        Test.stopTest();

        // Verify that overdue tasks are marked as completed
        List<Task__c> updatedTasks = [SELECT Id, Completed__c FROM Task__c WHERE Due_Date__c < TODAY];
        for (Task__c task : updatedTasks) {
            System.assertEquals(true, task.Completed__c, 'Overdue tasks should be marked as completed');
        }
    }
}
