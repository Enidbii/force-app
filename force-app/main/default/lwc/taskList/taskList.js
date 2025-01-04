import { LightningElement, wire, track } from 'lwc';
import getTasks from '@salesforce/apex/TaskController.getTasks';
import markTaskAsCompleted from '@salesforce/apex/TaskController.markTaskAsCompleted';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TaskList extends LightningElement {
    @track tasks;
    @track error;

    columns = [
        { label: 'Task Name', fieldName: 'Name' },
        { label: 'Due Date', fieldName: 'Due_Date__c', type: 'date' },
        { label: 'Completed', fieldName: 'Completed__c', type: 'boolean' },
        { type: 'button', typeAttributes: { label: 'Mark Completed', name: 'markCompleted', variant: 'success' } }
    ];

    @wire(getTasks)
    wiredTasks({ error, data }) {
        if (data) {
            this.tasks = data;
            this.error = undefined;
        } else if (error) {
            this.error = 'Error retrieving tasks.';
            this.tasks = undefined;
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'markCompleted') {
            markTaskAsCompleted({ taskId: row.Id })
                .then(() => {
                    this.showToast('Success', 'Task marked as completed!', 'success');
                    return refreshApex(this.wiredTasks);
                })
                .catch(error => {
                    this.showToast('Error', 'Failed to update task', 'error');
                    console.error(error);
                });
        }
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(evt);
    }
}
