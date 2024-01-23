1. What is Terraform, and why is it used in the context of infrastructure automation?
  - Terraform is used for infrastructure automation to provision and manage resources across various cloud providers and on-premises environments 

2. Explain the difference between declarative and imperative approaches in infrastructure provisioning.
   - In declarative provisioning, we specify the end or desired state of the instructure without specifying the exact steps to reach that state. Example - terraform
   - Imperative provisioning involves including each step or command to provision infrastructure. example - shell scripts / ansible / chef

3. How does Terraform ensure the idempotency of resource provisioning?
    - Using state file it tracks the resources. When you run Terraform apply, Terraform compares the desired state described in the configuration with the current state recorded in the state file.

4. What is the Terraform state file, and why is it important?
     - The Terraform state file is a JSON or binary file that stores the current state of the managed infrastructure. 
     - It records resource metadata, dependencies, and other relevant information. The state file is critical for Terraform's operation as it allows the tool to understand the existing infrastructure and track changes over time.

5. How can you specify dependencies between resources in Terraform?
     - In Terraform, you can specify dependencies between resources using the depends_on attribute within resource blocks. By including this attribute, you define an explicit ordering of resource creation and ensure that one resource is created before another. 

6. What is the purpose of the Terraform plan command?
     - The Terraform plan command is used to create an execution plan that shows the changes Terraform will apply to the infrastructure. It compares the desired state defined in the configuration with the current state recorded in the state file.

7. How does Terraform handle secrets and sensitive data?
     - Terraform provides mechanisms to handle secrets and sensitive data securely. One approach is to use environment variables or input variables to pass sensitive values at runtime, ensuring they are not stored in plain text in the configuration files or state.

     - Another option is to use external secret management systems, such as HashiCorp Vault, to retrieve sensitive data during the Terraform execution. These practices help keep secrets separate from the infrastructure code and enhance security.

8. What are Terraform backends, and how do they help in state management?
     - Terraform backends are components responsible for storing and retrieving the Terraform state. They provide a persistent and centralized storage location for the state file, enabling collaboration and state sharing among team members.
     - Backends can store the state remotely, allowing concurrent access and locking to prevent conflicts. By using backends, you can avoid local state file storage and ensure the consistency and durability of the Terraform state.
     - Few backends: dynamo db

9. Explain the difference between Terraform's local and remote backends.
     - Terraform's local backend is the default backend and stores the state file on the local disk. It is suitable for solo development or situations where remote collaboration is not required. The local backend does not support state locking, making it prone to conflicts in team environments.
     - On the other hand, Terraform's remote backends store the state file remotely, enabling collaboration and concurrent access. Remote backends offer features like state locking, versioning, and additional security controls.
     - Examples of remote backends include Amazon S3, Azure Blob Storage, or HashiCorp Terraform Cloud. Using remote backends is recommended for team-based workflows to ensure consistency and avoid conflicts when multiple team members work on the same infrastructure.

10. Explain the concept of Terraform workspaces and when to use them.
      - Terraform workspaces provide a way to manage multiple instances of a Terraform configuration. Workspaces allow you to have separate sets of resources for different environments, such as development, staging, and production. 
      - They help in maintaining isolated environments and managing the state of each workspace.

11. How does Terraform handle variable interpolation in strings?
       - "${var.NAME}"

12. What are provider plugins in Terraform, and how do they work?
       - Provider plugins in Terraform are responsible for managing the resources of a specific cloud or infrastructure platform. They translate Terraform configurations into API calls to create, update, and delete resources

13. How can you leverage Terraform's "count" and "for_each" features for resource iteration?
       - You can use the "count" and "for_each" features in resource blocks to iterate and create multiple instances of a resource. 
       - "count" allows you to create a fixed number of resource instances, 
       - while "for_each" allows you to create instances based on a map or set of values

14. example of terraform using count
15. example of terraform using for_each
16. Explain how to use the Terraform "output" block for exporting resource information.
     - The output block in Terraform is used to define values that will be highlighted to the user upon terraform apply, or can be easily queried by the terraform output command. 
      - This can be really useful for exporting key resource information, such as IP addresses, hostnames, and other attributes for the resources created by a Terraform configuration.
     - example : 
       output "instance_ip_addr"{
         value = aws_instance.example.public_ip
         description  = "The public ip address of the example instance"
      }
     - outputs: instance_ip_addr = 203.0.113.12
