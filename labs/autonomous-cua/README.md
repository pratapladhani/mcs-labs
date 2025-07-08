# Autonomous Portfolio Lookup Agent with Computer-Using Agents (CUA)

Build an autonomous Copilot Studio agent that retrieves financial portfolio data from internal legacy systems that lack API connectivity.

---

## 🧭 Lab Details

| Level | Persona | Duration | Purpose |
| ----- | ------- | -------- | ------- |
| 200 | Maker/Developer | 50 minutes | After completing this lab, participants will be able to build an autonomous agent in Microsoft Copilot Studio that uses the Computer use tool to simulate human interaction with legacy systems and integrates Microsoft 365 Outlook to handle email-based data requests and responses. |

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
  - [Use Case #1: Setup your hosted virtual machine and enable CUA](#-use-case-1-setup-your-hosted-virtual-machine-and-enable-cua)
  - [Use Case #2: Create and Configure an Autonomous Agent](#-use-case-2-create-and-configure-an-autonomous-agent)
  - [Use Case #3: Add Computer Use and Email Connector](#-use-case-3-add-computer-use-and-email-connector)

---

## 🤔 Why This Matters

Legacy systems without APIs create major roadblocks for automation, forcing employees to rely on manual processes or support teams to access critical data. This slows down decision-making, increases errors, and reduces productivity.

This lab demonstrates how Microsoft Copilot Studio can bridge that gap. By simulating human interaction with internal systems, you’ll learn to build an autonomous agent that retrieves data securely and efficiently - without needing API access. The result: faster responses, reduced manual workload, and smarter, real-time decisions.

---

## 🌐 Introduction

In this lab, you’ll learn how to build an autonomous agent using Microsoft Copilot Studio. This agent will simulate human interaction with a legacy internal system to retrieve financial portfolio data without requiring direct API access.

**Real-world example:** A financial advisor needs quick access to key portfolio details - such as client name, portfolio value, and assigned manager - to prepare for meetings, review performance, resolve issues, or recommend rebalancing or reassignment. However, this data resides in a legacy internal system that advisors cannot access directly due to IT restrictions, and the system lacks an API for automated retrieval.

As a result, advisors must rely on intermediaries like back-office teams to obtain the information, leading to delays, inefficiencies, increased risk of errors, and limited ability to make timely, informed decisions.

Implementing an automation agent would enable advisors to securely and instantly retrieve accurate portfolio data, improving response times, reducing manual workload, and enhancing overall productivity.

---

## 🎓 Core Concepts Overview

| Concept | Why it matters |
|---------|----------------|
| **Autonomous Agents** | Enable 24/7 automated responses to user inquiries, reducing manual workload and improving response times while maintaining consistency in support quality |
| **Triggers** | Events, as simple as "Email received", that trigger autonomous agents to then automatically detect and process the content and context initially provided |
| **Tools** | Tools are simple or sophisticated connectors that the Copilot Studio orchestrator can invoke in response to user queries or business events. |
| **Computer use tool** | Enables the agent to interact with any system that has a graphical user interface. It works with websites and desktop apps by selecting buttons, choosing menus, and entering text into fields on the screen. This tool performs the task on a computer you set up using a virtual mouse and keyboard, enabling agents to complete tasks even when there isn't an API to connect to the system directly. If a person can use an app or website, Computer use can too. |
| **Hosted machines** | Cloud-based virtual machines managed by Microsoft that enable agents to trigger either Computer-Using Agents (CUAs) or Power Automate desktop flows without needing to maintain their own physical or virtual infrastructure. |

---

## 📄 Documentation and Additional Training Links

* [Microsoft Copilot Studio Documentation](https://learn.microsoft.com/copilot-studio/)
* [Copilot Studio Triggers](https://learn.microsoft.com/copilot-studio/triggers/)
* [Use connectors in Copilot Studio](https://learn.microsoft.com/copilot-studio/connectors/)
* [Office 365 Outlook Connector](https://learn.microsoft.com/connectors/office365/)
* [Automate web and desktop apps with computer use](https://learn.microsoft.com/power-automate/desktop-flows/computer-use/)
* [Power Automate Hosted machines](https://learn.microsoft.com/power-automate/hosted-machines/)

---

## ✅ Prerequisites

* Access to Microsoft Copilot Studio with appropriate licensing
* Access to Microsoft Power Automate with appropriate licensing
* Access to a US-based environment
* Office 365 environment with Outlook integration enabled

---

## 🎯 Summary of Targets

In this lab, you'll build an autonomous portfolio lookup agent that retrieves portfolio information from an internal legacy system. By the end of the lab, you will:

* Create a hosted machine in Power Automate and enable it for computer use
* Create and configure an autonomous agent with email triggers for automatic activation
* Add a Computer use tool to simulate the process of a human user retrieving information from a website by logging into a computer, navigating through the website’s graphical user interface, performing searches, and extracting the required data
* Configure email response tools that reply professionally with proper formatting
* Test the complete workflow with realistic scenarios and various requests

---

## 🧩 Use Cases Covered

| Step | Use Case | Value added | Effort |
|------|----------|-------------|--------|
| 1 | Setup your hosted virtual machine and enable CUA | Provides a consistent, isolated environment for Computer use tool to run on. | 10 min (+ 30 min waiting time) |
| 2 | Create and Configure an Autonomous Agent | Establishes the foundation for automated email processing with intelligent trigger configuration | 10 min |
| 3 | Add Computer Use and Email Connector | Enables automated data retrieval from a legacy internal system lacking API connectivity, without requiring backend access or system modifications, by implementing a non-intrusive integration layer. Delivers comprehensive, automated email responses containing only the specifically requested data. | 10 min |

---

## 🛠️ Instructions by Use Case

---

## 🧱 Use Case #1: Setup your hosted virtual machine and enable CUA

Configure a Microsoft-hosted virtual machine and enable it for Computer use, so that the agent can perform UI automation.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Setup your hosted virtual machine and enable CUA | Provides a consistent, isolated environment for Computer use tool to run on. | 10 min (+ 30 min waiting time) |

**Summary of tasks**

You will navigate to your Power Automate environment, create a hosted Windows 11 machine, configure it for remote access, and enable it for use with the Computer use tool.

**Scenario:** To simulate human interaction with legacy systems, you need a secure, cloud-hosted machine that can run desktop automation tasks using the Computer-Using Agents (CUA) model in Microsoft Copilot Studio.

### Objective

Learn how to provision, configure, and activate a hosted machine in Power Automate to support GUI-based automation with the Computer use tool.

---

### Step-by-step instructions

#### Navigating to the environment with CUA enabled

1. Navigate to the Power Automate home page at https://make.powerautomate.com/
2. From the environment picker on the top right of the page select the PROD – your_username environment

> [!TIP]
> If you haven't done so already, you need to request TEST and PROD environments to be created for your user. This is a one-time setup step that will allow you to test the CUA feature. Use the Environments Request Form to request these environments to be automatically created for you. This will then take a couple of minutes to provision and to show up.

> [!IMPORTANT]
> To access this form, use the provided URL in the Lab Resources (specific per training). This operation will fail if you already have more than 1 environment of type developer, as each user is limited to 3 environments of this type.

#### Creating the hosted machine

1. In the Power Automate home page, select More from the left-hand menu and then Machines
2. Select +New > Hosted machine
3. In the hosted machine creation wizard:
    a. Enter the name Computer use machine
    b. Select Next
    c. Select the Default Windows 11 Image
    d. Select Next > Next > Create.

> [!IMPORTANT]
> The machine may take over 30 minutes to become accessible. You may choose to proceed with another lab in the meantime and return later.

#### Configuring the machine to prepare it for Computer use to run

4. On the newly created hosted machine, select Open in browser
5. Sign in with your training user’s credentials
6. In the In Session Settings window select Connect
7. In the Sign in to Cloud PC window select Sign In
8. In the Allow remote desktop connection? popup select Yes
9. Open Microsoft Edge and ensure the New tab window opens up
10. Sign out from the hosted machine

#### Enabling Computer use

1. Go back to the hosted machine in Power Automate and select Settings.
2. Turn on the Enable for computer use setting.
3. On the popup, select Activate.
4. Select Save.

---

###  🏅 Congratulations! You've completed Use Case #1!

---

### Test your understanding

**Key takeaways:**

* **Hosted machines** – Provide a secure, isolated environment for automation
* **CUA model** – Enables GUI-based automation for legacy systems
* **Environment setup** – Critical for successful agent execution

**Lessons learned & troubleshooting tips:**

* If the hosted machine does not appear, verify your environment selection and licensing
* If you cannot connect, check your credentials and network access
* Allow sufficient time for machine provisioning

**Challenge: Apply this to your own use case**

* What other business processes could benefit from hosted machine automation?
* How would you ensure security and compliance when using hosted machines?
* Try setting up a hosted machine for a different automation scenario

---

---

## 🔄 Use Case #2: Create and Configure an Autonomous Agent

Set up the foundational autonomous agent with email triggers that automatically activates when email requests arrive.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Create and Configure an Autonomous Agent | Establishes the foundation for automated email processing with intelligent trigger configuration | 10 min |

**Summary of tasks**

You will create a new autonomous agent in Microsoft Copilot Studio, configure its identity, and set up an email trigger using the Microsoft 365 Outlook connector.

**Scenario:** To automate portfolio lookups, the agent must be able to detect incoming email requests and initiate the appropriate automation flow based on subject line filtering.

### Objective

Learn how to create and configure an autonomous agent that listens for specific email triggers and prepares to launch automation tasks in response.

---

### Step-by-step instructions

#### Creating the Agent and Solution Setup

1. Navigate to the Copilot Studio home page at https://copilotstudio.microsoft.com/
2. From the Environment picker on the top right part of the window switch to Environment PROD – your_username
3. Select Create > +New Agent
4. Select Skip to configure to bypass the initial setup wizard
5. Name your agent Autonomous Portfolio Lookup Agent
6. Select Create.

#### Configuring Email Triggers

8. In the Overview tab, scroll down to the triggers section and click +Add trigger
9. Search and select When a new email arrives (V3) (Office 365 Outlook)
10. Select Next
11. Rename the trigger to When a portfolio lookup email arrives
12. Select Next
13. In the Subject Filter (Optional) field, enter Portfolio to filter emails that contain the word "Portfolio" in the subject line.
14. Finally Create trigger

> [!TIP]
> The trigger is now configured. As soon as you publish your agent, it will automatically activate your agent when new emails arrive

---

###  🏅 Congratulations! You've completed Use Case #2!

---

### Test your understanding

* How does the agent know when to activate?
* What are the benefits of using email triggers for automation?
* How could you extend this agent to handle other types of requests?

**Challenge: Apply this to your own use case**

* What other triggers could you use to automate business processes?
* How would you design an agent to handle multiple types of incoming requests?
* Imagine a scenario where the agent must process attachments—how would you approach this?

---

---

## 🖥️ Use Case #3: Add Computer Use and Email Connector

Configure a Computer use tool that logs into a computer, navigates through a website, searches and retrieves financial portfolio data. Then use the Office 365 Outlook connector to reply with the requested data.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Add Computer Use and Email Connector | Enables automated data retrieval from a legacy internal system lacking API connectivity, without requiring backend access or system modifications, by implementing a non-intrusive integration layer. Delivers comprehensive, automated email responses containing only the specifically requested data. | 10 min |

**Summary of tasks**

You will configure the Computer use tool to simulate GUI-based data retrieval, set up the Send an email tool for automated responses, and define the agent’s behavior and testing flow.

**Scenario:** To complete the automation loop, the agent must retrieve portfolio data from a legacy web interface using desktop simulation and respond to email requests with accurate, formatted information.

### Objective

Learn how to integrate and configure tools for desktop automation and email communication, define agent instructions, and test the full end-to-end workflow from trigger to response.

---

### Step-by-step instructions

#### Configuring the Computer use tool

1. Navigate to Tools in the top-level menu.
2. Select + Add a tool.
3. Select + New tool.
4. Select Computer use
5. Select Create to create a new connection to the agent machine and select:
    a. Agent machine: Computer use machine.
    b. Domain and username: Enter the email address of your demo account.
    c. Password: Enter the password of your demo account.
6. Select Create
7. After you set up the connection, select Add and configure.
8. Configure the details of the Computer use tool as follows:
    - Name: Look up portfolio data
    - Description: Search and retrieve financial portfolio data
    - Instructions:
        i. Open Microsoft Edge
        ii. Go to [https://computerusedemos.blob.core.windows.net/web/Portfolio/index.html](https://computerusedemos.blob.core.windows.net/web/Portfolio/index.html).
        iii. Enter the Portfolio ID in the "Enter Portfolio ID" search field and click on the "Search" button.
        iv. Retrieve the "Client Name", "Portfolio Value" and "Manager" values exactly as shown on the screen.
        v. Return those values as the final output.
        If no portfolio data is found, reply "No portfolio found with the specified ID."
9. Ensure Authentication is set to No, pass through tool owner’s credentials.

> [!IMPORTANT]
> This setting specifies how Computer use authenticates on the machine during execution. Authenticating with the tool owner’s credentials is more suitable for autonomous agents. Be aware that if you share a conversational agent with this setting, anyone using it can act with the original author’s access to the configured machine.

10. In the Inputs section select +Add input.
11. Enter name Portfolio ID and Description The ID of the portfolio and select Done

> [!TIP]
> During execution, computer use combines your instructions with the input values to complete the task.

12. Select Save.

#### Testing the Computer use tool

1. In the Instructions section, select the Test button on the right.
2. Add the sample value 44123BCD and select Test now.
3. Observe the Computer use tool logging into the machine and performing the requested actions:
    - The left panel shows your instructions and a step-by-step log of the tool’s reasoning and actions.
    - The right panel shows a preview of the actions on the machine you set up for computer use.

> [!TIP]
> You can also observe the Computer use tool in action from the Activity page

4. Select Finish testing.

> [!TIP]
> If the result isn't what you expect, go to the configuration page and refine your instructions. Add more details to improve accuracy and test again. Allow sufficient time between tests to ensure the previous Computer use task has been fully completed before starting a new one.

#### Setting Up Email Response Capabilities

1. Return to the Tools tab and select + Add a tool
2. Search for Send an email (V2) from Office 365 Outlook and select it
3. Select Add and configure
4. Update its name to Reply to email
5. Update the description to: Use this operation to reply to the email received
6. Under Additional details, set authentication to No, pass through tool owner’s credentials
7. Customize the To input to set its Description to:
    Use the "from" email of the triggering received email.
8. Customize the Subject input to set its Description to:
    Write the email subject.
9. Customize the Body input to set its Description to:
    Write the email body using HTML and highlight the requested data.
10. Click Save to finalize the tool configuration

#### Configuring Agent Instructions and AI Settings

1. Navigate to Overview and then Instructions
2. Paste the following comprehensive instructions:
    When a financial portfolio related request is received, search for the requested data using <Look up portfolio data>. Once you have gathered the financial portfolio information, use the <Reply to email> tool to reply to the original email you received. Do not respond with data beyond what was requested.

> [!IMPORTANT]
> For each of the placeholder <...> in the description, use / to insert the tools you just configured in your instructions.

3. Go to the agent’s Settings, and in the Knowledge section disable Use general knowledge to ground agent responses only to data retrieved from CUA.

#### Testing Your Complete Agent

1. Send a test email to your training user email with Subject –  Portfolio data request and body:

```
Hi!

I hope you're doing well!
I'm looking for the portfolio manager and value of portfolio #44123BCD.

Much appreciated.
Thanks!
```

2. Make sure you receive the email in your training user’s inbox, in outlook.office.com
3. In the Overview tab, go to the Triggers section and select Test trigger
4. Select the trigger instance and then Start testing
5. Check your emails for the agent’s reply.

> [!TIP]
> If the Computer use tool seems to be stuck on a particular step (not showing any updates for ~10 minutes) you may stop the running agent by manually signing into the remote hosted machine and signing out again.

---

###  🏅 Congratulations! You've completed Use Case #3!

---

### Test your understanding

* How does the Computer use tool enable automation for legacy systems?
* What are the security considerations when using pass-through credentials?
* How would you troubleshoot a failed automation run?

**Challenge: Apply this to your own use case**

* What other business processes could benefit from Computer use automation?
* How would you design an agent to handle multiple data retrieval scenarios?
* Try configuring a different connector to extend the agent’s capabilities

---

## 🏆 Summary of learnings

True learning comes from doing, questioning, and reflecting—so let's put your skills to the test.

To maximize the impact of autonomous agents for legacy system integration:

* **Leverage hosted machines** – Provide a secure, scalable environment for automation
* **Use triggers effectively** – Automate business processes based on real-world events
* **Simulate human actions with Computer use** – Enable automation even when APIs are unavailable
* **Integrate communication tools** – Ensure timely, professional responses to user requests
* **Test and iterate** – Continuously refine agent instructions and tool configurations for reliability

---

### Conclusions and recommendations

**Automation golden rules:**

* Always validate environment and licensing prerequisites before starting
* Use pass-through credentials with caution and document access controls
* Test each automation step independently before full workflow testing
* Monitor agent activity and logs for troubleshooting
* Regularly review and update agent instructions for accuracy
* Document all configurations for future maintenance

By following these principles, you'll enable secure, scalable, and efficient automation for legacy systems, empowering your organization to make faster, data-driven decisions.

---
