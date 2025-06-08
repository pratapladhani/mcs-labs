# Set yourself up for success & discover ALM best practices

Build agents with confidence. Deploy with control. Master the lifecycle of your Microsoft Copilot Studio agents with best practices.

---

## 🧭 Lab Details

| Level | Persona | Duration   | Purpose                                                                                                                                                                                                                                                                                                                                                                                                          |
| ----- | ------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 200   | Maker   | 20 minutes | After completing this lab, participants will be able to apply Application Lifecycle Management (ALM) best practices to their Microsoft Copilot Studio solutions. They will know how to structure their work using solutions and publishers, configure environment variables and connection references for deployment readiness, and set up Git-based source control using Azure DevOps—all without writing code. |

---

## 🔍 Introduction

Application Lifecycle Management (ALM) ensures that your solutions evolve safely and efficiently as they move from development to production. This lab will walk you through the foundational best practices of ALM in Microsoft Copilot Studio—from structuring your solution to managing configurations and source control.

---

## 🧠 Core Concepts Overview

| Concept                   | Why it matters                                                                                                                                                                                                                                                                                                     |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Solution**              | A standard way in Microsoft Power Platform to package and ship components—including Microsoft Copilot Studio agent components like topics, knowledge sources, and tools—across environments alongside flows, prompts, environment variables, connections references, and any other solution-aware component types. |
| **Publisher**             | A metadata element that identifies the creator of solution components. Using a custom publisher improves traceability and supports cleaner prefixes in naming conventions.                                                                                                                                         |
| **Environment variables** | Replace hardcoded values with configurable parameters that adapt to each environment (e.g., dev/test/prod) during solution deployment.                                                                                                                                                                             |
| **Connection references** | Allow connectors in your agents, flows, or apps, to reuse connection settings across environments without manual reconfiguration.                                                                                                                                                                                  |
| **Source control**        | Use Git integration with Azure DevOps to track your entire agent configuration in a code repository, track changes, ease collaboration, and setup processes to merge cross-team contributions efficiently.                                                                                                         |

---

## ✅ Prerequisites

* A Microsoft Copilot Studio environment.
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

## 📘 Glossary

| Term                 | Definition                                                                                                                                                                                                                                                                                                           |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Solution             | A container in Power Platform that groups related components (like agents, flows, environment variables) for better organization, deployment, and lifecycle management. Microsoft Copilot Studio agents (including topics, knowledge, tools) are solution-aware components that can be deployed across environments. |
| Publisher            | A label associated with your solution components. Using a custom publisher helps track ownership and apply consistent naming prefixes.                                                                                                                                                                               |
| Environment          | A workspace in Power Platform where apps, agents, and data reside. ALM best practices often involve multiple environments (e.g., dev, test, prod) for structured deployments.                                                                                                                                        |
| Environment variable | A reusable setting (like a URL or key) that can vary between environments without modifying individual components.                                                                                                                                                                                                   |
| Connection reference | An abstraction that links connectors (e.g., SharePoint, Dataverse) to credentials and environment-specific settings—allowing reuse and cleaner ALM processes.                                                                                                                                                        |
| Managed solution     | A read-only version of a solution used for deployment to downstream environments (test, prod). Managed solutions support clean, controlled updates.                                                                                                                                                                  |
| Unmanaged solution   | Editable solutions used in development environments. Changes in unmanaged solutions can be exported, versioned, and eventually deployed as managed.                                                                                                                                                                  |
| Solution-aware       | A component or setting that is included in a solution and can be moved across environments as part of it. Not all Microsoft Copilot Studio settings are solution-aware.                                                                                                                                              |
| Source control       | The practice of tracking and managing changes to your assets over time. In Power Platform, Git integration with Azure DevOps or GitHub helps enable collaboration, auditing, and automation.                                                                                                                         |
| CI/CD                | A practice of automating the build, testing, and deployment of solutions using tools like Azure DevOps pipelines or GitHub Actions.                                                                                                                                                                                  |

---

## 🧩 Use Cases Covered

| Step | Use Case                                               | Value added                                                                                                                                                                             | Effort |
| ---- | ------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| 1    | Create a solution and custom publisher                 | Structure your success – Group, manage, and deploy all your agent assets with clarity and control.                                                                                      | 5 min  |
| 2    | Create environment variables and connection references | Adapt with flexibility – Environment variables future-proof your agents for seamless multi-environment deployments. Manage credentials and services cleanly across dev, test, and prod. | 5 min  |
| 3    | Set up Git source control                              | Track and evolve – Use Git to version, review, and automate deployment of your agent assets.                                                                                            | 10 min |

---

## 🛠️ Instructions by Use Case

### 🧱 Use Case #1: Create a solution and custom publisher

Use a structured container to group all agent components for better lifecycle management.

**Summary of tasks**

In this section, you’ll learn how to access the Solutions area of Microsoft Copilot Studio, create a new solution, create a new publisher, and set the solution as default.

**Scenario:** Properly set up your development environment so you can later package and deploy your agents across environments.

#### Step-by-step instructions

1. Navigate to the [Copilot Studio home page](https://aka.ms/MCSStart).
2. Ensure you are in the expected environment by checking the environment name in the top-right corner.
3. Go to the Solutions menu (left-hand nav under the ellipsis `...`) and select **New solution**.
4. Provide a display name. Avoid tying the name to an environment or development stage (e.g., avoid 'DEV' or 'POC'). Use a descriptive name like your project name. For this lab, use **Workshop Agents**.
5. If this is your first time creating a solution in this environment, create a new **Publisher**. This can be your organization’s name. Choose a prefix used in technical names.
6. Set this solution as your **preferred solution** to ensure all new components default to it.
7. Click **Create** when ready.

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
