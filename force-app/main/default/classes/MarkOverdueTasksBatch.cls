public with sharing class MarkOverdueTasksBatch implements Database.Batchable<SObject> {

    // Query to find overdue and incomplete tasks
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Completed__c FROM Task__c WHERE Due_Date__c < TODAY AND Completed__c = false'
        );
    }

    // Processes each batch of tasks
    public void execute(Database.BatchableContext bc, List<SObject> taskList) {
        List<Task__c> tasksToUpdate = new List<Task__c>();
        
        for (SObject obj : taskList) {
            Task__c task = (Task__c) obj;
            task.Completed__c = true; // Mark task as completed
            tasksToUpdate.add(task);
        }

        if (!tasksToUpdate.isEmpty()) {
            update tasksToUpdate; // Perform bulk update
        }
    }

    // Finish method (optional, for logging or post-processing)
    public void finish(Database.BatchableContext bc) {
        System.debug('Overdue tasks have been updated successfully.');
    }
}