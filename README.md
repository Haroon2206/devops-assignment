# PGR301 DevOps in the Cloud - Retake: 72-Hour Written Individual Home Exam

### Delivery Requirements
The exam assignment, code, and necessary files are available in the GitHub repository:
[GitHub Repository](https://github.com/glennbechdevops/eksamen-2025-konte)

## Submission Guidelines
### WiseFlow
- When submitting your assignment in WiseFlow, upload a document that only contains a link to your repository.
- The file must be in either **PDF** or **text** format.

### GitHub
- You can either **fork** this repository or **copy** the files into a new repository.
- To prevent other students from seeing your submission, it is recommended to work in a **private repository**.
- Make the repository **public** just before the submission deadline.
- In your repository, create a `README.md` file where you answer discussion questions and document task-specific deliverables.

---

## Background
Your company has recently started using **StatusCake** for availability monitoring.

As part of the company’s **DevOps journey**, it has been decided to implement **“monitoring as code”** to ensure a more systematic and reproducible approach. **Terraform** has been chosen for infrastructure management and **GitHub Actions** for CI/CD.

---

## Existing Setup
You have been provided with a Terraform project located in the `infrastructure/` folder.

### Project Contents:
✅ **Basic Terraform configuration:**
- Contains **hardcoded API keys** in the provider block.

✅ **Simple alert for a single website:**
- Uses **hardcoded values**, making the code less reusable.

✅ **CI/CD Pipeline:**
- Automates deployment of the setup, but **does not follow best DevOps practices**.

---

## General Instructions
To complete the task, it is recommended that you **sign up for a free 7-day trial on StatusCake**:
[Register here](https://www.statuscake.com)

Spend some time **getting familiar** with the service and its concepts. This will help you write the infrastructure code.

💡 **Tip:** Try running Terraform **locally** before using GitHub Actions to save time.

When setting up website monitoring, you can choose any domain, such as **VG.no** or **xkcd.com**.

---

## 1. Security and CI/CD Pipeline Improvements (30 points)
Currently, the workflow is set to **manual execution**, requiring navigation to GitHub Actions and selecting **"Run workflow"**.

Additionally, an **API key for StatusCake is hardcoded** in the code, which is a serious security risk.

### Your tasks:
🔹 **GitHub Actions Workflow:**
- On **feature branches**, the workflow should run `terraform plan`, but **not** `terraform apply`.
- On the **main branch**, both `terraform plan` and `terraform apply` should run automatically.

🔹 **Handling Sensitive Values:**
- Infrastructure code and the GitHub Actions workflow **must not contain hardcoded secrets** (e.g., StatusCake API key).
- Describe and implement a **secure solution** for handling sensitive values.

---

## 2. Improving and Extending the Terraform Code (30 points)
🔹 Replace **hardcoded values** with **variables** where appropriate.
🔹 Explore the [StatusCake Terraform provider](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest/docs) and extend the code with additional resources.
🔹 At a minimum, create a **contact_group**, but feel free to add more resources as needed.
🔹 Write a **short explanation** of your monitoring choices, threshold values, etc.

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

---

## 4. Managing Terraform State (10 points)
Currently, Terraform **state files** are being checked into GitHub along with the code, which is **not an optimal practice**.

### Discussion Points:
🔹 Initially, this approach may work, but what are the potential **risks** as the team grows and more developers work on the same repository?
🔹 What **better mechanisms** can be used to handle Terraform state?

---

## GOOD LUCK WITH THE EXAM! 🎯🚀
