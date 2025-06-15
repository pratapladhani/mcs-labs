# Autonomous Support Agent - Unlock new levels of productivity with AI automation

Let AI do the work and automate processes more easily than ever with autonomous agents that handle user support inquiries automatically.

---

## 🧭 Lab Details

| Level | Persona | Duration | Purpose |
| ----- | ------- | -------- | ------- |
| 200 | Maker/Developer | 20 minutes | After completing this lab, participants will be able to create autonomous agents that automatically respond to user emails, provide guidance from knowledge bases, and integrate with ServiceNow for ticket management. You'll learn how to configure triggers, add knowledge sources, and integrate external tools for comprehensive automated support. |

---

## 📚 Table of Contents

- [Why This Matters](#-why-this-matters)
- [Introduction](#-introduction)
- [Core Concepts Overview](#-core-concepts-overview)
- [Documentation and Additional Training Links](#-documentation-and-additional-training-links)
- [Prerequisites](#-prerequisites)
- [Summary of Targets](#-summary-of-targets)
- [Use Cases Covered](#-use-cases-covered)
- [Instructions by Use Case](#️-instructions-by-use-case)
  - [Use Case #1: Create and Configure an Autonomous Agent](#-use-case-1-create-and-configure-an-autonomous-agent)
  - [Use Case #2: Add Knowledge and Tools Integration](#-use-case-2-add-knowledge-and-tools-integration)

---

## 🤔 Why This Matters

**IT Support Teams and Makers** - Tired of manually responding to repetitive support emails and constantly checking ticket statuses?

Think of a traditional help desk:
- **Without autonomous agents**: Support staff manually reads every email, searches knowledge bases, checks ticket systems, and crafts individual responses - consuming hours of valuable time
- **With autonomous agents**: AI automatically processes incoming emails, searches your knowledge base, retrieves ticket information, and sends comprehensive responses in seconds

**Common challenges solved by this lab:**
- "Our support team spends too much time on routine email inquiries"
- "Users have to wait hours for simple password reset instructions"
- "We can't scale our support to handle increasing ticket volumes"
- "Checking ticket statuses across systems is time-consuming and error-prone"

**In just 20 minutes, you'll transform how your organization handles support requests, freeing your team to focus on complex issues that truly need human expertise.**

---

## 🌐 Introduction

Customer support automation has become essential for organizations looking to scale their operations while maintaining high service quality. Manual email responses and ticket lookups create bottlenecks that frustrate both support staff and end users.

**Real-world example:** A mid-sized company receives 200+ support emails daily asking about password resets, ticket statuses, and common troubleshooting steps. Without automation, their 3-person support team spends 60% of their time on these routine inquiries, leaving complex issues unaddressed and creating long response times.

After implementing autonomous agents, the same company now handles 80% of routine inquiries automatically, with instant responses that include personalized ticket updates and relevant knowledge base articles. The support team can focus on strategic initiatives and complex problem-solving, while user satisfaction increases due to immediate, accurate responses.

---

## 🎓 Core Concepts Overview

| Concept | Why it matters |
|---------|----------------|
| **Autonomous Agents** | Enable 24/7 automated responses to user inquiries, reducing manual workload and improving response times while maintaining consistency in support quality |
| **Email Triggers** | Automatically detect and process incoming support emails, ensuring no request goes unnoticed and enabling immediate response initiation |
| **Knowledge Integration** | Connect agents to your existing documentation and knowledge bases, ensuring responses are accurate, up-to-date, and aligned with your organization's information |
| **ServiceNow Integration** | Provide real-time ticket status updates and incident details directly within email responses, eliminating the need for manual system lookups |
| **Multi-language Support** | Automatically detect and respond in the user's preferred language, improving global support accessibility and user experience |

---

## 📄 Documentation and Additional Training Links

* [Microsoft Copilot Studio Documentation](https://learn.microsoft.com/en-us/microsoft-copilot-studio/)
* [Building Autonomous Agents with Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-autonomous-agents)
* [ServiceNow Connector Documentation](https://learn.microsoft.com/en-us/connectors/service-now/)
* [Office 365 Outlook Connector](https://learn.microsoft.com/en-us/connectors/office365/)
* [Copilot Studio Triggers and Actions](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-trigger-actions)

---

## ✅ Prerequisites

* Access to Microsoft Copilot Studio with appropriate licensing
* ServiceNow instance with API access and valid credentials
* Office 365 environment with Outlook integration enabled
* Administrative permissions to create and configure autonomous agents
* A test email account to simulate user interactions

---

## 🎯 Summary of Targets

In this lab, you'll build a complete autonomous support agent that transforms how your organization handles routine support inquiries. By the end of the lab, you will:

* Create and configure an autonomous agent with email triggers for automatic activation
* Integrate knowledge sources to provide accurate, contextual responses to user questions
* Connect ServiceNow for real-time ticket status updates and incident details
* Configure email response tools that reply professionally with proper formatting and citations
* Test the complete workflow with realistic support scenarios and multi-question emails

---

## 🧩 Use Cases Covered

| Step | Use Case | Value added | Effort |
|------|----------|-------------|--------|
| 1 | [Create and Configure an Autonomous Agent](#-use-case-1-create-and-configure-an-autonomous-agent) | Establishes the foundation for automated email processing with intelligent trigger configuration | 10 min |
| 2 | [Add Knowledge and Tools Integration](#-use-case-2-add-knowledge-and-tools-integration) | Connects external knowledge sources and ServiceNow integration for comprehensive automated responses | 10 min |

---

## 🛠️ Instructions by Use Case

---

## 🧱 Use Case #1: Create and Configure an Autonomous Agent

Set up the foundational autonomous agent with email triggers that automatically activates when support emails arrive.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Create and Configure an Autonomous Agent | Establishes the foundation for automated email processing with intelligent trigger configuration | 10 minutes |

**Summary of tasks**

In this section, you'll learn how to create an autonomous agent, configure email triggers, and set up the basic framework for automated support responses.

**Scenario:** Your support team receives dozens of emails daily with questions about password resets, ticket statuses, and general inquiries. You need an intelligent system that can automatically detect these emails and begin processing them without human intervention.

### Objective

Create an autonomous agent that automatically triggers when new support emails arrive and prepare it for knowledge integration and response capabilities.

---

### Step-by-step instructions

#### Creating the Agent and Solution Setup

1. Navigate to the Copilot Studio home page at https://copilotstudio.microsoft.com/

2. Go to the **Solutions** menu (located in the left-hand menu under the ellipsis **…**)

3. Select the solution you had created previously for your labs

4. Select **New** and choose **Agent**

5. Select **Skip to configure** to bypass the initial setup wizard

6. Name your agent **Autonomous Support Agent**

7. Click **Create** to establish your new agent

> [!TIP]
> Choose a descriptive name that clearly identifies the agent's purpose for easier management in larger environments.

#### Configuring Email Triggers

8. In the **Overview** tab, scroll down to the triggers section and click **Add a new Trigger**

9. Search for and select **When a new email arrives (V3)**

10. Click **Next**, then **Continue**, then **Next**, and finally **Create trigger**

> [!IMPORTANT]
> This trigger configuration determines which emails activate your agent. You can refine filters later to target specific email addresses or subject patterns.

11. The trigger is now configured and will automatically activate your agent when new emails arrive

---

###  🏅 Congratulations! You've completed Use Case #1!

---

### Test your understanding

**Key takeaways:**

* **Autonomous Agent Foundation** – You've created the core agent structure that will handle all automated support interactions
* **Email Trigger Configuration** – The trigger ensures your agent automatically responds to incoming emails without manual intervention
* **Solution Integration** – Your agent is properly integrated within your Copilot Studio solution for organized management

**Lessons learned & troubleshooting tips:**

* Ensure your trigger settings align with your organization's email flow to avoid processing unintended messages
* Test trigger activation with a simple email before adding complex logic
* Keep agent names descriptive and consistent with your naming conventions

**Challenge: Apply this to your own use case**

* Consider what other triggers might be useful for your support scenarios (Teams messages, forms submissions, etc.)
* Think about how you might filter emails to ensure only support-related messages activate the agent
* Plan the types of email patterns your organization receives that could benefit from automation

---

---

## 🔄 Use Case #2: Add Knowledge and Tools Integration

Transform your basic agent into a comprehensive support system by adding knowledge sources and ServiceNow integration for complete automated responses.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Add Knowledge and Tools Integration | Connects external knowledge sources and ServiceNow integration for comprehensive automated responses | 10 minutes |

**Summary of tasks**

In this section, you'll learn how to integrate knowledge sources, configure ServiceNow tools for ticket lookups, and set up email response capabilities for complete automated support workflows.

**Scenario:** Your agent can now detect incoming emails, but it needs access to your knowledge base and ticketing system to provide meaningful responses. Users frequently ask about password resets and ticket statuses, requiring integration with both documentation and ServiceNow.

### Step-by-step instructions

#### Adding Knowledge Sources

1. Navigate to the **Knowledge** section in your agent configuration

2. Select **Website** as your knowledge source type

3. Add this URL: `https://support.servicenow.com/` and confirm ownership for better results

> [!TIP]
> You can add multiple knowledge sources including SharePoint sites, documents, and other websites relevant to your support topics.

#### Configuring ServiceNow Integration

4. Go to **Tools** and click **Add tool**

5. Search for and select **ServiceNow**, then choose **List records**

6. Click **Add to agent** to integrate the ServiceNow connector

7. Open the **List records** tool configuration

8. Rename the tool to **Get ServiceNow ticket details**

9. Change the description to: "Gets the details of an incident using its incident number"

10. Under **Additional details**, change **Authentication** to **Agent author authentication**

11. For **Record Type**, set a **Custom value** and choose **Incident**

12. Add input parameter **Query** and click **Customize**:
    - Description: "The output of this variable is the concatenation of numberCONTAINS and the incident number. E.g., 'numberCONTAINSINC0007001'. Only the incident number should be prompted and obtained from the user (e.g., INC0007001)"

13. Add input parameter **Limit** with **Custom Value** set to **1**

14. Click **Save** to preserve your ServiceNow tool configuration

#### Setting Up Email Response Capabilities

15. Return to **Tools** and click **Add**

16. Search for **Send an email (V2)** from Office 365 Outlook and select it

17. Click **Add to agent**

18. Open **Send an email (V2)** and rename it to **Reply to email**

19. Update the description to: "Use this operation to reply to the email received"

20. Under **Additional details**, set authentication to **Agent author authentication**

21. Customize the **To** input description: "Email address of the email received from"

22. Customize the **Body** input description: "Content of the email in HTML format so that it renders nicely to the user, with URLs and line breaks. If there are URLs from citations, they should be relevantly added as part of the answer directly, instead of being appended at the end of the answer."

23. Click **Save** to finalize the email tool configuration

#### Configuring Agent Instructions and AI Settings

24. Navigate to **Overview** and then **Instructions**

25. Add the following comprehensive instructions:
```
Understand and isolate each question from the received email body.

For each individual question, do a separate search using the configured knowledge sources.

If a ticket ID is mentioned, for example INC0000059, check if an update is available using Get ServiceNow ticket details.

Once you have gathered knowledge and ticket information, reply to the original email using Reply to email. Include the citations as clickable URLs. Use the same language as the initial user email (e.g., if the questions are in French, reply in French, etc.)
```

> [!IMPORTANT]
> Use `/` to insert tools in your instructions when referencing specific tool names.

26. Go to **Settings** > **Generative AI** > Enable **deep reasoning** > Click **Save** > **Close Settings**

> [!TIP]
> Deep reasoning enables advanced AI models to better analyze complex scenarios and determine the best actions to take.

27. Click **Publish** to activate your fully configured agent

#### Testing Your Complete Agent

28. Send a test email to your configured email address (preferably from a different email address):
```
Hi!

I hope you're doing well!

I had a couple of questions - what are the steps again to reset your Now Support user password?
Also, was wondering if you had an update on my cases INC0000059 and INC0000055

Much appreciated.
Thanks!
```

29. Monitor your trigger activation and agent response to verify the complete workflow

---

###  🏅 Congratulations! You've completed Use Case #2!

---

### Test your understanding

**Key takeaways:**

* **Knowledge Integration** – Your agent can now access external documentation to provide accurate, up-to-date information
* **ServiceNow Connectivity** – Ticket status lookups are automated, providing users with real-time incident updates
* **Intelligent Email Responses** – The agent composes professional responses with proper formatting, citations, and multi-language support
* **Deep Reasoning** – Advanced AI capabilities help the agent make better decisions in complex scenarios

**Challenge: Apply this to your own use case**

* Consider what additional knowledge sources would benefit your specific organization
* Think about other ServiceNow operations (create tickets, update status) that could enhance the automation
* Plan how you might extend this pattern to other communication channels like Teams or chat interfaces

---

## 🏆 Summary of learnings

True learning comes from doing, questioning, and reflecting—so let's put your skills to the test.

To maximize the impact of autonomous support agents:

* **Start Simple, Scale Smart** – Begin with common, repetitive inquiries before tackling complex support scenarios to build confidence and refine your approach
* **Knowledge Quality Drives Response Quality** – Invest time in curating and maintaining your knowledge sources, as they directly impact the accuracy and helpfulness of automated responses
* * **Integration Amplifies Value** – Connecting multiple systems (email, knowledge bases, ticketing) creates a seamless experience that rivals human support capabilities
* **Multi-language Awareness** – Configure your agent to detect and respond appropriately in users' preferred languages to maximize global accessibility
* **Monitor and Iterate** – Regularly review agent interactions to identify improvement opportunities and expand capabilities based on real user needs

---

### Conclusions and recommendations

**Autonomous Support Agent golden rules:**

* Always test your agent with realistic scenarios before full deployment to identify potential issues early
* Keep your knowledge sources current and well-organized to ensure accurate and relevant responses
* Configure appropriate authentication and security measures for all integrated systems and tools
* Design clear fallback procedures for scenarios where automated responses aren't sufficient
* Monitor agent performance metrics and user feedback to continuously improve response quality
* Start with a limited scope and gradually expand capabilities as you gain confidence and experience

By following these principles, you'll create reliable autonomous agents that enhance user satisfaction, reduce support team workload, and scale your organization's support capabilities efficiently and effectively.

---