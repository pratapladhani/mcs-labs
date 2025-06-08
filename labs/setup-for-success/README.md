# Set yourself up for success & discover ALM best practices

Build agents with confidence. Deploy with control. Master the lifecycle of your Microsoft Copilot Studio agents with best practices.

---


## 🧭 Lab Details

| Level | Persona | Duration   | Purpose                                                                                                                                                                                                                                                                                                                                                                                                          |
| ----- | ------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 200   | Maker   | 20 minutes | After completing this lab, participants will be able to apply Application Lifecycle Management (ALM) best practices to their Microsoft Copilot Studio solutions. They will know how to structure their work using solutions and publishers, configure environment variables and connection references for deployment readiness, and set up Git-based source control using Azure DevOps—all without writing code. |

---

## 🌐 Introduction

Application Lifecycle Management (ALM) ensures that your solutions evolve safely and efficiently as they move from development to production. This lab will walk you through the foundational best practices of ALM in Microsoft Copilot Studio—from structuring your solution to managing configurations and source control.

---

## 🎓 Core Concepts Overview

| Concept | Why it matters |
|---------|----------------|
| **Solution** | A standard way in Microsoft Power Platform to package and ship components—including Microsoft Copilot Studio agent components like topics, knowledge sources, and tools—across environments alongside flows, prompts, environment variables, connection references, and any other solution-aware component types. |
| **Publisher** | A metadata element that identifies the creator of solution components. Using a custom publisher improves traceability and supports cleaner prefixes in naming conventions. |
| **Environment** | A workspace in Power Platform where no-code, low-code, or pro-code artifacts—such as agents, flows, and data—reside. ALM best practices typically involve multiple environments (e.g., dev, test, prod) to manage lifecycle stages. For admins, environments also provide governance controls to limit what makers can do, which connectors or knowledge sources can be used, and how assets are secured and deployed. |
| **Environment variable** | A reusable setting (like a URL, API key, or ID) that can vary between environments without modifying individual components. Supports automation and portability. For secrets, use the Secret data type to retrieve values securely from Azure Key Vault. |
| **Connection reference** | An abstraction that links connectors (e.g., SharePoint, Dataverse, ServiceNow, etc.) to credentials and environment-specific settings—allowing reuse and cleaner ALM processes. |
| **Managed solution** | A read-only version of a solution used for deployment to downstream environments. Managed solutions support clean, controlled, and incremental updates, can be uninstalled, and prevent direct modifications to components in the target environment. |
| **Unmanaged solution** | Editable solution used in development. Changes can be versioned and exported for deployment. Should not be used in test or production. |
| **Solution-aware** | A component or setting that is part of a solution and can be deployed with it across environments. Not all Copilot Studio settings are solution-aware. |
| **Source control** | The practice of tracking and managing changes to your assets over time. Git integration with Azure DevOps enables auditing, collaboration, and versioning. |
| **CI/CD** | Continuous Integration / Continuous Deployment. Automates the process of testing and deploying solutions using tools like Azure DevOps pipelines or GitHub Actions. |                                                                                          

---

## 📄 Documentation and Additional Training Links

* [ALM overview - Microsoft Power Platform](https://learn.microsoft.com/power-platform/alm/alm-overview)
* [Publish and deploy your agent](https://learn.microsoft.com/copilot-studio/publish-deploy)
* [Webinar: Microsoft Copilot Studio ALM](https://aka.ms/MCSALMWebinar)
* [Environment variables in solutions](https://learn.microsoft.com/power-apps/maker/data-platform/environmentvariables)
* [Connection references in a solution](https://learn.microsoft.com/power-apps/maker/data-platform/create-connection-reference)
* [Dataverse Git integration overview](https://learn.microsoft.com/power-platform/alm/git-version-control)

---

## ✅ Prerequisites

* Access to Microsoft Copilot Studio.
* A Microsoft Power Platform environment with at least an Environment Maker security role.
* Access to an Azure DevOps organization, project, and branch using the same tenant credentials as Microsoft Copilot Studio.

---

## 🎯 Summary of Targets

In this lab, you'll configure your ALM foundation for working with Microsoft Copilot Studio like a pro. By the end of the lab, you will:

* Create and configure a structured solution for your customizations.
* Set up a custom publisher to track ownership and maintain ALM hygiene.
* Add environment variables and connection references for better portability.
* Learn how to source control your Microsoft Copilot Studio project in a Git repo.
* Understand which Microsoft Copilot Studio settings require manual post-deployment steps.

---

## 🧩 Use Cases Covered

| Step | Use Case | Value added | Effort |
|------|----------|-------------|--------|
| 1 | [Create a solution and custom publisher](#-use-case-1-create-a-solution-and-custom-publisher) | Structure your success – Group, manage, and deploy all your agent assets with clarity and control. | 5 min |
| 2 | [Create environment variables and connection references](#-use-case-2-create-environment-variables-and-connection-references) | Adapt with flexibility – Environment variables future-proof your agents for seamless multi-environment deployments. Manage credentials and services cleanly across dev, test, and prod. | 5 min |
| 3 | [Set up Git source control](#-use-case-3-set-up-git-source-control) | Track and evolve – Use Git to version, review, and automate deployment of your agent assets. | 10 min |

---

## 🛠️ Instructions by Use Case

### 🧱 Use Case #1: Create a solution and custom publisher

Create a structured container to manage all your Copilot Studio agent components across environments.

#### Objective

Set up your development environment by creating a solution and custom publisher in Microsoft Copilot Studio.

---

#### Open the Solutions area

1. Go to the [Copilot Studio home page](https://aka.ms/MCSStart).
2. Confirm you are in the correct environment (top-right corner).

#### Name the solution

3. In the left navigation (under the `...` menu), select **Solutions** → **New solution**.
4. Enter a display name.

> [!TIP]
>  * Avoid names like `DEV`, `POC`, or anything tied to a lifecycle phase.
>  * Use a descriptive, project-based name.
>  * For example, if this specific to this training and lab, use `Training Workshop Agents`

#### Create a custom publisher

5. If this is your first solution, click **+ Publisher** to create one.

> [!TIP]
>  * You may use your organization’s name.
>  * Define a short prefix for use in technical names.

> [!IMPORTANT]
> Avoid using the default publisher or the default solution. Custom publishers ensure cleaner component names and better ALM hygiene.

#### Set and create

6. Mark this solution as your **preferred solution** (so new assets go into it by default).
7. Click **Create**.

---

#### Test your understanding

**Key takeaways:**

* **Solutions first** – Solutions help manage your agent and related components across environments.
* **Lifecycle readiness** – Structuring up front simplifies governance, updates, and deployment.
* **Naming matters** – Use clean, environment-agnostic names.

**Lessons learned & troubleshooting tips:**

* Avoid names like “DEV” or “Test” in your solution name—they’re misleading.
* If save fails, ensure publisher prefix is unique and valid.
* Keep solution names business-focused, not technical-phase focused.

**Challenge: Apply this to your own use case**

* What would you name your solution?
* How might you use solutions to organize future agent components?
* Try making another solution for a separate department or use case.

---

### 🧩 Use Case #2: Create environment variables and connection references

Add reusable variables for URLs, keys, or other settings that differ across environments, along with connection references to external systems.

**Summary of tasks**

In this section, you’ll learn how to create environment variables and connection references in your solution.

**Scenario:** Configure your environment by anticipating future values that will differ across development, testing, and production deployments.

#### Step-by-step instructions

1. Open the solution you created in Use Case #1.
2. Select **New**, then go to **More** and choose **Environment variable**.
3. In **Name**, enter: `Custom Knowledge Endpoint`
4. In **Data Type**, select **Text**.
5. For the value, use: [https://aka.ms/MCSWorkshopLabAssets](https://aka.ms/MCSWorkshopLabAssets)
6. Click **Save**.

> 💡 **Pro Tip:** Environment variables can also be of type **Secret** to retrieve secure values like API keys from Azure Key Vault at runtime.

7. In the solution, select **New**, then go to **More** and choose **Connection reference**.
8. Use the connector name (e.g., **MSN Weather**) as the name. Optionally, prefix with your project name (e.g., `[MCS Training] MSN Weather`).
9. Select the connector (e.g., **MSN Weather**).
10. In the connection dropdown, choose **New connection** if none exists.
11. Log in through Power Apps in a new tab if needed, then return to Copilot Studio.
12. Refresh and select the newly created connection.
13. If the **Create** button is grayed out, type an extra character in the display name field.
14. Repeat steps for the following connectors:

    * Microsoft Dataverse
    * SharePoint
    * ServiceNow (Basic Authentication, values provided in [https://aka.ms/MCSWorkshopLabAssets](https://aka.ms/MCSWorkshopLabAssets))

#### Test your understanding

* Did you use meaningful names for environment variables and connections?
* Can you easily identify which settings change per environment?
* Are your connections reusable for CI/CD automation?

**Challenge: Apply this to your own use case**

* What settings in your agent should vary between environments?
* How will you name variables and references to avoid confusion across teams?
* Try creating a **Secret**-type variable referencing a value in Azure Key Vault.

---

### 🔄 Use Case #3: Set up Git source control

Connect your solution to Azure DevOps Git to track changes and prepare for CI/CD—no code required.

**Summary of tasks**

In this section, you’ll learn how to create a new project in Azure DevOps, initialize a branch, and connect it to your Copilot Studio environment.

**Scenario:** You want to track changes to your Copilot Studio agents in source control, collaborate with your team, and prepare for automated deployment pipelines.

#### Step-by-step instructions

1. Navigate to [Azure DevOps](https://aka.ms/MCSWorkshopADO) and log in.

   > First-time users may need to confirm their user’s fictitious name and country.
2. Create a project with your fictitious user's name.
3. Select **Create project**.
4. After project creation, go to **Repos** → **Branches**.
5. Select **Initialize** to create the `main` branch with a README or .gitignore.

> 🎉 You’ve set up the Git repo! Now return to Microsoft Copilot Studio.

6. Go back to [Microsoft Copilot Studio](https://aka.ms/MCSStart) and open the **Solutions** page.
7. In the menu, select **Connect to Git**.
8. Set **Connection type** to `Solution`.
9. Choose the **CopilotStudioTraining** organization and your newly created project.
10. Set the **Root Git folder** to `Solutions`.
11. Select **Next**, then pick the solution created in Use Case #1.
12. When prompted for the branch, select **Create new branch** and name it `dev`.
13. Click **Save** and then **Connect**.

#### Test your understanding

* Can you see your solution files in Azure DevOps?
* Can you track history and commit changes?
* Can you create new branches for testing changes?

**Challenge: Apply this to your own use case**

* Explore branching strategies (e.g., main/dev/feature).
* How will your team review and merge changes?
* How could this integrate with deployment pipelines later?
