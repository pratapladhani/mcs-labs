# Set yourself up for success & discover ALM best practices

Build agents with confidence. Deploy with control. Master the lifecycle of your Microsoft Copilot Studio agents with best practices.

---

## 🧭 Lab Details

| Level | Persona | Duration   | Purpose |
| ----- | ------- | ---------- | ------- |
| 200   | Maker   | 20 minutes | After completing this lab, participants will be able to apply Application Lifecycle Management (ALM) best practices to their Microsoft Copilot Studio solutions. They will know how to structure their work using solutions and publishers, configure environment variables and connection references for deployment readiness, and set up Git-based source control using Azure DevOps—all without writing code. |

[⬆️ Back to top](#set-yourself-up-for-success--discover-alm-best-practices)

---

## 🔍 Introduction

Application Lifecycle Management (ALM) ensures that your solutions evolve safely and efficiently as they move from development to production. This lab will walk you through the foundational best practices of ALM in Microsoft Copilot Studio—from structuring your solution to managing configurations and source control.

---

## 🧠 Core Concepts Overview

| Concept               | Why it matters                                                                 |
|-----------------------|--------------------------------------------------------------------------------|
| **Solution**             | A standard way in Microsoft Power Platform to package and ship components—including Microsoft Copilot Studio agent components like topics, knowledge sources, and tools—across environments alongside flows, prompts, environment variables, connections references, and any other solution-aware component types. |
| **Publisher**            | A metadata element that identifies the creator of solution components. Using a custom publisher improves traceability and supports cleaner prefixes in naming conventions. |
| **Environment variables** | Replace hardcoded values with configurable parameters that adapt to each environment (e.g., dev/test/prod) during solution deployment. |
| **Connection references** | Allow connectors in your agents, flows, or apps, to reuse connection settings across environments without manual reconfiguration. |
| **Source control**        | Use Git integration with Azure DevOps to track your entire agent configuration in a code repository, track changes, ease collaboration, and setup processes to merge cross-team contributions efficiently. |

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

| Term                 | Definition |
| -------------------- | ---------- |
| Solution             | A container in Power Platform that groups related components (like agents, flows, environment variables) for better organization, deployment, and lifecycle management. Microsoft Copilot Studio agents (including topics, knowledge, tools) are solution-aware components that can be deployed across environments. |
| Publisher            | A label associated with your solution components. Using a custom publisher helps track ownership and apply consistent naming prefixes. |
| Environment          | A workspace in Power Platform where apps, agents, and data reside. ALM best practices often involve multiple environments (e.g., dev, test, prod) for structured deployments. |
| Environment variable | A reusable setting (like a URL or key) that can vary between environments without modifying individual components. |
| Connection reference | An abstraction that links connectors (e.g., SharePoint, Dataverse) to credentials and environment-specific settings—allowing reuse and cleaner ALM processes. |
| Managed solution     | A read-only version of a solution used for deployment to downstream environments (test, prod). Managed solutions support clean, controlled updates. |
| Unmanaged solution   | Editable solutions used in development environments. Changes in unmanaged solutions can be exported, versioned, and eventually deployed as managed. |
| Solution-aware       | A component or setting that is included in a solution and can be moved across environments as part of it. Not all Microsoft Copilot Studio settings are solution-aware. |
| Source control       | The practice of tracking and managing changes to your assets over time. In Power Platform, Git integration with Azure DevOps or GitHub helps enable collaboration, auditing, and automation. |
| CI/CD                | A practice of automating the build, testing, and deployment of solutions using tools like Azure DevOps pipelines or GitHub Actions. |

---

## 🧩 Use Cases Covered

| Step | Use Case | Value added | Effort |
|------|----------|-------------|--------|
| 1 | Create a solution and custom publisher | Structure your success – Group, manage, and deploy all your agent assets with clarity and control. | 5 min |
| 2 | Create environment variables and connection references | Adapt with flexibility – Future-proof your agents for seamless multi-environment deployments. | 5 min |
| 3 | Set up Git source control | Track and evolve – Use Git to version, review, and automate deployment of your agent assets. | 10 min |

---

## 🛠️ Instructions by Use Case

### 🧱 Use Case #1: Create a solution and custom publisher

**Why this matters:** Without structure, agents become hard to track. Solutions allow for modular, controlled, and reusable agent deployment.

#### Step-by-step instructions

1. Go to [Microsoft Copilot Studio](https://aka.ms/MCSStart) and ensure you're in the right environment.
2. Navigate to the Solutions section.
3. Create a new solution. Name it clearly and generically (e.g., not 'DEV').
4. Create a custom publisher with your organization’s name and a unique prefix.
5. Set the new solution as your default.

#### Test your understanding

- Why should solution names be environment-agnostic?
- What benefits do custom publishers provide?

#### Challenge

- Apply this to your own project: What name would you give your solution? What publisher prefix would you use?

---

### 🧩 Use Case #2: Create environment variables and connection references

**Why this matters:** Deploying the same solution across environments requires portability. Environment variables and connection references make that possible.

#### Step-by-step instructions

1. Open the solution from Use Case #1.
2. Create environment variables (e.g., name: `Custom Knowledge Endpoint`, type: Text).
3. Add connection references for MSN Weather, Dataverse, SharePoint, and ServiceNow.

> [!TIP]
> Use Basic Authentication for ServiceNow, and ensure connection display names are clean and meaningful.

#### Test your understanding

- Can you update variables for different environments?
- Are your references reusable and clearly named?

---

### 🔄 Use Case #3: Set up Git source control

**Why this matters:** Source control allows versioning, rollback, change tracking, and collaboration.

#### Step-by-step instructions

1. Go to [Azure DevOps](https://aka.ms/MCSWorkshopADO) and create a new project.
2. Initialize the main branch.
3. In Microsoft Copilot Studio, connect your solution to Git.
4. Create a new branch `dev`.

#### Test your understanding

- Are solution files visible in DevOps?
- Can you create a branch and track changes?

---

## 📚 Summary of Learnings

✅ Use solutions to group and manage your agents
✅ Always use a custom publisher with a prefix
✅ Configure variables and references to adapt across environments
✅ Source control ensures transparency, rollback, and collaboration

---

## 📌 Conclusions and Recommendations

**ALM golden rules:**

* Use solutions as containers
* Create separate solutions only when needed
* Use custom publishers
* Favor environment variables and references
* Export as managed solutions for downstream
* Keep all customization within dev
* Automate deployments with pipelines when possible

---

## 📄 Documentation and Additional Training Links

* [ALM overview - Microsoft Power Platform](https://learn.microsoft.com/power-platform/alm/alm-overview)
* [Publish and deploy your agent](https://learn.microsoft.com/copilot-studio/publish-deploy)
* [Webinar: Microsoft Copilot Studio ALM](https://aka.ms/MCSALMWebinar)
* [Environment variables in solutions](https://learn.microsoft.com/power-apps/maker/data-platform/environmentvariables)
* [Connection references in a solution](https://learn.microsoft.com/power-apps/maker/data-platform/create-connection-reference)
* [Dataverse Git integration overview](https://learn.microsoft.com/power-platform/alm/git-version-control)

---

## 💬 Feedback

> [!NOTE]
> We want your feedback! [aka.ms/MCSLabsFeedback](https://aka.ms/MCSLabsFeedback)
