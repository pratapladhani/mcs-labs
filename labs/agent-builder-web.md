# Create your own web-based AI assistant with Microsoft Copilot Studio agent builder

Create an intelligent agent in Copilot that delivers contextual, multi-part answers using instructions and data from the Web.

---

## Lab Details

- **Level**: 100  
- **Persona**: Basic Maker  
- **Purpose**: Learn to create and share a Copilot agent in Microsoft 365 Copilot Chat that uses instructions, websites, and prompts to answer questions about Microsoft Copilot.  
- **Estimated Time**: 15 minutes  

---

## Prerequisites

- Access to Microsoft 365 Copilot or Copilot Chat  
- Ability to create a Copilot agent  

---

## Summary of Targets

In this lab, you’ll create a Copilot agent in Microsoft 365 Copilot Chat designed to assist users with questions about Copilot agents. The agent will act as a learning companion or teacher, grounded in official Microsoft documentation.

By the end of the lab, your agent will be able to:

- Explain the differences between Microsoft 365 Copilot and Copilot Chat  
- Clarify Declarative vs. Custom Engine Agents  
- Guide users on how to create and use Copilot agents  
- Provide answers based on trusted Microsoft documentation  

---

## Use Case

**Create and share an agent in Copilot Chat**  
Use Copilot Studio agent builder to create a declarative agent and obtain a shareable link.

> [!TIP]  
> **Tagline**: Build smarter support, faster – Design a tailored agent that understands your audience and delivers answers grounded in trusted Microsoft documentation.

---

## Summary of Learnings

> Mastery is not a destination but a journey—a joyful path where every step brings growth, discovery, and endless possibilities.

---

## Step-by-Step Instructions

1. Navigate to [Microsoft 365 Copilot home page](https://copilot.cloud.microsoft/?auth=2&home=1)  
   _Note: if you see ‘coming soon’ try again in a few minutes._

2. Go to the **Copilot** tab.

> [!TIP]  
> Microsoft 365 Copilot and Copilot Chat are designed for B2E (Business-to-Employee) use. Users can toggle between Work (M365 Copilot) and Web (Copilot Chat) experiences.  
>  
> Microsoft 365 Copilot is a licensed offering ($30/user/month) with premium features:
> - Integration with Office apps  
> - Enterprise data grounding (Outlook, Teams, SharePoint)  
> - Advanced capabilities (image generation, code interpreter)  
>  
> Copilot Chat is a web-grounded experience, similar to ChatGPT, and can use organizational data with a pay-as-you-go Azure subscription.  
>  
> Copilot agents come in two types:
> - **Declarative agents**: Simple, scoped tasks, use Copilot core  
> - **Custom engine agents**: Complex, external orchestration

3. If licensed, ensure you’re in the **Web** tab (or you only have Web access if no toggle is visible).

4. Test the experience:
```

What are the top things to do around Düsseldorf in May?

```

5. Select **Start a new chat** to reset.

6. Select **Create an agent**  
   _Note: if missing, refresh with Ctrl + F5._

7. Describe the agent:
```

I want to build a teacher-style agent that helps users learn about Copilot, including the differences between Microsoft 365 Copilot and Copilot Chat, Declarative Agents vs. Custom Engine Agents, and how to use the Copilot Studio agent builder. The agent should ask questions to validate and reinforce user understanding, encourage exploration, and act as a knowledgeable guide grounded in Microsoft documentation.

```

8. Choose tone:
```

Friendly, personal, and emphatic tone. You can use irony and emojis when appropriate.

```

9. Provide websites:
```

[https://learn.microsoft.com/en-us/microsoft-365-copilot](https://learn.microsoft.com/en-us/microsoft-365-copilot)
[https://learn.microsoft.com/en-us/copilot](https://learn.microsoft.com/en-us/copilot)

```

10. Suggest prompt updates:
```

* Microsoft 365 Copilot vs. Copilot Chat
* Declarative vs. Custom Engine Agents
* Copilot agents governance
* Pay-as-you-go options for Copilot Chat

```

11. In **Configure**:
    - Enable Code Interpreter and Image Generator  
    - Add more sources if needed  

12. Use the test pane, then select **Create**.

13. Copy the agent link and share.

14. Test your agent:
```

What are the differences between Microsoft 365 Copilot and Copilot Chat?

```

15. To edit existing agents: **Create an agent** > **My agents**

---

## Test Your Understanding

**Key Takeaways:**

- Microsoft 365 Copilot vs. Copilot Chat – one is grounded in Microsoft 365 data, the other in web data  
- Declarative vs. Custom Engine Agents – scoped vs. orchestrated use cases  
- Grounding in trusted documentation = better answers  
- Well-designed agents prompt exploration, not just provide answers  

> [!TIP]  
> - Use short, clear prompt titles  
> - Check grounding if answers are generic  
> - Web search toggle affects response sources  

---

## Challenge

- Define your agent’s tone and personality  
- Choose grounding sources (internal/public)  
- Add test questions for validation  
- Try building a second agent on another Copilot topic (governance, licensing, etc.)

---

## Summary of Learnings

> True learning comes from doing, questioning, and reflecting—so let’s put your skills to the test.

- Understand Microsoft 365 Copilot vs. Copilot Chat  
- Know agent types and appropriate use cases  
- Define clear agent intent, tone, and instructional strategy  
- Use validated grounding sources  
- Design prompts that teach and challenge  
- Test and iterate based on feedback  

---

## Conclusions & Recommendations

> [!IMPORTANT]  
> To maximize your Copilot agent’s impact:
> - Keep prompts purposeful and refined  
> - Keep sources up to date  
> - Use a friendly tone with clear intent  
> - Disable generic AI if accuracy is critical  
> - Include reflective prompts to reinforce learning  

By following these principles, your agent will not only deliver accurate content—it will support meaningful learning experiences within the Microsoft 365 Copilot ecosystem.

---

## Glossary

| Term | Definition |
|------|------------|
| **Agent** | Customized assistant created in Copilot Studio |
| **Copilot Chat** | GPT-based AI experience using public web data |
| **Microsoft 365 Copilot** | Enterprise AI tool grounded in Microsoft Graph data |
| **Declarative Agent** | Instruction-based Copilot agent |
| **Custom Engine Agent** | Advanced agent with its own engine, not Copilot-native |
| **Grounding** | Anchoring answers in defined data sources |
| **Instruction** | Configuration that defines agent behavior and tone |
| **Prompt** | Suggested questions shown in chat UI |
| **Web search toggle** | Allows/disables use of general web content in responses |

---

> We want your feedback! 🚀
