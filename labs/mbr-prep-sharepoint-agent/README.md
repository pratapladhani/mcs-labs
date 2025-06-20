# Create an MBR Agent

This guide provides step-by-step instructions for creating an MBR (Monthly Business Review) Agent, which is designed to streamline the preparation process for MBRs. By following the guide, users will learn how to query resources and obtain quick answers, ultimately enhancing efficiency and organization for business reviews. It's a valuable tool for anyone looking to optimize their workflow and ensure they are well-prepared for important business discussions. 
---

## 🧭 Lab Details

| Level | Persona | Duration | Purpose |
| ----- | ------- | -------- | ------- |
| 100 | Maker/Developer | 10 minutes | After completing this lab, participants will be able to create a conversational agent hosted in SharePoint. You'll learn how to add knowledge sources, test and publish to SharePoint. |

---

## 📚 Table of Contents

- [Why This Matters](#-why-this-matters)
- [Introduction](#-introduction)
- [Core Concepts Overview](#-core-concepts-overview)
- [Documentation and Additional Training Links](#-documentation-and-additional-training-links)
- [Prerequisites](#-prerequisites)
- [Summary of Targets](#-summary-of-targets)
- [Instructions](#️-instructions-by-use-case)
---

## 🤔 Why This Matters

**Managers and Team Leads** – Drowning in slide decks, scattered data, and last-minute scramble sessions before Monthly Business Reviews?

Think of a traditional MBR prep process:  
- **Without agents**: Leaders dig through dozens of decks, copy/paste insights, manually summarize risks and themes, and chase down team updates – all while trying to spot patterns across silos  
- **With agents**: AI reads files from SharePoint, extracts key themes (like at-risk deals or blockers), and delivers concise summaries you can act on – no digging required

**Common challenges solved by this lab:**
- "We waste hours each month trying to consolidate MBR decks from every team"
- "Leadership misses key risks or repetitive asks buried in PowerPoint files"
- "It's hard to spot trends across different teams without a data analyst"
- "We're reactive instead of proactive when it comes to business risks"

**In just 10 minutes, you’ll learn how to build an agent that helps leaders get to the ‘so what’ faster—turning static decks into actionable insights.**

## 🌐 Introduction

Monthly Business Reviews (MBRs) are critical for keeping leadership informed, identifying risks, and aligning on key initiatives. But the preparation process is often tedious and fragmented, requiring hours of manual effort to gather, review, and summarize insights from multiple teams.

**Real-world example:** A regional sales org prepares for its MBR by collecting slide decks from over 10 team leads. Each deck includes updates, at-risk deals, and escalations—buried across inconsistent formats and file names. A single director spends 4–6 hours manually scanning each one, summarizing recurring themes, and building a master summary for leadership.

After implementing an agent, the director simply prompts the system to scan the latest MBR files in SharePoint. Within seconds, the agent highlights common risks, summarizes recurring asks, and surfaces trends across teams. Now the director can focus on strategic insights—not file wrangling.

---

## 🎓 Core Concepts Overview

| Concept | Why it matters |
|---------|----------------|
| **Conversational Agent** | Powers natural, chat-like interactions so users can ask about MBR themes, risks, and takeaways without needing to dig through files manually |
| **Knowledge** | Enables the agent to read and understand content from past MBR decks stored in SharePoint, so it can extract relevant insights and patterns |
| **Testing in Copilot Studio** | Helps you validate that the agent understands user intent and returns accurate, useful responses before it's shared with others |
| **Publishing to SharePoint** | Makes the agent accessible to your team directly from a SharePoint site, so anyone preparing for an MBR can use it on demand |
| **SharePoint Agent Setup** | Seamlessly integrates with your existing file storage so your agent always has access to the latest MBR decks—no need to move files around |

---
## 📄 Documentation and Additional Training Links

* [Microsoft Copilot Studio Documentation](https://learn.microsoft.com/en-us/microsoft-copilot-studio/)

* [Copilot Studio Triggers and Actions](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-trigger-actions)

---
## ✅ Prerequisites

* Access to Microsoft Copilot Studio with appropriate licensing
* Office 365 environment with SharePoint access

---
## 🎯 Summary of Targets

In this lab, you'll build a conversational MBR agent that streamlines how managers and leaders access insights across Monthly Business Review decks. By the end of the lab, you will:

* Create and configure a conversational agent using Copilot Studio
* Add knowledge sources by linking SharePoint-stored MBR files to the agent
* Test the agent to ensure it can accurately summarize risks, trends, and key themes
* Publish the agent to a SharePoint site so it's easily accessible to stakeholders
* Enable your team to ask questions like “What are the common risks this month?” and get immediate, actionable answers

---
## 🛠️ Instructions

1\. Go to [portal.office.com](https://portal.office.com) and select `SharePoint`

![SharePoint](./assets/select-sharepoint.jpeg)


2\. Select `Create Site`

![Create Site](./assets/create-site.png)


3\. Select `Team Site`

![Team Site](./assets/team-site.png)


4\. Select `Standard team`

![Standard Team](./assets/select-template.png)

5\. Select `Use Template`

![Use Template](./assets/use-template.png)

6\. Put `MBR` in the Site Name and Select `Next`

![Create Site](./assets/site-name.png)

7\. Click `Finish`

![Select Finish](./assets/select-finish-site-creation.jpeg)

8\. Navigate to the [sample files folder](/assets/sample-files/) and download the sample files

9\. Select `Documents` in the left navigation

![Open Document Library](./assets/select-document-library.jpeg)


10\. Select `Upload`

![Upload Files](./assets/select-upload.jpeg)


11\. Select all the sample files you just downloaded and click `Open`

![Select Open](./assets/select-sample-files.jpeg)

12\. Open a new browser tab and navigate to [copilotstudio.microsoft.com](copilotstudio.microsoft.com). Select `Create`

![Select Create](./assets/create-agent.jpeg)


13\. Select `New agent`

![Select New Agent](./assets/new-agent.jpeg)

14\. In the `Name` field type `MBR Agent`. In the `Description` field type,  `This agent helps in preparing for Monthly Business Reviews. It queries MBR resources and provides quick answers`

![Fill out Agent Details](./assets/agent-name.jpeg)


15\. Select `Create`

![Select Create](./assets/create-button.jpeg)


16\. Select `Add knowledge`

![Select Add Knowledge](./assets/add-knowledge.jpeg)


17\. Select `SharePoint`

![Select SharePoint](./assets/sharepoint-knowledge.jpeg)

18\. Paste the url of your SharePoint site in the text input

![Paste SharePoint URL](./assets/sharepoint-url.jpeg)

19\. Select `Add`

![Select Add Knowledge](./assets/add-sp-knowledge1.jpeg)


20\. Select `Add` again

![Select Add](./assets/add-knowledge2.jpeg)


21\. Now we need to test our agent to see if it returns answers from our knowledge. Click in the text box in the testing panel.

![Test Panel](./assets/empty-test-panel.jpeg)


22\. Type `what deals are currently in the negotiation stage?` and press the `Return` key

![Test the agent](./assets/test1.jpeg)

23\. Review the answer in the test window and notice the logic in the Activity Pane on the left hand side

![Review the answer](./assets/review-answer.jpeg)

24\. Now that we know the agent is working, we need to publish our changes by selecting the `Publish` button in the upper right hand corner.

![Select Publish](./assets/publish.jpeg)

25\. Now it's time to deploy our agent to SharePoint. Select the `Channels` tab.

![Select Channels](./assets/channels-tab.jpeg)


26\. Select `SharePoint`

![Select SharePoint](./assets/channels-sharepoint.jpeg)

27\. Select the SharePoint site you created in the previous steps from the list of options

![Select the SharePoint Site](./assets/sharepoint-dropdown.jpeg)

28\. Select `Deploy`

![Select Deploy](./assets/deploy.jpeg)

29\. Select the `...` next to the Deployed text and select `Copy Site Url`. Open a new browser tab and paste in the URL.

![Select Copy Site URL](./assets/copy-url.jpeg)

30\. Select the `Documents` library on the left hand navigation.

![Select Documents](./assets/select-document-library.jpeg)


31\. Select the `MBR Agent` from the library

![Select MBR Agent](./assets/doc-mbr-agent.jpeg)

32\. Your agent will open up on the right hand side. Test it out by typing `What are the top 3 blockers?` in the text input and pressing `Return`

![Testing the agent](./assets/deployed-test1.jpeg)


33\. Review the answer and note that it provides links to the referenced documents.

![Review the first test](./assets/deployed-review1.jpeg)


34\. Perform another test by typing `Which reps requested additional pre-sales support?` and pressing `Return`

![Testing the agent](./assets/deployed-test2.jpeg)


35\. Review your response. Congratulations! You've built and deployed your SharePoint MBR Agent!

![Review the second test results](./assets/dpeloyed-review2.jpeg)



