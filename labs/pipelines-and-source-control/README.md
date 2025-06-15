# Deploy agents with confidence: Power Platform pipelines & source control

Master the deployment of your Microsoft Copilot Studio agents across environments using pipelines for Power Platform. Learn the complete lifecycle from development to production.

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
  - [Use Case #1: Create Power Platform Pipelines for deployment](#-use-case-1-create-power-platform-pipelines-for-deployment)
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

With Power Platform Pipelines, this becomes an automated, governed process with built-in approvals and validation!

---

## 🎓 Core Concepts Overview

| Concept | Why it matters |
|---------|----------------|
| **Power Platform Pipelines** | Automated deployment workflows that move solutions between environments with built-in approvals, validation, and governance. Reduces manual errors and ensures consistency. |
| **Managed vs Unmanaged Solutions** | Managed solutions are read-only deployments for downstream environments (test/prod). Unmanaged solutions are editable and used only in development. |
| **Solution-aware vs Non-solution-aware** | Some Copilot Studio settings travel with solutions, others require manual post-deployment configuration. Understanding this distinction is critical for successful deployments. |
| **Post-deployment steps** | Manual configuration required after solution deployment, such as authentication settings, channel configuration, and sharing permissions. |
| **Environment validation** | Testing deployed solutions in target environments to ensure functionality, performance, and security requirements are met. |
| **Deployment gates** | Approval checkpoints in pipelines that ensure proper review and validation before promoting to production environments. |
| **Rollback strategy** | Planned approach for reverting to previous solution versions if issues are discovered post-deployment. |
| **Source control integration** | Tracking all changes in Git to maintain audit trails, enable collaboration, and support automated deployments through CI/CD. |

---

## 📄 Documentation and Additional Training Links

* [Power Platform Pipelines overview](https://learn.microsoft.com/power-platform/alm/pipelines)
* [Deploy solutions using pipelines](https://learn.microsoft.com/power-platform/alm/deploy-solutions-with-pipelines)
* [Copilot Studio deployment guide](https://learn.microsoft.com/copilot-studio/publish-deploy)
* [Solution lifecycle management](https://learn.microsoft.com/power-platform/alm/solution-lifecycle-management)
* [Post-deployment configuration checklist](https://learn.microsoft.com/copilot-studio/configuration-end-user-authentication)
* [Managed environments and governance](https://learn.microsoft.com/power-platform/admin/managed-environment-overview)

---

## ✅ Prerequisites

* Completion of the "Set yourself up for success" lab with a solution containing environment variables and connection references.
* Access to multiple Power Platform environments (DEV, TEST, PROD) with appropriate security roles.
* System Administrator or Environment Admin role to configure pipelines.
* Azure DevOps project with Git integration already established.

---

## 🎯 Summary of Targets

In this lab, you'll implement a complete ALM deployment process for Microsoft Copilot Studio. By the end of the lab, you will:

* Create and configure Power Platform Pipelines for automated deployment.
* Deploy solutions from DEV to TEST and PROD environments using managed solutions.
* Identify and complete post-deployment configuration steps.
* Understand which settings are solution-aware vs. require manual configuration.
* Commit changes to source control and understand the structure of unpacked solutions.
* Establish deployment best practices with proper validation and rollback procedures.

---

## 🧩 Use Cases Covered

| Step | Use Case | Value added | Effort |
|------|----------|-------------|--------|
| 1 | [Create Power Platform Pipelines for deployment](#-use-case-1-create-power-platform-pipelines-for-deployment) | Automate with confidence – Set up governed, repeatable deployment workflows that reduce manual errors and ensure consistency across environments. | 10 min |
| 2 | [Deploy and configure post-deployment steps](#-use-case-2-deploy-and-configure-post-deployment-steps) | Deploy completely – Execute deployments and handle the critical post-deployment configurations that ensure your agents work properly in target environments. | 15 min |
| 3 | [Commit changes and understand source control structure](#-use-case-3-commit-changes-and-understand-source-control-structure) | Track and structure – Use Git integration to maintain deployment history and understand how solution components are organized in source control. | 5 min |

---

## 🛠️ Instructions by Use Case

---

## 🚀 Use Case #1: Create Power Platform Pipelines for deployment

Set up automated deployment pipelines to move solutions safely from development to production.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Create Power Platform Pipelines for deployment | Automate with confidence – Set up governed, repeatable deployment workflows that reduce manual errors and ensure consistency across environments. | 10 minutes |

**Summary of tasks**

In this section, you'll learn how to create Power Platform Pipelines, configure deployment stages, and set up approval gates for controlled releases.

**Scenario:** You have a solution ready in DEV and need to establish an automated, governed process to deploy it through TEST to PROD environments.

### Objective

Create a deployment pipeline that automates solution deployment across environments with proper validation and approval gates.

---

### Step-by-step instructions

#### Access Power Platform Pipelines

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).

2. In the left navigation, select **Pipelines**.

3. Select **+ New pipeline**.

#### Configure pipeline basics

4. Enter a **Name** for your pipeline (e.g., "Copilot Studio Agent Deployment").

5. Set **Description** to explain the pipeline's purpose (e.g., "Automated deployment of customer service agents from DEV through TEST to PROD").

#### Set up deployment stages

6. Configure the **Development** stage:
   - Select your DEV environment
   - Set **Deployment stage type** to "Development"

7. Add **Test** stage:
   - Select **+ Add stage**
   - Choose your TEST environment
   - Set **Deployment stage type** to "Test"
   - Enable **Wait for approval** to require manual validation

8. Add **Production** stage:
   - Select **+ Add stage**
   - Choose your PROD environment  
   - Set **Deployment stage type** to "Production"
   - Enable **Wait for approval** with stricter approval requirements

#### Configure deployment settings

9. Under **Advanced settings**:
   - Enable **Deploy as managed solution** for TEST and PROD stages
   - Set **Connection references** to "Update on import"
   - Set **Environment variables** to "Update on import"

> [!IMPORTANT]
> Always deploy as managed solutions to downstream environments. This ensures clean deployments and prevents unauthorized customizations.

10. Select **Create** to save the pipeline.

---

###  🏅 Congratulations! You've created your deployment pipeline!

---

### Test your understanding

**Key takeaways:**

* **Automation reduces risk** – Pipelines ensure consistent deployment processes and reduce manual errors.
* **Approval gates provide control** – Required approvals ensure proper validation before production deployment.
* **Managed solutions maintain integrity** – Deploying as managed prevents unauthorized changes in downstream environments.

**Lessons learned & troubleshooting tips:**

* Ensure you have appropriate permissions in all target environments.
* Test the pipeline with a simple solution first before deploying complex agents.
* Document approval criteria and assign appropriate approvers for each stage.

---

---

## 🔧 Use Case #2: Deploy and configure post-deployment steps

Execute deployments through your pipeline and complete the critical post-deployment configurations.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Deploy and configure post-deployment steps | Deploy completely – Execute deployments and handle the critical post-deployment configurations that ensure your agents work properly in target environments. | 15 minutes |

**Summary of tasks**

In this section, you'll run your pipeline deployment and learn to identify and complete post-deployment configuration steps that aren't handled automatically.

**Scenario:** Deploy your solution to TEST environment and configure the settings that don't travel with solutions.

### Objective

Successfully deploy a solution and complete all necessary post-deployment configurations to ensure full functionality.

---

### Step-by-step instructions

#### Initiate pipeline deployment

1. In **Power Platform Pipelines**, open the pipeline you created.

2. Select **Run pipeline**.

3. Choose the **solution** you created in the previous lab.

4. Select **Deploy here** for the DEV stage to start the deployment process.

#### Monitor deployment progress

5. Watch the deployment status as it progresses through each stage.

6. When prompted for TEST stage approval, review the deployment details and **Approve**.

7. Monitor the deployment to TEST environment completion.

#### Identify post-deployment requirements

8. Navigate to your TEST environment in [Copilot Studio](https://copilotstudio.microsoft.com/).

9. Open the deployed solution and observe what transferred successfully.

> [!IMPORTANT]
> The following Copilot Studio settings are **NOT solution-aware** and require manual post-deployment configuration:
> 
> * **Azure Application Insights settings**
> * **Manual authentication settings** 
> * **Direct Line / Web channel security settings**
> * **Deployed channels**
> * **Sharing (with other makers, or with end-users)**

#### Configure authentication (if applicable)

10. If your agent uses manual authentication:
    - Go to **Settings** > **Security** > **Authentication**
    - Reconfigure authentication providers for the TEST environment
    - Update any environment-specific URLs or client IDs

#### Configure channels

11. Set up required channels:
    - Navigate to **Channels** in your agent
    - Configure **Teams**, **Web**, or other channels as needed
    - Update channel-specific security settings

#### Configure sharing permissions

12. Set appropriate sharing:
    - Go to **Settings** > **Security** > **Access**
    - Share with appropriate makers and users for the TEST environment
    - Apply proper security groups or individual permissions

#### Validate deployment

13. Test your agent functionality:
    - Verify all topics work correctly
    - Test connection references and environment variables
    - Validate any integrations with external systems
    - Confirm authentication flows (if configured)

#### Deploy to production

14. Return to the pipeline and approve deployment to PROD.

15. Repeat post-deployment configuration steps for the PROD environment.

> [!IMPORTANT]
> In managed environments (like your TEST and PROD labs), the platform enforces that solutions must be managed and blocks unmanaged customizations. This governance ensures deployment integrity and prevents unauthorized changes.

---

###  🏅 Congratulations! You've successfully deployed and configured your solution!

---

### Test your understanding

**Key takeaways:**

* **Not everything travels** – Understanding solution-aware vs. non-solution-aware settings is critical for successful deployments.
* **Post-deployment checklists** – Always have a documented checklist of manual configuration steps required after deployment.
* **Environment-specific settings** – Authentication, channels, and sharing often need environment-specific configuration.
* **Validation is essential** – Always test functionality after deployment before considering it complete.

**Challenge: Apply this to your own use case**

* Create a post-deployment checklist for your specific agents.
* Document environment-specific settings that need manual configuration.
* Establish testing procedures to validate deployment success.

---

---

## 📝 Use Case #3: Commit changes and understand source control structure

Use Git integration to track deployment changes and understand how solution components are organized in source control.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Commit changes and understand source control structure | Track and structure – Use Git integration to maintain deployment history and understand how solution components are organized in source control. | 5 minutes |

**Summary of tasks**

In this section, you'll commit your deployment changes to source control and explore how Power Platform solutions are structured in Git.

**Scenario:** Document your deployment process and understand how solution components are versioned and tracked in source control.

### Objective

Commit deployment artifacts to Git and understand the structure of unpacked Power Platform solutions in source control.

---

### Step-by-step instructions

#### Access source control in Copilot Studio

1. Return to your DEV environment in [Copilot Studio](https://copilotstudio.microsoft.com/).

2. Open your solution and navigate to **Source control**.

3. Review any uncommitted changes from pipeline configuration or deployment preparation.

#### Commit deployment changes

4. Select any modified components that should be committed.

5. Add a meaningful commit message: "Pipeline deployment: Added production-ready configuration"

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
   │   └── SolutionPackage/
   ```

#### Understand component organization

9. Examine key folders:
   - **ConnectionReferences/**: Contains connection reference definitions
   - **EnvironmentVariables/**: Contains environment variable definitions and values
   - **Workflows/**: Contains Power Automate flows (if any)
   - **Other/**: Contains Copilot Studio agents and components

10. Open a component file to see the XML structure that defines Power Platform components.

#### Review commit history

11. Go to **Repos** > **Commits** to see your deployment history.

12. Compare commits to understand what changes between deployments.

13. Use the diff view to see exactly what components were modified.

#### Create deployment documentation

14. In your Azure DevOps project, go to **Repos** > **Files**.

15. Create a new file called `DEPLOYMENT.md` in the root directory.

16. Document your deployment process, including:
    - Pipeline configuration steps
    - Post-deployment checklist
    - Environment-specific settings
    - Validation procedures

---

###  🏅 Congratulations! You've mastered ALM deployment with source control integration!

---

### Test your understanding

**Key takeaways:**

* **Source control provides auditability** – Every change is tracked and can be reviewed or reverted if needed.
* **Solution structure is standardized** – Understanding the folder structure helps with troubleshooting and customization.
* **Documentation is crucial** – Maintaining deployment documentation ensures knowledge transfer and consistency.

**Challenge: Apply this to your own use case**

* Establish branching strategies for your deployment process (e.g., feature branches, release branches).
* Create deployment documentation templates for your team.
* Set up automated testing that runs before deployment approval.

---

## 🏆 Summary of learnings

**ALM golden rules reinforced:**

✅ **Work in the context of solutions** – Always develop within properly structured solutions for clean deployments.

✅ **Create separate solutions only if you need to deploy components independently** – Avoid solution sprawl by keeping related components together.

✅ **Use a custom publisher and prefix** – Maintain clear ownership and avoid naming conflicts.

✅ **Use environment variables for settings and secrets that change across environments** – Enable portable, configurable deployments.

✅ **Export and deploy solutions as managed, unless setting up a dev environment** – Protect downstream environments from unauthorized changes.

✅ **Don't do customizations outside of dev** – Maintain deployment integrity by keeping all changes in the development environment.

✅ **Consider automating ALM for source control and automated deployments** – Reduce manual errors and improve consistency through automation.

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

---

### Conclusions and recommendations

**Deployment excellence principles:**

* **Automate the repeatable** – Use pipelines for solution deployment while maintaining checklists for manual steps.
* **Validate at every stage** – Test functionality thoroughly in each environment before promotion.
* **Document everything** – Maintain clear documentation of deployment processes and environment-specific configurations.
* **Plan for rollback** – Always have a strategy to revert to previous versions if issues arise.
* **Govern with managed environments** – Use platform governance to enforce managed solution deployments and prevent unauthorized changes.

By mastering these deployment practices, you've established a professional-grade ALM process that scales from simple agents to complex enterprise solutions. Your deployments are now predictable, auditable, and reliable—setting the foundation for confident production releases.

---