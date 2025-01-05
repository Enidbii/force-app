🚀 Salesforce Task Management Project
This project includes:
✅ A Custom Object (Task__c) for managing tasks
✅ A Lightning Web Component (LWC) for displaying tasks
✅ An Apex Batch/Queueable Job for auto-completing overdue tasks
✅ An Apex REST API (TaskRestService.cls) to fetch tasks via HTTP
✅ Deployment and Testing Instructions


📌 Prerequisites
Before deploying, ensure you have:

✅ Salesforce CLI installed
✅ A Dev Hub-enabled Salesforce org

# Deployment Steps
🔹 1.1 Authenticate Salesforce CLI with Your Dev Hub:
    sfdx auth:web:login -d -a DevHub
    This opens up a login page to the salesforce.org
🔹 1.2 Deploy Code to Salesforce:
    sf project deploy start --target-org <username>(salesforce.org)
    Ensure to enable communication between cli and the org.

# Accessing & Testing the LWC (taskList)
  Create a Lightning App Page
  Go to Salesforce Setup → App Builder
  Click New Lightning Page → Lightning App Page
  Drag & Drop the taskList component into the page
  Save & Activate

# Running & Testing the Apex Batch/Queueable Job
  Run Manually from Developer Console
    Open Developer Console
    Go to Debug → Open Execute Anonymous Window
    Run the following command:
      system.enqueueJob(new CompleteOverdueTasksBatch());
    Check results in Setup → Apex Jobs

# Testing the Apex REST Endpoint
  Get All Tasks Using cURL
    curl -X GET -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
    "https://your-org-instance.salesforce.com/services/apexrest/tasks"

  or using postman:
  Open postman
  set method to GET
  and enter the following url:
    https://your-org-instance.salesforce.com/services/apexrest/tasks
  Under headers enter:
    Authorization: Bearer YOUR_ACCESS_TOKEN
  click send

# Known Limitations & Assumptions
  Authentication → The REST API requires a valid Salesforce access token.
  Batch Job Scheduling → The job must be manually scheduled if automation is required.
  LWC Availability → The component works only in Lightning Experience, not Classic.
  Error Handling → The REST API returns a 500 error if something goes wrong.
  
