public with sharing class TaskBatchScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        MarkOverdueTasksBatch batchJob = new MarkOverdueTasksBatch();
        Database.executeBatch(batchJob);
    }
}
