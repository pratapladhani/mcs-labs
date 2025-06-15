# Deploy with confidence: Power Platform pipelines & ALM

Master the deployment of your Microsoft Copilot Studio agents across environments using Power Platform pipelines. Learn the complete lifecycle from development to production.

---

## 🧭 Lab Details

| Level | Persona | Duration | Purpose |
| ----- | ------- | -------- | ------- |
| 300   | Maker/Admin | 30 minutes | After completing this lab, participants will be able to deploy Microsoft Copilot Studio solutions across environments using Power Platform pipelines, understand post-deployment configuration requirements, and manage source control integration. They will learn to identify solution-aware vs non-solution-aware settings and establish robust deployment practices. |

---

## 📚 Table of Contents

- [Why Master ALM Deployment?](#-why-master-alm-deployment)
- [Introduction](#-introduction)
- [Core Concepts Overview](#-core-concepts-overview)
- [Documentation and Additional Training Links](#-documentation-and-additional-training-links)
- [Prerequisites](#-prerequisites)
- [Summary of Targets](#-summary-of-targets)
- [Use Cases Covered](#-use-cases-covered)
- [Instructions by Use Case](#️-instructions-by-use-case)
  - [Use Case #1: Create Power Platform pipelines for deployment](#-use-case-1-create-power-platform-pipelines-for-deployment)
  - [Use Case #2: Deploy and configure post-deployment steps](#-use-case-2-deploy-and-configure-post-deployment-steps)
  - [Use Case #3: Commit changes and understand source control structure](#-use-case-3-commit-changes-and-understand-source-control-structure)

---

## 🤔 Why Master ALM Deployment?

**Ready to move beyond development?** You've built amazing agents in your dev environment, but now you need to deploy them safely and consistently to test and production environments.

Think of deployment pipelines as your quality assurance assembly line:
- **Without pipelines**: Manual exports, forgotten configurations, "it worked in dev" syndrome
- **With pipelines**: Automated, consistent, auditable deployments with proper validation

**Common deployment challenges solved by proper ALM:**
- "My agent works perfectly in dev but breaks in production"
- "I forgot to configure the authentication settings after deployment"
- "Someone deployed directly to production and bypassed testing"
- "I can't track what changed between versions"

**This lab transforms deployment from a risky manual process into a confident, repeatable workflow!**

---

## 🌐 Introduction

Application Lifecycle Management (ALM) deployment ensures your solutions move safely and consistently from development through testing to production. This lab builds on ALM foundations to implement automated deployment pipelines and understand the complete deployment lifecycle.

**Real-world example:** Your customer service agent is ready for production, but deployment involves:
1. Exporting the solution as managed
2. Importing to test environment for validation
3. Configuring environment-specific settings
4. Testing functionality end-to-end
5. Promoting to production with proper approvals
6. Configuring production-specific security and channels

With Power Platform pipelines, this becomes an automated, governed process with built-in approvals and validation!

---

## 🎓 Core Concepts Overview

| Concept | Why it matters |
|---------|----------------|
| **Power Platform pipelines** | Democratized ALM automation that brings CI/CD capabilities into the service in a manner that's approachable for all makers, admins, and developers. Significantly reduces effort and domain knowledge previously required for healthy ALM processes. |
| **Pipeline stages** | Sequential deployment environments (Development → Test → Production) that solutions must pass through in order, preventing bypass of QA processes and ensuring proper validation at each stage. |
| **Service principal deployments** | Option to deploy using service principal identity instead of the requesting maker's identity for consistent ownership and automation scenarios. |
| **Pipeline host** | The environment where pipeline configuration and deployment artifacts are stored. Automatically exports and stores both managed and unmanaged solutions for every deployment. |
| **Solution artifacts** | Exported solutions that remain unchanged throughout the pipeline, ensuring the same tested artifact moves through all stages without tampering or modification. |
| **Managed vs Unmanaged Solutions** | Managed solutions are read-only deployments for downstream environments (test/prod). Unmanaged solutions are editable and used only in development. |
| **Solution-aware vs Non-solution-aware** | Some Copilot Studio settings travel with solutions, others require manual post-deployment configuration. Understanding this distinction is critical for successful deployments. |
| **Managed Environments** | Governance feature that enforces managed solution deployments and prevents unauthorized customizations in target environments. |

---

## 📄 Documentation and Additional Training Links

* [Overview of pipelines in Power Platform](https://learn.microsoft.com/power-platform/alm/pipelines)
* [Set up pipelines in Power Platform](https://learn.microsoft.com/power-platform/alm/set-up-pipelines)
* [Deploy solutions using pipelines](https://learn.microsoft.com/power-platform/alm/run-pipeline)
* [Copilot Studio deployment guide](https://learn.microsoft.com/copilot-studio/publish-deploy)
* [Extend pipelines in Power Platform](https://learn.microsoft.com/power-platform/alm/extend-pipelines)
* [Managed environments and governance](https://learn.microsoft.com/power-platform/admin/managed-environment-overview)

---

## ✅ Prerequisites

* Completion of the "Set yourself up for success" lab with a solution containing environment variables and connection references.
* Access to multiple Power Platform environments (DEV, TEST, PROD) with appropriate security roles.
* System Administrator or **Deployment Pipeline Administrator** security role to configure pipelines.
* Azure DevOps project with Git integration already established.
* TEST and PROD environments must be enabled as **Managed Environments** (enforced in lab setup).

---

## 🎯 Summary of Targets

In this lab, you'll implement a complete ALM deployment process for Microsoft Copilot Studio using Power Platform pipelines. By the end of the lab, you will:

* Create and configure Power Platform pipelines for automated deployment across environments.
* Deploy solutions from DEV to TEST and PROD environments using managed solutions.
* Understand delegated deployments and approval workflows.
* Identify and complete post-deployment configuration steps for non-solution-aware settings.
* Experience the benefits of Managed Environment governance in preventing unauthorized customizations.
* Commit changes to source control and understand the structure of unpacked solutions.

---

## 🧩 Use Cases Covered

| Step | Use Case | Value added | Effort |
|------|----------|-------------|--------|
| 1 | [Create Power Platform pipelines for deployment](#-use-case-1-create-power-platform-pipelines-for-deployment) | Automate with confidence – Set up governed, repeatable deployment workflows that democratize ALM for all makers while maintaining security and control through platform governance. | 10 min |
| 2 | [Deploy and configure post-deployment steps](#-use-case-2-deploy-and-configure-post-deployment-steps) | Deploy completely – Execute deployments and handle the critical post-deployment configurations that ensure your agents work properly in target environments. | 15 min |
| 3 | [Commit changes and understand source control structure](#-use-case-3-commit-changes-and-understand-source-control-structure) | Track and structure – Use Git integration to maintain deployment history and understand how solution components are organized in source control. | 5 min |

---

## 🛠️ Instructions by Use Case

---

## 🚀 Use Case #1: Create Power Platform pipelines for deployment

Set up automated deployment pipelines that democratize ALM while maintaining proper governance and security through platform controls.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Create Power Platform pipelines for deployment | Automate with confidence – Set up governed, repeatable deployment workflows that democratize ALM for all makers while maintaining security and control. | 10 minutes |

**Summary of tasks**

In this section, you'll learn how to create Power Platform pipelines, configure deployment stages, and set up automated deployments for controlled releases.

**Scenario:** You have a solution ready in DEV and need to establish an automated process to deploy it through TEST to PROD environments with minimal effort and maximum consistency.

### Objective

Create a deployment pipeline that automates solution deployment across environments with proper validation and governance controls.

---

### Step-by-step instructions

#### Access Power Platform pipelines

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).

2. In the left navigation, select **Pipelines**.

3. Select **+ New pipeline**.

#### Configure pipeline basics

4. Enter a **Name** for your pipeline (e.g., "Copilot Studio Agent Deployment").

5. Set **Description** to explain the pipeline's purpose (e.g., "Automated deployment of customer service agents from DEV through TEST to PROD").

#### Set up deployment stages

6. Configure the **Development** stage:
   - Select your DEV environment
   - Set **Environment type** to "Development Environment"
   - This is where makers will initiate deployments

7. Add **Test** stage:
   - Select **+ Add stage**
   - Choose your TEST environment
   - Set **Environment type** to "Target Environment"

8. Add **Production** stage:
   - Select **+ Add stage**
   - Choose your PROD environment  
   - Set **Environment type** to "Target Environment"

#### Configure deployment settings

9. Under **Advanced settings** for TEST and PROD stages:
   - Configure **Deploy with service principal** (if desired for consistent ownership)
   - Configure **Connection references** to "Update on import"
   - Configure **Environment variables** to "Update on import"

> [!IMPORTANT]
> Pipelines automatically deploy solutions as managed to target environments. This ensures clean deployments and prevents unauthorized customizations, especially important in Managed Environments.

10. Select **Create** to save the pipeline.

#### Verify pipeline access

11. Navigate to your DEV environment in [Copilot Studio](https://copilotstudio.microsoft.com/).

12. Open your solution and confirm you can see the pipeline option.

> [!NOTE]
> Pipelines can only be viewed and run from unmanaged solutions in development environments. They won't appear in the default solution, managed solutions, or target environments.

---

###  🏅 Congratulations! You've created your deployment pipeline!

---

### Test your understanding

**Key takeaways:**

* **Democratized ALM** – Pipelines make sophisticated deployment processes accessible to all makers without requiring deep ALM knowledge.
* **Automatic governance** – Solutions are automatically exported as managed for target environments, preventing unauthorized changes.
* **Sequential validation** – Solutions must pass through pipeline stages in order, ensuring proper testing and approval workflows.
* **Built-in safeguards** – Pipeline artifacts can't be tampered with, ensuring the same tested solution moves through all stages.

**Lessons learned & troubleshooting tips:**

* Ensure you have **Deployment Pipeline Administrator** role to create pipelines.
* Target environments must be Managed Environments for governance enforcement.
* Pipelines are only visible from development environments, not target environments.

---

---

## 🔧 Use Case #2: Deploy and configure post-deployment steps

Execute pipeline deployments and complete the critical post-deployment configurations for non-solution-aware settings.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Deploy and configure post-deployment steps | Deploy completely – Execute deployments and handle the critical post-deployment configurations that ensure your agents work properly in target environments. | 15 minutes |

**Summary of tasks**

In this section, you'll run your pipeline deployment, experience the maker-friendly deployment process, and learn to identify and complete post-deployment configuration steps that aren't handled automatically.

**Scenario:** Deploy your solution to TEST environment using the intuitive pipeline interface and configure the settings that don't travel with solutions.

### Objective

Successfully deploy a solution through pipelines and complete all necessary post-deployment configurations to ensure full functionality in target environments.

---

### Step-by-step instructions

#### Initiate pipeline deployment from development environment

1. In your DEV environment, navigate to [Copilot Studio](https://copilotstudio.microsoft.com/).

2. Open the **solution** you created in the previous lab.

3. In the solution, select **Deploy** from the command bar.

4. Choose your pipeline from the available options.

5. Review the **pre-deployment validation**:
   - Missing dependencies are detected automatically
   - Connection references and environment variables are validated
   - Any issues are flagged before deployment begins

#### Configure deployment settings

6. Review and configure **connection references**:
   - Select appropriate connections for the target environment
   - Create new connections if needed
   - Pipelines validate connections before deployment starts

7. Review **environment variables**:
   - Confirm values are appropriate for the target environment
   - Update any environment-specific settings
   - Notice how this prevents manual post-processing steps

8. Select **Deploy** to submit the deployment request.

> [!NOTE]
> The solution is exported immediately when you submit the deployment request. The same solution artifact will be used for all subsequent stages in the pipeline.

#### Monitor deployment progress

9. Monitor the deployment status in the pipeline interface.

10. Observe how the deployment progresses through each configured stage automatically.

11. Review the deployment history and artifacts stored in the pipeline host.

#### Identify and configure non-solution-aware settings

11. Navigate to your TEST environment in [Copilot Studio](https://copilotstudio.microsoft.com/).

12. Open the deployed solution and observe what transferred successfully.

> [!IMPORTANT]
> The following Copilot Studio settings are **NOT solution-aware** and require manual post-deployment configuration:
> 
> * **Azure Application Insights settings**
> * **Manual authentication settings** 
> * **Direct Line / Web channel security settings**
> * **Deployed channels**
> * **Sharing (with other makers, or with end-users)**

#### Configure authentication (if applicable)

13. If your agent uses manual authentication:
    - Go to **Settings** > **Security** > **Authentication**
    - Reconfigure authentication providers for the TEST environment
    - Update any environment-specific URLs or client IDs

#### Configure channels

14. Set up required channels:
    - Navigate to **Channels** in your agent
    - Configure **Teams**, **Web**, or other channels as needed
    - Update channel-specific security settings

#### Configure sharing permissions

15. Set appropriate sharing:
    - Go to **Settings** > **Security** > **Access**
    - Share with appropriate makers and users for the TEST environment
    - Apply proper security groups or individual permissions

#### Validate deployment in managed environment

16. Attempt to make direct customizations in the TEST environment:
    - Notice how Managed Environment governance prevents unmanaged customizations
    - Confirm that only managed solution updates are allowed
    - This ensures deployment integrity and prevents unauthorized changes

#### Test functionality

17. Validate your agent functionality:
    - Verify all topics work correctly
    - Test connection references and environment variables
    - Validate any integrations with external systems
    - Confirm authentication flows (if configured)

#### Deploy to production

18. Proceed with deployment to PROD through the pipeline interface.

19. Repeat post-deployment configuration steps for the PROD environment.

20. Notice how the **same solution artifact** is deployed to PROD that was tested in TEST.

---

###  🏅 Congratulations! You've successfully deployed through pipelines!

---

### Test your understanding

**Key takeaways:**

* **Maker-friendly experience** – Pipelines provide an intuitive deployment experience that doesn't require ALM expertise.
* **Automatic validation** – Pre-deployment validation prevents common mistakes and improves success rates.
* **Non-solution-aware settings** – Always have a checklist of manual configuration steps required after deployment.
* **Managed Environment protection** – Governance automatically prevents unauthorized customizations in target environments.
* **Artifact integrity** – The same tested solution moves through all pipeline stages without modification.

**Challenge: Apply this to your own use case**

* Create a post-deployment checklist specific to your agents and connectors.
* Document environment-specific settings that need manual configuration.
* Establish testing procedures to validate deployment success in each environment.

---

---

## 📝 Use Case #3: Commit changes and understand source control structure

Use Git integration to track deployment changes and understand how Power Platform solution components are organized in source control.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Commit changes and understand source control structure | Track and structure – Use Git integration to maintain deployment history and understand how solution components are organized in source control. | 5 minutes |

**Summary of tasks**

In this section, you'll commit your deployment artifacts to source control and explore how Power Platform solutions are structured in Git repositories.

**Scenario:** Document your deployment process and understand how solution components are versioned and tracked in source control for future pipeline extensions.

### Objective

Commit deployment artifacts to Git and understand the structure of unpacked Power Platform solutions in source control.

---

### Step-by-step instructions

#### Access source control in Copilot Studio

1. Return to your DEV environment in [Copilot Studio](https://copilotstudio.microsoft.com/).

2. Open your solution and navigate to **Source control**.

3. Review any uncommitted changes from pipeline configuration or deployment preparation.

#### Commit pipeline deployment changes

4. Select any modified components that should be committed.

5. Add a meaningful commit message: "Pipeline deployment: Production-ready configuration with automated ALM"

6. Select **Commit** to save changes to your branch.

#### Explore solution structure in Azure DevOps

7. Navigate to your Azure DevOps project and browse to **Repos**.

8. Explore the **Solutions** folder structure:
   ```
   Solutions/
   ├── [SolutionName]/
   │   ├── CanvasApps/
   │   ├── ConnectionReferences/
   │   ├── EnvironmentVariables/
   │   ├── Workflows/
   │   ├── Other/
   │   │   └── Copilot/
   │   └── SolutionPackage/
   ```

#### Understand component organization

9. Examine key folders:
   - **ConnectionReferences/**: Contains connection reference definitions used by pipelines
   - **EnvironmentVariables/**: Contains environment variable definitions and values
   - **Workflows/**: Contains Power Automate flows (if any)
   - **Other/Copilot/**: Contains Copilot Studio agents and components
   - **SolutionPackage/**: Contains the overall solution metadata

10. Open a component file to see the XML structure that defines Power Platform components.

11. Notice how this structure enables:
    - Granular tracking of changes to individual components
    - Easy integration with other CI/CD tools and processes
    - Professional development workflows for larger teams

#### Review deployment history

12. Go to **Repos** > **Commits** to see your deployment history.

13. Compare commits to understand what changes between deployments.

14. Use the diff view to see exactly what components were modified.

#### Document pipeline extension opportunities

15. In your Azure DevOps project, go to **Repos** > **Files**.

16. Create a new file called `PIPELINE_EXTENSIONS.md` in the root directory.

17. Document potential pipeline extensions:
    - Integration with Azure DevOps build pipelines
    - Automated testing workflows
    - Custom approval processes using Power Automate
    - Integration with GitHub or other CI/CD tools

> [!TIP]
> Pipelines can be extended using Power Platform CLI commands and integrated with professional development workflows. The source control structure enables these advanced scenarios.

---

###  🏅 Congratulations! You've mastered ALM deployment with pipelines and source control!

---

### Test your understanding

**Key takeaways:**

* **Professional ALM made accessible** – Pipelines democratize sophisticated deployment processes while maintaining professional standards.
* **Source control enables extension** – The Git integration provides the foundation for advanced CI/CD scenarios when needed.
* **Structured component organization** – Understanding the folder structure helps with troubleshooting and enables pipeline extensions.

**Challenge: Apply this to your own use case**

* Plan how you might extend pipelines with Power Platform CLI for advanced scenarios.
* Design branching strategies that work with pipeline deployment workflows.
* Consider how to integrate pipelines with existing organizational CI/CD processes.

---

## 🏆 Summary of learnings

**ALM golden rules reinforced:**

✅ **Work in the context of solutions** – Pipelines require properly structured solutions for deployment automation.

✅ **Create separate solutions only if you need to deploy components independently** – Pipelines work best with cohesive solution packaging.

✅ **Use a custom publisher and prefix** – Maintains clear ownership in automated deployment scenarios.

✅ **Use environment variables for settings and secrets that change across environments** – Pipelines validate and update these automatically during deployment.

✅ **Export and deploy solutions as managed, unless setting up a dev environment** – Pipelines automatically handle this, ensuring governance and preventing unauthorized changes.

✅ **Don't do customizations outside of dev** – Managed Environments enforce this rule, blocking unmanaged customizations in target environments.

✅ **Consider automating ALM for source control and automated deployments** – Pipelines provide this automation while remaining extensible for advanced scenarios.

> [!IMPORTANT]
> **Critical reminder about non-solution-aware settings:**
> 
> These Copilot Studio settings require manual post-deployment configuration:
> * **Azure Application Insights settings**
> * **Manual authentication settings**
> * **Direct Line / Web channel security settings** 
> * **Deployed channels**
> * **Sharing (with other makers, or with end-users)**
> 
> Always include these in your post-deployment checklist!

> [!NOTE]
> **Managed Environment governance in your lab:**
> Your TEST and PROD environments use Managed Environment governance to enforce that solutions are managed and unmanaged customizations are blocked. This ensures deployment integrity and prevents unauthorized changes outside of the pipeline process.

---

### Conclusions and recommendations

**Pipeline deployment excellence principles:**

* **Democratize with governance** – Use pipelines to make ALM accessible to all makers while maintaining enterprise-grade security and control.
* **Validate early and often** – Leverage pipeline pre-deployment validation to catch issues before they impact target environments.
* **Automate the repeatable, manage the exceptions** – Let pipelines handle standard deployment tasks while maintaining checklists for non-solution-aware settings.
* **Extend when needed** – Start with pipelines for core deployment, then extend with CLI and CI/CD tools for advanced scenarios.
* **Trust but verify** – Use Managed Environments to enforce governance while providing makers the flexibility to deploy through approved channels.

By mastering Power Platform pipelines, you've established a deployment process that combines the accessibility makers need with the governance and automation enterprises require. Your deployments are now predictable, auditable, and scalable—setting the foundation for confident production releases at any scale.

---