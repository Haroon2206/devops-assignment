## 1. Security and CI/CD Pipeline Improvements (30 points)
### Your tasks:
🔹 **GitHub Actions Workflow:**
- On **feature branches**, the workflow should run `terraform plan`, but **not** `terraform apply`.
- On the **main branch**, both `terraform plan` and `terraform apply` should run automatically.

🔹 **Handling Sensitive Values:**
- Infrastructure code and the GitHub Actions workflow **must not contain hardcoded secrets** (e.g., StatusCake API key).
- Describe and implement a **secure solution** for handling sensitive values.

- ``This has been done now the pipeline runs on all feature brances till terraform plan and terraform apply only runs for main branch``
- ``And the StatusCake API key is moved to Github Secrets when the pipeline runs it's fetches the API key from secret and passes it to terraform apply command as a variable using -var flag``
---

## 2. Improving and Extending the Terraform Code (30 points)
🔹 Replace **hardcoded values** with **variables** where appropriate.
🔹 Explore the [StatusCake Terraform provider](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest/docs) and extend the code with additional resources.
🔹 At a minimum, create a **contact_group**, but feel free to add more resources as needed.
🔹 Write a **short explanation** of your monitoring choices, threshold values, etc.

- I have added a module for contact_group
- Check Interval: Configurable (check_interval), typically 5 minutes, to balance responsiveness and resource usage.
- Confirmation: 3 consecutive failed checks to avoid false alarms.
- Trigger Rate: 10 failures required to trigger an alert, ensuring multiple failures before notifying.
- Timeout: 20 seconds to wait for a response before considering the check failed.
- SSL Validation: Enabled (true) to ensure a valid SSL certificate.
- Status Codes: Alerts only for a 200 HTTP status, indicating the site is functioning properly.
- Tags: Tagged as "production" for environment organization.
---

## 3. Terraform Modules (30 points)
One of Terraform’s major benefits is the ability to write **reusable infrastructure code**. Since multiple departments in the company may need monitoring with StatusCake, a **reusable module** should be created.

### Evaluation Criteria:
- **Ease of use** of the module (e.g., setting **reasonable default values** for thresholds and settings).
- The ability for users to **override** these variables if needed.

### Task:
🔹 Modify the Terraform code to support monitoring **multiple websites**.
🔹 Use **Terraform modules** to avoid redundant code.
🔹 Create a **module** and use it **twice** with different values for at least **two different websites**.

- ``Yes it's a terraform best practise to use modules to have less redundancy two modules have been created one for contact group and other for status cake uptime. And Status cake uptime module is called twice for two different websites vg.no and xkcd with different values and nothing is hardcoded``
---

## 4. Managing Terraform State (10 points)
Currently, Terraform **state files** are being checked into GitHub along with the code, which is **not an optimal practice**.

### Discussion Points:
🔹 Initially, this approach may work, but what are the potential **risks** as the team grows and more developers work on the same repository?
🔹 What **better mechanisms** can be used to handle Terraform state?

**Risks of pushing state file on Github**
- Exposing vunerable data like API tokens & password etc about your infrasrcture to anyone who has access of this repo
- State file is the most important file in terraform it can be corrupted if multiple developers run terraform apply command at the same time which might lead to abnormal changes or you can lose track of your infrastructure

**To Handle Terraform state**
- State file should be put ton remote storages like S3 bucket on AWS so it save secrure and only limited people have access to the state file and also versioning can be enabled on storage in case roll back is needed.
- State lock should also be implemented in case of AWS we can use DynamoDB so multiple developers can't run terraform apply simultaneously without locking state file could corrupt or produce conflicts in infrastructure