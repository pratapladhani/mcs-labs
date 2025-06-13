# Create an 'Ask me anything' agent for your employees

Empower employees with answers that matter – Build an intelligent agent that connects to your knowledge and data.

---

## 🧭 Lab Details

| Level | Persona | Duration | Purpose |
| ----- | ------- | -------- | ------- |
| 200 | Maker | 40 minutes | After completing this lab, participants will be able to create an intelligent "Ask me anything" agent that connects to multiple knowledge sources including SharePoint, ServiceNow, and custom knowledge bases. Participants will learn to configure knowledge prioritization, deploy agents to Microsoft 365 Copilot, and implement AI-powered document analysis with human review workflows. |

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
  - [Use Case #1: Create an 'Ask Me Anything' Agent and Add SharePoint Knowledge Source](#-use-case-1-create-an-ask-me-anything-agent-and-add-sharepoint-knowledge-source)
  - [Use Case #2: Configure Suggested Prompts](#-use-case-2-configure-suggested-prompts)
  - [Use Case #3: Deploy to Microsoft 365 Copilot](#-use-case-3-deploy-to-microsoft-365-copilot)
  - [Use Case #4: Knowledge Prioritization Techniques](#-use-case-4-knowledge-prioritization-techniques)
  - [Use Case #5: Add ServiceNow Incidents](#-use-case-5-add-servicenow-incidents)
  - [Use Case #6: Add Custom Knowledge](#-use-case-6-add-custom-knowledge)
  - [Use Case #7: AI Summary and Review of Meeting Notes](#-use-case-7-ai-summary-and-review-of-meeting-notes)

---

## 🤔 Why This Matters

**Makers and IT professionals** - Tired of employees constantly asking the same questions about policies, benefits, or system status? Frustrated by scattered knowledge across multiple systems?

Think of your organization's knowledge like a library:
- **Without an intelligent agent**: Employees waste hours searching through SharePoint folders, submitting IT tickets for simple questions, and interrupting colleagues for information that should be readily available
- **With an intelligent agent**: Employees get instant, accurate answers from a single conversational interface that automatically searches across all your knowledge sources with proper citations

**Common challenges solved by this lab:**
- "I can't find the leave policy for my country in our SharePoint site"
- "What's the status of my ServiceNow incident?"
- "Can someone help me structure these meeting notes properly?"
- "I need information from multiple systems but don't know where to look"

**This 40-minute investment will save your organization countless hours and improve employee satisfaction by providing instant access to knowledge.**

---

## 🌐 Introduction

In today's fast-paced business environment, employees need quick access to accurate information from multiple sources. Whether it's HR policies, IT incident status, or custom knowledge bases, information is often scattered across different systems, making it difficult for employees to find what they need efficiently.

**Real-world example:** Imagine Sarah, a new employee in Germany, needs to understand her leave entitlements. Currently, she might spend 30 minutes navigating through SharePoint folders, trying different search terms, or even asking HR colleagues. With an intelligent "Ask me anything" agent, Sarah simply types "What's the leave policy for Germany?" and instantly receives the accurate policy document with proper citations, saving time and reducing frustration.

This lab teaches you to build a comprehensive solution that transforms how employees interact with organizational knowledge, creating a single conversational interface that intelligently routes questions to the right knowledge sources and provides contextual, accurate responses.

---

## 🎓 Core Concepts Overview

| Concept | Why it matters |
|---------|----------------|
| **Knowledge Source Integration** | Connects your agent to multiple data sources (SharePoint, ServiceNow, custom APIs) so employees get comprehensive answers from a single interface, eliminating the need to search multiple systems. |
| **Context-Aware Knowledge Prioritization** | Intelligently routes questions to the most relevant knowledge sources based on user context (location, role, etc.), ensuring employees get personalized and accurate information. |
| **Microsoft 365 Copilot Deployment** | Makes your agent available where employees already work, integrating seamlessly into their daily Microsoft 365 workflow for maximum adoption and convenience. |
| **AI-Powered Document Analysis** | Automates the processing and structuring of unstructured content like meeting notes, reducing manual work while maintaining human oversight for accuracy and approval. |

---

## 📄 Documentation and Additional Training Links

* [Microsoft Copilot Studio Documentation](https://learn.microsoft.com/en-us/microsoft-copilot-studio/)
* [Knowledge Sources in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/nlu-boost-conversations)
* [Deploy Copilot Studio agents to Microsoft 365](https://learn.microsoft.com/en-us/microsoft-copilot-studio/publication-connect-bot-to-custom-application)
* [ServiceNow connector for Power Platform](https://learn.microsoft.com/en-us/connectors/service-now/)
* [Adaptive Cards for Interactive Experiences](https://learn.microsoft.com/en-us/adaptive-cards/)

---

## ✅ Prerequisites

* Access to Microsoft Copilot Studio with appropriate licensing.
* Access to SharePoint Online with sample knowledge content.
* ServiceNow access for incident management integration (demo environment provided).
* Understanding of basic conversational AI concepts and Microsoft 365 administration.

---

## 🎯 Summary of Targets

In this lab, you'll build a comprehensive "Ask me anything" agent that serves as a central knowledge hub for your organization. By the end of the lab, you will:

* Create an 'Ask me Anything' agent and add SharePoint as a knowledge source.
* Configure suggested prompts for better user guidance.
* Deploy to Microsoft 365 Copilot for seamless integration.
* Learn to prioritize knowledge sources based on user context.
* Add ServiceNow incidents integration for real-time ticket status.
* Add custom knowledge sources via HTTP requests.
* Implement AI summary and review of meeting notes with human oversight.

---

## 🧩 Use Cases Covered

| Step | Use Case | Value added | Effort |
|------|----------|-------------|--------|
| 1 | [Create an 'Ask Me Anything' Agent and Add SharePoint Knowledge Source](#-use-case-1-create-an-ask-me-anything-agent-and-add-sharepoint-knowledge-source) | Establishes foundational agent with SharePoint knowledge integration and grounded AI responses | 5 min |
| 2 | [Configure Suggested Prompts](#-use-case-2-configure-suggested-prompts) | Guides users toward the agent's best capabilities through strategic prompt suggestions | 3 min |
| 3 | [Deploy to Microsoft 365 Copilot](#-use-case-3-deploy-to-microsoft-365-copilot) | Makes the agent available in Microsoft 365 Copilot for seamless user access | 5 min |
| 4 | [Knowledge Prioritization Techniques](#-use-case-4-knowledge-prioritization-techniques) | Implements context-aware knowledge routing for personalized and relevant responses | 8 min |
| 5 | [Add ServiceNow Incidents](#-use-case-5-add-servicenow-incidents) | Integrates real-time incident management for comprehensive support capabilities | 5 min |
| 6 | [Add Custom Knowledge](#-use-case-6-add-custom-knowledge) | Extends knowledge base with custom HTTP endpoints for enterprise system integration | 7 min |
| 7 | [AI Summary and Review of Meeting Notes](#-use-case-7-ai-summary-and-review-of-meeting-notes) | Automates document analysis with human review workflows for accuracy and approval | 7 min |

---

## 🛠️ Instructions by Use Case

---

## 🧱 Use Case #1: Create an 'Ask Me Anything' Agent and Add SharePoint Knowledge Source

Create a foundational intelligent agent with SharePoint integration for grounded AI responses.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Create an 'Ask Me Anything' Agent and Add SharePoint Knowledge Source | Establishes foundational agent with SharePoint knowledge integration and grounded AI responses | 5 minutes |

**Summary of tasks**

In this section, you'll learn how to access the Solutions area of Copilot Studio, create a new agent, and integrate SharePoint as a knowledge source.

**Scenario:** Properly setup your development environment so that you can later easily package and deploy your agents to other environments. Your organization has extensive knowledge stored in SharePoint that needs to be accessible through conversational AI.

### Objective

Create a new agent with SharePoint knowledge integration that provides grounded, cited responses.

---

### Step-by-step instructions

1. Navigate to the Copilot Studio home page at [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com/)

2. Go to the Solutions menu (located in the left-hand menu under the ellipsis …)

3. Select the solution you had created

4. Select **New**, and choose **Agent**

5. Select **Skip to configure**

6. Name your agent `Ask Me Anything`

7. Click **Create**

8. Go to **Knowledge**

  ![alt text](images/knowledge-sharepoint.png)

9. Select **SharePoint**, and paste the SharePoint Knowledge URL and select **Add**.

> [!IMPORTANT]
>  * For configuration, use the provided values in the **Lab Resources** (specific per training).

10. Choose **Add**  

11. Test your agent with this question: 

``` 
What's the Northwind Health Plus Benefits plan?
```

> [!TIP]
> - Notice how relevant it is, and how the citations are accurate. This demonstrates the power of grounded AI responses.

---

###  🏅 Congratulations! You've completed Use Case #1!

---

### Test your understanding

**Key takeaways:**

* **Solution Management** – Using solutions ensures proper environment management and deployment capabilities
* **Knowledge Integration** – SharePoint integration provides immediate access to organizational documents with proper citations
* **Grounded AI** – The agent automatically provides source citations, ensuring transparency and trust in responses

---

## 🔄 Use Case #2: Configure Suggested Prompts

Guide users toward your agent's best capabilities through strategic prompt suggestions.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Configure Suggested Prompts | Guides users toward the agent's best capabilities through strategic prompt suggestions | 3 minutes |

**Summary of tasks**

Suggest things your agent can do to your end-users through carefully crafted prompts.

**Scenario:** Help users discover the full capabilities of your agent by providing clear, actionable suggestions that demonstrate different use cases.

### Step-by-step instructions

1. Go to the **overview** tab for your agent

2. Add suggested prompts:

| Title                     | Prompt                                           |
|---------------------------|--------------------------------------------------|
| `Ask me about benefits`     | `What's the Northwind Health Plus Benefits plan?` |
| `Ask me about policies`     | `What's the leave policy in Germany?`              |
| `Help fill out meeting notes` | `Capture and structure meeting notes`            |
| `Check on an incident`      | `What's the status of INC0007001?`                |


3. **Save** the prompts

> [!TIP]
> - Prompts are visibile to the end-user when the agent is deployed as a Copilot agent.

---

###  🏅 Congratulations! You've completed Use Case #2!

---

### Test your understanding

* How do suggested prompts improve user adoption and engagement with your agent?
* What makes an effective suggested prompt versus a generic one?

---

## 🔄 Use Case #3: Deploy to Microsoft 365 Copilot

Make the agent available in Microsoft 365 Copilot for seamless user access.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Deploy to Microsoft 365 Copilot | Makes the agent available in Microsoft 365 Copilot for seamless user access | 5 minutes |

**Summary of tasks**

Make the agent available in Microsoft 365 Copilot for your users.

**Scenario:** Deploy your agent where employees already work, ensuring maximum adoption by integrating directly into their daily Microsoft 365 workflow.

### Step-by-step instructions

1. Go to the agent and select **Publish**

2. Go to **Channels**

3. Select **Teams and Microsoft 365 Copilot**

4. Select **Add channel** (at the bottom right corner)

5. Select **See agent in Microsoft 365** 

  ![alt text](images/m365-copilot-channel.png)

6. In the **M365 Copilot** experience, the agent description will pop up. Select **Add**

> [!TIP]
> - You may need to give it a few tries/minutes the first time you deploy to Microsoft 365 Copilot so it deploys correctly. 
> - If this doesn't work, try in Teams instead:
>   - Choose **See agents in Teams** instead. If you can
>   - In the new window, if prompted *This site is trying to open Microsoft Teams*, select **Cancel**, and the select **use the web app instead**

7. Test the agent with the benefits prompt

> [!TIP]
> If deploying to Teams,  prompts won't be available, so paste the below question:
> 
> ``` 
> What's the Northwind Health Plus Benefits plan?
> ```


---

###  🏅 Congratulations! You've completed Use Case #3!

---

### Test your understanding

* Why is deploying to Microsoft 365 Copilot more effective than standalone deployment for enterprise scenarios?
* What considerations should you have when choosing deployment channels?

---

## 🔄 Use Case #4: Knowledge Prioritization Techniques

Implement context-aware knowledge routing for personalized and relevant responses.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Knowledge Prioritization Techniques | Implements context-aware knowledge routing for personalized and relevant responses | 8 minutes |

**Summary of tasks**

In this section, you'll learn different techniques to help prioritize the right knowledge sources based on context.

**Scenario:** The SharePoint site has different folders for different country leave policies. Asking "What's the leave policy?" doesn't return relevant results and seems to randomly pick a leave policy for a country. You need to implement context-aware routing.

### Step-by-step instructions

Let's start by asking for the user country at the beginning of the conversation. In many situations, this can be obtained from context, either passed from a web page to the agent, or by making an initial call (for example to the Entra ID connector) to get more information about the logged-in user and their location.

1. In your 'Ask Me Anything' agent, go to **Topics**, and **System topics**
2. Open the **Conversation Start** topic
3. Right after the trigger, add a **Question node**: "What is your country?"
4. Configure **France**, **Germany**, **India**, **USA** as options for the user
5. Select the **Var1** variable, rename it to **Country**, and make it **Global**
6. Click **Save**

With these steps, users need to pick a country at each conversation start. This can be automated, for example the page the agent is embedded in could pass that variable as context, or if the user is logged in, a call to the Entra ID details of the user could retrieve additional information on their location.

7. Go to the **Topics** tab, and create a new topic named **Leave policy**
8. Provide this description for the trigger: "Use this tool for questions about leave policy and time off"
9. Add a new node: **Advanced > Generative answer**
10. For input, select the **Activity.Text** system variable
11. Go to the properties of the **Create generative answers** node
12. Select **Search only selected sources** (there should be none selected)
13. Under classic data, for SharePoint, toggle **Manual input** to **Formula**
14. Select the **…** and go to the **formula** tab
15. Use this formula to make the SharePoint URL dynamic based on the country selected by the user:
    ```
    [ "https://copilotstudiotraining.sharepoint.com/Shared Documents/Leave policies/" & Global.Country ]
    ```
16. Select **Insert** once done, then **Save** your topic
17. Refresh the test pane, select any country, and ask: "What's the leave policy?"

Try multiple times and validate that the results are correct for the different countries.

> [!TIP]
> **PRO TIPS:**
> • There are multiple ways to do knowledge prioritization. You could add to your agent instructions your Country global variable, and instruct the agent to "Always ground your HR questions knowledge search with the user location: {Global.Country}"
> • If formulas are too much code, you could also use condition nodes and configure different branches based on the selected country.

18. For convenience for the rest of the lab, you can go back to **Conversation Start**, and add, right after the trigger, a **Set a variable value** node, to set the **Global.Country** to a default value of your choice.

That way, because it already has a value, the question will be skipped (you can play with the question behavior to decide whether a question should be skipped or not when a value already exists or is detected for the variable).

---

###  🏅 Congratulations! You've completed Use Case #4!

---

### Test your understanding

* How does context-aware knowledge routing improve the accuracy of responses?
* What other user attributes could be used for knowledge prioritization in enterprise scenarios?

---

## 🔄 Use Case #5: Add ServiceNow Incidents

Integrate real-time incident management for comprehensive support capabilities.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Add ServiceNow Incidents | Integrates real-time incident management for comprehensive support capabilities | 5 minutes |

**Summary of tasks**

In this section, you'll configure the connection to ServiceNow to retrieve incident details.

**Scenario:** Employees need quick access to their ServiceNow incident status without navigating to the ServiceNow portal, improving productivity and reducing support burden.

### Step-by-step instructions

1. Go to the agent
2. Go to **Tools**, and **Add tool**
3. Select **ServiceNow** and choose **List records**
4. Select **Add to agent**
5. Open **List records**
6. Under **Additional details**, change **Authentication** to **Agent author authentication**
7. Rename to **Get ServiceNow ticket details**
8. Change description to "Gets the details of an incident using its incident number"
9. For **Record Type**, set a **Custom value** and choose **Incident**
10. Add input: **Query**
    Click **Customize** and use this for Description:
    "The output of this variable is the concatenation of numberCONTAINS and the incident number. E.g., 'numberCONTAINSINC0007001'. Only the incident number should be prompted and obtained from the user (e.g., INC0007001)"
11. Add input: **Limit**
    Select **Custom Value** and set **1**
12. Click **Save**
13. Test your agent with a question: "what's the status of case INC0000059"

> [!TIP]
> Notice how the agent automatically formats the user response in a user-friendly way.

---

###  🏅 Congratulations! You've completed Use Case #5!

---

### Test your understanding

* How does ServiceNow integration enhance the employee experience compared to traditional ticket lookup methods?
* What other enterprise systems could benefit from similar agent integration?

---

## 🔄 Use Case #6: Add Custom Knowledge

Extend knowledge base with custom HTTP endpoints for enterprise system integration.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| Add Custom Knowledge | Extends knowledge base with custom HTTP endpoints for enterprise system integration | 7 minutes |

**Summary of tasks**

In this section, you'll configure any third-party knowledge to enrich knowledge results.

**Scenario:** Your organization has custom knowledge systems or APIs that contain valuable information not available in standard connectors. You need to integrate these sources into your agent.

### Step-by-step instructions

1. Go to the agent
2. Go to **Topics**, add a new topic
3. Call your topic **Custom Knowledge**
4. Go to **More …** and open **Code editor**
   Replace with the below YAML code:
   ```yaml
   kind: AdaptiveDialog
   beginDialog:
     kind: OnKnowledgeRequested
     id: main

   inputType: {}
   outputType: {}
   ```
   Once done, click **Save** and **Close the code editor**

5. Add a new node > **Advanced**, **Send HTTP request**
6. For **URL**, choose the **Custom Knowledge Endpoint** environment variable you had created
7. **Method**: Post
8. **Response data type**: Table
9. **Edit Schema**:
   ```yaml
   kind: Table
   properties:
     Article: String
     Id: String
     Title: String
     URL: String
   ```
10. **Edit Headers and body**
11. **Body**: JSON content
12. Change **Edit JSON** to **Edit formula** and paste the below:
    ```json
    {
        SearchQuery: System.Activity.Text
    }
    ```
13. **Save response as** KnowledgeResults variable
14. Add a **Set a variable value** node
15. Select **System** > **SearchResults**
16. **To value formula**:
    ```
    ForAll(
        Topic.KnowledgeResults,
        {
            Title: Title,
            Content: Article,
            ContentLocation: URL
        }
    )
    ```
17. **Save**
18. Test: "How do I update the vendor information for an accounts payable invoice?"

---

###  🏅 Congratulations! You've completed Use Case #6!

---

### Test your understanding

* How does custom knowledge integration expand the capabilities of your agent beyond standard connectors?
* What considerations should you have when integrating custom APIs for knowledge sources?

---

## 🔄 Use Case #7: AI Summary and Review of Meeting Notes

Automate document analysis with human review workflows for accuracy and approval.

| Use case | Value added | Estimated effort |
|----------|-------------|------------------|
| AI Summary and Review of Meeting Notes | Automates document analysis with human review workflows for accuracy and approval | 7 minutes |

**Summary of tasks**

In this section, you'll learn how to upload files and run files through a prompt for analysis, and how to use adaptive cards to ask for human review for edits before submitting a meeting report.

**Scenario:** Employees need help structuring meeting notes efficiently while maintaining human oversight for accuracy. You'll implement AI-powered analysis with human review workflows.

### Step-by-step instructions

1. Go to the agent
2. Go to **Topics**, add a new topic
3. Call your topic **Meeting Notes**
4. Describe what the topic does: "Help with meeting notes"
5. Add a **Question node**: "Please upload your meeting notes"
   **Identify**: File
   Rename variable as **File**

6. Add a new node > **Add a tool** > **New prompt**
7. **Name**: Meeting AI Notes
8. Add **Content**: **Image or Document**
   As a sample, use Meeting Minutes.pdf from aka.ms/MCSWorkshopLabAssets
9. In the instructions, add:
   ```
   Using the content in the document, create an output JSON file with these different string properties (each of them are a single text string)

   - title
   - description of the meeting
   - date and time
   - attendees
   - actions
   ```
10. **Output**: JSON
11. **Test and Save** the prompt
12. Choose the **File** variable as Input
13. Name the output variable as **MeetingAINotes**
14. Add a new node, **Ask with Adaptive Card**
15. Go to **Edit adaptive card**
16. In the **Card payload editor**, paste:
    ```json
    {
      "type": "AdaptiveCard",
      "version": "1.5",
      "$schema": "https://adaptivecards.io/schemas/adaptive-card.json",
      "body": [
        {
          "type": "TextBlock",
          "text": "Please review and confirm the meeting minutes",
          "weight": "Bolder",
          "size": "Medium"
        },
        {
          "type": "Input.Text",
          "id": "meetingTitle",
          "label": "Meeting title",
          "value": "title"
        },
        {
          "type": "Input.Text",
          "id": "attendees",
          "label": "Attendees",
          "value": "attendees"
        },
        {
          "type": "Input.Text",
          "id": "date",
          "label": "Date",
          "value": "date"
        },
        {
          "type": "Input.Text",
          "id": "summary",
          "label": "Meeting summary",
          "isMultiline": true,
          "value": "description"
        },
        {
          "type": "Input.Text",
          "id": "nextSteps",
          "label": "Next steps",
          "isMultiline": true,
          "value": "actions"
        }
      ],
      "actions": [
        {
          "type": "Action.Submit",
          "title": "Confirm minutes"
        }
      ]
    }
    ```

    > [!TIP]
    > Notice how the Adaptive Card editor offers a visual editor to create your own Adaptive Card experience with a no-code/low-code editor.

17. **Save and Close**

    At that point, your Adaptive Card is in a static JSON format. In order to reference variables and make it dynamic, you need to make it a formula.

18. Toggle **JSON card** to **Formula**
19. Expand the formula to full screen
20. Replace each dynamic value, with the corresponding variable.
    For example, replace "attendees" with `Topic.MeetingAINotes.structuredOutput.attendees`
    
    Use IntelliSense suggestions by typing "Topic." to be suggested the Topic variables, "Global." to be suggested the global variables, "System." to be suggested the system variables, and "Env." to be suggested the environment variables.

    > [!TIP]
    > Notice how your variables don't need quotes.

    Do this for the values of "title", "attendees", "date", "description", "actions"

21. **Save** your topic
22. Test your agent – you can reuse the same Meeting Minutes.pdf: "Please upload your meeting notes"

> [!IMPORTANT]
> Note: the lab ends here, but imagine storing these in system of record, for example Dataverse, as a next step, after the user has confirmed the content.

---

###  🏅 Congratulations! You've completed Use Case #7!

---

### Test your understanding

* What are the benefits of implementing human review workflows in AI-powered document analysis?
* How could you extend this pattern to other document types in your organization?
* What next steps could you implement to store the confirmed meeting notes?

**Challenge: Apply this to your own use case**

* What other document types could benefit from AI-powered analysis and structuring?
* How could you implement approval workflows for AI-generated content in your organization?
* What integration points would be valuable for storing confirmed content?

---

## 🏆 Summary of learnings

True learning comes from doing, questioning, and reflecting—so let's put your skills to the test.

To maximize the impact of your "Ask me anything" agent:

* **Knowledge Integration** – Connect multiple data sources to provide comprehensive answers from a single conversational interface, eliminating information silos
* **Context Awareness** – Implement dynamic knowledge routing based on user attributes to ensure personalized and relevant responses
* **Seamless Deployment** – Deploy to Microsoft 365 Copilot to meet employees where they already work, maximizing adoption and convenience
* **AI with Human Oversight** – Combine AI-powered automation with human review processes to maintain accuracy while improving efficiency
* **Continuous Improvement** – Monitor usage patterns and user feedback to iteratively enhance knowledge sources and response quality

---

### Conclusions and recommendations

**Ask me anything agent golden rules:**

* Start with high-value, frequently asked questions to demonstrate immediate ROI
* Implement proper authentication and permissions to ensure knowledge security
* Use suggested prompts to guide users toward the agent's best capabilities
* Design context-aware experiences that reduce user input while increasing relevance
* Maintain human oversight for critical processes while automating routine tasks
* Monitor and analyze conversation patterns to identify knowledge gaps and improvement opportunities

By following these principles, you'll create an intelligent knowledge hub that transforms how employees access information, reduces support burden, and improves organizational efficiency through conversational AI.

---
