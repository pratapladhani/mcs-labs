# 🤖 Bring Your Own Model (BYOM) Tool in Copilot Studio

*Unlock the power of Azure AI Foundry models in your Copilot Studio agents by integrating your own machine learning models, or by using off-the-shelf or fine-tuned models from Azure AI Foundry as conversational tools.*

---

## 🧭 Lab Details

| Level | Persona         | Duration   | Purpose                                                                                                                                                                                                 |
| ----- | --------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 200   | Maker/Developer | 40 minutes | Learn how to integrate models from Azure AI Foundry into Copilot Studio agents using the Bring Your Own Model (BYOM) capability, enabling specialized AI functionality tailored to your business needs. |

---

## 📚 Table of Contents

- [🤖 Bring Your Own Model (BYOM) Tool in Copilot Studio](#-bring-your-own-model-byom-tool-in-copilot-studio)
  - [🧭 Lab Details](#-lab-details)
  - [📚 Table of Contents](#-table-of-contents)
  - [🤔 Why This Matters](#-why-this-matters)
  - [🌐 Introduction](#-introduction)
  - [🎓 Core Concepts Overview](#-core-concepts-overview)
  - [📄 Documentation and Additional Training Links](#-documentation-and-additional-training-links)
  - [✅ Prerequisites](#-prerequisites)
  - [🎯 Summary of Targets](#-summary-of-targets)
  - [🧩 Use Cases Covered](#-use-cases-covered)
  - [🛠️ Instructions by Use Case](#️-instructions-by-use-case)
  - [🤖 Use Case #1: Intelligent Assessments](#-use-case-1-intelligent-assessments)
    - [Objective](#objective)
    - [Step-by-step instructions](#step-by-step-instructions)
      - [Lab 3A: Add Prompt as a Tool](#lab-3a-add-prompt-as-a-tool)
    - [Testing Lab 3A](#testing-lab-3a)
    - [🏅 Congratulations! You have completed Intelligent Assessments](#-congratulations-you-have-completed-intelligent-assessments)
    - [Test your understanding](#test-your-understanding)
  - [🔁 Summary of Learnings](#-summary-of-learnings)
  - [📌 Conclusions and Recommendations](#-conclusions-and-recommendations)

---

## 🤔 Why This Matters

Using different AI models in Copilot Studio allows agents to leverage each model's strengths; such as reasoning, creativity, or precision for specific tasks. This ensures higher accuracy, efficiency, and adaptability across diverse use cases.

Azure AI Foundry brings the latest frontier models into your Copilot Studio prompts. You can access a diverse portfolio of AI models, including cutting-edge open-source solutions, industry-specific models, and task-based AI capabilities.

This lab demonstrates how Copilot Studio provides flexibility to integrate models from Azure AI Foundry into your Copilot Studio agents using the Bring Your Own Model (BYOM) capability---enabling specialized AI functionality tailored to your business needs and real-world automation scenarios.

**Think of your current contract management workflow:**

- **Without intelligent agents**, sales operations teams must manually identify contract risks---a slow, repetitive, and error-prone process that reduces efficiency and increases the chance of oversight.

- **With intelligent agents**, you can automatically apply your company's specific rules and regulations to identify and categorize contract risks. For example, when a user asks the agent about potential risks, it considers all relevant factors and internal guidelines to deliver a more accurate and consistent risk assessment.

**Common challenges solved by this lab:**

- **Inconsistent Risk Assessment:** The agent ensures all contracts are evaluated using standardized rules and criteria, reducing human bias and variability.
- **Time-Consuming Manual Review:** It automates the risk identification process, significantly speeding up contract analysis and freeing teams for higher-value tasks.

**By bringing your own model from Azure AI Foundry, makers learn to:**

- Use a diverse portfolio of AI models, including cutting-edge open-source solutions, industry-specific models, and task-based AI capabilities.
- Apply an industry-specific model to a specific task within your agent.

---

## 🌐 Introduction

As organizations increasingly embrace AI agents, the demand for domain-specific agents is growing rapidly. For example, in sales operations, teams often need to manually identify contract risks---a slow, repetitive, and error-prone process. This manual approach not only reduces efficiency but also increases the likelihood of oversight and compliance issues.

As AI agents mature, there's a clear shift toward leveraging domain-specific models tailored for specialized tasks. For instance, models trained for risk identification can be integrated into sales operations to automatically detect potential contract risks, enabling faster, more accurate, and consistent decision-making.

This lab focuses on using industry-specific and task-based AI models for specific agent scenarios through the Bring Your Own Model (BYOM) capability.

---

## 🎓 Core Concepts Overview

| Concept                              | Why it matters                                                                                                                                                                                                                                                                                                               |
| ------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Adding Tools and Configuration**   | In Copilot Studio, **Tools** are pre-built or custom components that let your agent perform actions, fetch data, or integrate with other systems. They act like skills or plugins, giving your agent specific powers beyond simple conversation.                                                                             |
| **Using Prompts as Tool**            | In Copilot Studio, **Prompts** are instructions or templates that guide the Large Language Model (LLM), such as GPT, and small language models on how to think, respond, or generate content. They work like a smart script for your AI, helping it reason, retrieve information, and produce useful, context-aware answers. |
| **Create Reusable Prompt Templates** | In Copilot Studio, you can create reusable natural language instructions that harness both large and small language models to perform tasks such as summarization, reasoning, or data extraction.                                                                                                                            |

---

## 📄 Documentation and Additional Training Links

* [Bring your own model for your prompts | Microsoft Learn](https://learn.microsoft.com/en-us/ai-builder/byom-for-your-prompts)
* [Azure AI Foundry Models | Microsoft Azure](https://azure.microsoft.com/en-us/products/ai-foundry/models)

---

## ✅ Prerequisites

- Access to **Microsoft Copilot Studio**, with permissions to create, edit, and publish agents and agent flows.
- A **Contoso Agent** created in Lab 2 (or an equivalent Copilot Studio agent).
- **Connection details** provided for pre-deployed models in Azure AI Foundry, including endpoint URLs, access keys, and model names.
- **Power Platform environment** enabled for Copilot Studio.
- **Basic familiarity** with Copilot Studio concepts such as agent setup, knowledge sources, and flows.

---

## 🎯 Summary of Targets

By the end of this lab, you will:

- Use the **Mistral Model/grok-4-fast-reasoning** via **Bring Your Own Model (BYOM)** in Prompts to run predefined prompts, extract specific information, and perform reasoning or entity extraction.
- Understand how to **combine Low-Code tools with Azure AI Foundry services** to extend Microsoft Copilot Studio's functionality.
- Learn how to use **industry-specific and task-based AI models** for targeted agent tasks through the **Bring Your Own Model (BYOM)** capability.

---

## 🧩 Use Cases Covered

| Step | Use Case                                                        | Value Added                                                 | Effort     |
| ---- | --------------------------------------------------------------- | ----------------------------------------------------------- | ---------- |
| 1    | [Intelligent Assessments](#-use-case-1-intelligent-assessments) | Enable intelligent assessments based on predefined criteria | 30 minutes |

---

## 🛠️ Instructions by Use Case

---

## 🤖 Use Case #1: Intelligent Assessments

Use **Bring Your Own Model (BYOM)** in **Prompts** to run predefined prompts that extract specific information, perform reasoning, and enable entity extraction.

| Use case                | Value added                                                 | Estimated effort |
| ----------------------- | ----------------------------------------------------------- | ---------------- |
| Intelligent Assessments | Enable intelligent assessments based on predefined criteria | 30 minutes       |

**Summary of tasks**

In this section, you'll learn how to use **Bring Your Own Model (BYOM)** in Prompts for a specific task. In this lab, you'll create a custom Prompt that automatically retrieves results from a knowledge source --- in this case, an **Azure AI Search Index** --- and allows you to execute a custom prompt to gather additional insights and perform entity extraction, reasoning based on business requirements.

Using this approach, you can create custom prompts tailored to specific scenarios. The **Azure AI Foundry** service offers a wide range of generative AI models, and depending on your business needs, latency, and other factors, you can bring those models into Copilot Studio through custom prompts instead of relying on the default models. Additionally, this approach allows you to use simpler, more focused instructions for your agents while handling domain-specific tasks or assessments through prompts. This makes managing instructions and prompts more flexible and efficient.

**Scenario:** The user needs to run some predefined assessments --- for example, a **risk assessment** on contracts which are stored in the knowledge source--- and generate an instant report.

### Objective

Create a reusable prompt template that leverages Azure AI Foundry models to perform intelligent contract risk assessment based on predefined criteria.

---

### Step-by-step instructions

#### Lab 3A: Add Prompt as a Tool

1. Open **Contoso Agent** that was built in Lab 2.

2. Click on **+Add tool** and select **+ New Tool**.

3. Select **Prompt**.

4. Provide a unique name, for example: `RiskAssessment-YourName`

5. Click on **+ Add Content** and select input as **text** and give it a name: `Contract`.

6. Add the following prompt with input of type text called `contract`:

    ```
    You are tasked with reviewing **contract** details to identify and flag any potential risks. Your goal is to analyze the provided contract thoroughly and extract risk items based solely on the information contained within it.
    
    ### Instructions:
    
    1. Carefully read and understand the contract details.
    
    2. Identify all potential risks present in the contract.
    
    3. Categorize each risk by its severity level: High, Medium, or Low.
    
    4. List the risks ordered by severity:
    - Highest risks first
    - Followed by medium risks
    - Then low risks
    
    5. For each risk, provide a clear and concise reasoning explaining why it is considered a risk.
    
    6. Ensure all information and risk assessments are factually accurate and strictly derived from the provided contract details.
    
    These are the **Contract Risk Assessment Questionnaire that will help you in the assessment**:
    
    **Scope Clarity:**
    Are the roles, responsibilities, and deliverables of all parties clearly defined without ambiguity or overlapping obligations?
    
    **Termination Terms:**
    Does the contract specify clear conditions for termination (by either party) and outline consequences or penalties for early termination?
    
    **Payment and Pricing:**
    Are payment terms (amounts, schedules, methods, and penalties for late payments) explicitly stated and free of conflicting clauses?
    
    **Liability and Indemnity:**
    Are liability limits, indemnification obligations, and exclusions of liability balanced and reasonable for all parties?
    
    **Confidentiality and Data Protection:**
    Does the agreement adequately protect sensitive data and comply with applicable privacy laws (e.g., GDPR, HIPAA, etc.)?
    
    **Intellectual Property Rights:**
    Are ownership and usage rights for intellectual property clearly defined---especially for deliverables, software, or creative outputs?
    
    **Compliance and Legal Obligations:**
    Does the contract ensure adherence to all relevant laws, regulations, and industry standards, including export controls or anti-bribery clauses?
    
    **Dispute Resolution:**
    Are the mechanisms for dispute resolution (e.g., arbitration, jurisdiction, governing law) clearly established and practical?
    
    **Force Majeure and Unforeseen Events:**
    Does the contract include a comprehensive force majeure clause that adequately addresses risks such as natural disasters, pandemics, or supply disruptions?
    
    **Performance and Penalty Clauses:**
    Are there clear performance metrics, service-level agreements (SLAs), and penalties for non-performance or delays?
    ```

7. Click on the **Models** tab and select **Azure AI Foundry Models**.

8. Click on **Connect a new model**.

9. Use the provided Model Deployment Name, Base Model Name, Azure Model Endpoint URL, API Key, Model Description to connect to the Azure AI Foundry Model:

   - _Model Deployment Name_: `[PROVIDED IN LAB ENVIRONMENT]`
   - _Base Model Name_: `[PROVIDED IN LAB ENVIRONMENT]`
   - _Azure Model endpoint URL_: `[PROVIDED IN LAB ENVIRONMENT]`
   - _API Key_: `[PROVIDED IN LAB ENVIRONMENT]`
   - _Model Description_: `[PROVIDED IN LAB ENVIRONMENT]`

> [!NOTE]
> All connection details including endpoint URLs and API keys will be provided by your lab instructor or found in your lab environment documentation.

10. Click on **Connect**.

11. Once the model is added, make sure it is selected in the Model Dropdown.

12. Click **Add and Configure** in the Add Tool dialog.

13. In the input use the default value of **Dynamically Fill With AI**. In the completion select **Write the response with Generative AI** and then click **Save**.

14. Go to **Agent Overview** tab and click **Edit** to add the additional instruction to the agent instructions, then click **Save**:

    ```
    For Contract risks related queries, get the information from Contoso Contracts Knowledge source and then use the tool "YourPromptName" to identify if there are any risks.
    ```

---

### Testing Lab 3A

In your test window, send a message like:

```
Contract assessment for Fourth Coffee
```

---

### 🏅 Congratulations! You have completed Intelligent Assessments

---

### Test your understanding

**Key questions to validate your learning:**

1. What does "Bring Your Own Model" (BYOM) allow you to do in Copilot Studio?
2. Where do you select your custom BYOM model when creating a prompt in Copilot Studio?
3. Which service must your custom model be deployed in before using it as BYOM in Copilot Studio?

**Challenge: Apply this to your own use case**

- Consider what other assessment types in your organization could benefit from Bring Your Own Model capabilities.
- Explore how you could combine search results and use them to run assessments.

---

## 🔁 Summary of Learnings

> True learning comes from doing, questioning, and reflecting---so let's put your skills to the test.

Now that you've integrated Azure AI Foundry models into Copilot Studio, take a moment to evaluate your understanding and extend your thinking:

- **Understand BYOM capabilities** – Reflect on how bringing your own models extends Copilot Studio's functionality beyond default models.
- **Recognize model selection criteria** – Consider factors like reasoning strength, latency, cost, and task specificity when choosing models.
- **Design reusable prompt templates** – Structure prompts that can be applied across multiple scenarios and use cases.
- **Integrate specialized AI** – Apply domain-specific or task-based models for improved accuracy and relevance.
- **Balance simplicity and specialization** – Keep agent instructions focused while delegating complex reasoning to specialized prompts and models.

---

## 📌 Conclusions and Recommendations

**Copilot Agent and Bring Your Own Model golden rules:**

- **Always define clear agent instructions** that specify data sources and limitations.
- **Use structured prompts** to ensure consistent, valuable responses for business users.
- **Implement activity tracking** to monitor and optimize agent performance.
- **Implement proper error handling** and delays when integrating with external Azure services.
- **Design suggested prompts** that align with real user workflows and common tasks.
- **Test with realistic business scenarios** to validate agent functionality.
- **Consider different user personas** when designing prompts and response structures.

By following these principles, you'll create powerful, user-friendly agents that seamlessly integrate enterprise data into natural language workflows, improving productivity and decision-making across your organization.

---
