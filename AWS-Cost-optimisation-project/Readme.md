AWS Cloud Cost Optimization - Identifying Stale Resources

- we will create a lambda function that identifies EBS snapshots that are no longer associated with any active EC2 Instance and deletes them to save on storage costs.

Automation
- create lambda function and run the python code

Description
- The Lambda function fetches all the EBS snapshots owned by the same account (self) and also retrieves a list of active Ec2 Instances (running and stopped).
- For each snapshot, it checks if the associated volume (if exists) is not associated with any active instance
- If it finds stale snapshot, it deletes it effectively optimising the storage costs