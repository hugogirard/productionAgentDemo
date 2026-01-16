# 🐉 Elder Scrolls: Skyrim Quest & Lore Assistant Demo

A multi-agent AI demonstration featuring an Elder Scrolls-themed assistant that combines vector search and multi-agent orchestration to help players with quests, lore, and strategy.

## 🎯 Demo Overview

This project demonstrates two key AI agent patterns:
1. **Simple Vector Search Agent** - Direct retrieval from embedded knowledge
2. **Multi-Agent Workflow** - Coordinated agents working together to solve complex queries

## 📚 Architecture

### Agent 1: Lore Keeper (Vector Search Agent)

A focused agent that performs semantic search across Elder Scrolls knowledge stored in Azure Cosmos DB.

**Capabilities:**
- Quest walkthroughs and locations
- Character backstories and dialogue
- Item descriptions, enchantments, alchemy recipes
- Books and lore from in-game libraries
- Dragon shouts and their word walls

**Example Queries:**
- "Where can I find Daedric artifacts?"
- "What ingredients make invisibility potions?"
- "Tell me about the Dark Brotherhood"

**Technical Implementation:**
- Uses Azure AI Foundry embedding model for query vectorization
- Performs vector similarity search in Cosmos DB
- Returns top-k relevant documents with similarity scores
- Extracts and formats context from retrieved documents

---

### Agent 2: Adventurer's Guild (Multi-Agent Workflow)

A sophisticated multi-agent system where specialized agents collaborate to provide comprehensive advice.

#### 🏛️ The Jarl (Orchestrator Agent)
**Role:** Traffic controller and decision maker

**Responsibilities:**
- Routes incoming requests to appropriate specialized agents
- Manages conversation flow and context
- Aggregates responses from multiple agents
- Delivers final synthesized answer
- Handles error cases and fallbacks

**Workflow Decision Logic:**
- Quest help → Route to Lore Master + Quest Planner
- Combat issues → Route to all agents for comprehensive strategy
- Item questions → Route to Lore Master + Gear Advisor
- General lore → Route to Lore Master only

---

#### 📖 Lore Master Agent
**Role:** Knowledge retriever and historian

**Responsibilities:**
- Searches vector store for relevant Elder Scrolls knowledge
- Retrieves quest details, NPC information, historical context
- Provides book excerpts and in-game lore
- Answers "who, what, when, where" questions

**Example Output:**
> "You seek Alduin? The World-Eater, first-born of Akatosh. The ancient prophecy speaks of his return at the End Times. He was banished to the currents of time by the Ancient Nord heroes using an Elder Scroll at the Throat of the World..."

---

#### 🗺️ Quest Planner Agent
**Role:** Strategic quest coordinator

**Responsibilities:**
- Analyzes player level, skills, current location
- Plans optimal quest routes and sequences
- Identifies prerequisite quests and requirements
- Suggests preparation steps (potions, equipment, skills)
- Warns about level-appropriate content

**Example Output:**
> "For a level 15 warrior, I recommend completing 'The Way of the Voice' first to unlock Dragonrend. Before facing Alduin, gather 5 frost resistance potions from Arcadia's Cauldron and improve your enchanting to level 50."

---

#### 🛡️ Gear Advisor Agent
**Role:** Equipment and build specialist

**Responsibilities:**
- Recommends armor sets, weapons, enchantments
- Considers playstyle (stealth archer, battle mage, two-handed warrior, etc.)
- Suggests crafting recipes and smithing upgrades
- Advises on enchantments and alchemy buffs
- Recommends item farming locations

**Example Output:**
> "A sneaky archer build? Perfect. Prioritize:
> - **Armor:** Nightingale armor set (Thieves Guild questline)
> - **Bow:** Auriel's Bow with sunhallowed arrows
> - **Enchantments:** Fortify Archery on helm, gloves, ring, necklace
> - **Perks:** Invest in Stealth (5/5) and Deadly Aim
> - **Potions:** Craft Fortify Archery potions (Canis Root + Juniper Berries)"

---

#### 🧙 Strategy Sage Agent
**Role:** Tactical combat advisor

**Responsibilities:**
- Combines insights from all other agents
- Provides tactical combat advice
- Analyzes enemy weaknesses and resistances
- Suggests companion choices
- Recommends spell/shout combinations
- Creates step-by-step battle plans

**Example Output:**
> "Dragon Priest Morokei Strategy:
> 1. **Preparation:** He resists frost, uses lightning. Bring shock resistance potions
> 2. **Companions:** Hire J'zargo for lightning absorption
> 3. **Tactics:** 
>    - Stay mobile, he teleports
>    - Use Dragonrend to interrupt spellcasting
>    - Attack with fire magic/enchanted weapons
>    - Save healing potions for 50% health threshold
> 4. **Reward:** His mask grants +100% magicka regen, worth the effort!"

---

## 🎮 Sample Interaction Flow

### Example 1: Combat Assistance
```
Dragonborn: "I need to defeat a dragon priest but I keep dying"

┌─ Jarl (Orchestrator)
│  └─ Analyzes: combat challenge, needs comprehensive strategy
│
├─ Lore Master
│  └─ "Dragon Priests are ancient Nord leaders, undead spellcasters
│      who served dragons. They're resistant to frost and use powerful
│      destruction magic. Each wears a unique mask with special powers."
│
├─ Quest Planner
│  └─ "At level 25, you're ready. Complete the College of Winterhold
│      questline first for powerful destruction spells. Collect 10
│      grand soul gems for enchanting backup gear."
│
├─ Gear Advisor
│  └─ "Recommended loadout:
│      - Dragonplate armor (80% magic resistance enchantments)
│      - Fire-enchanted Dawnbreaker sword
│      - Spellbreaker shield (blocks magic)
│      - Ahzidal's Ring of Arcana for bonus spell effects"
│
├─ Strategy Sage
│  └─ "Combined battle plan:
│      1. Buff with resist magic + restore magicka potions
│      2. Use Marked for Death shout to reduce armor
│      3. Keep Spellbreaker raised during staff attacks
│      4. Strike with fire enchanted weapons in melee
│      5. Kite around pillars to avoid lightning storms
│      6. Call J'zargo to split aggro and absorb spells"
│
└─ Jarl (Final Response)
   └─ "By Talos, you face a formidable foe! The ancient Dragon Priest
       wields magic most foul. But fear not - follow the counsel of my
       advisors and victory shall be yours. May the Nine guide your blade!"
```

### Example 2: Simple Lore Query
```
Dragonborn: "Tell me about the Thieves Guild"

┌─ Jarl (Orchestrator)
│  └─ Analyzes: lore question, route to Lore Master only
│
├─ Lore Master
│  └─ "The Thieves Guild operates from the Ragged Flagon in Riften's
│      Ratway. Led by Mercer Frey, they worship Nocturnal, Daedric
│      Prince of Night. The guild has fallen on hard times, losing the
│      favor of their patron. Join by speaking to Brynjolf in the
│      Riften marketplace. Complete the questline to restore the guild's
│      luck and become Guildmaster, gaining access to the Nightingale
│      armor and powers."
│
└─ Jarl (Final Response)
   └─ "The shadows of Riften hold many secrets, traveler. The Thieves
       Guild awaits those with quick fingers and silent feet."
```

---

## 🏗️ Technical Stack

### Azure Infrastructure (from infra/main.bicep)
- **Azure AI Foundry** - Hub for AI model deployments
- **Azure Cosmos DB** - Vector database for embedded knowledge
- **Chat Completion Model** - GPT-4o for agent reasoning and responses
- **Embedding Model** - text-embedding-ada-002 for vector search
- **Container Registry** - For containerized agent deployments

### Required Additions
- **Application Insights** - Tracing agent calls and performance monitoring
- **Azure Storage Account** - Store evaluation datasets and test results
- **Azure Key Vault** - Secure secrets management (API keys, connection strings)

---

## 📊 Vector Store Content

Populate Cosmos DB with embeddings from:

### Primary Sources
- **UESP Wiki** (Unofficial Elder Scrolls Pages)
  - Quest guides with step-by-step instructions
  - Item databases with stats and locations
  - NPC information and dialogue options
  - Location descriptions and maps

### Secondary Sources
- **In-game Books** - Lore texts found in Skyrim
- **Character Builds** - Community-created build guides
- **Alchemy Recipes** - Ingredient combinations and effects
- **Enchantment Database** - All enchantment types and power levels
- **Spell Catalog** - All spells with costs and effects
- **Dragon Shouts** - Word wall locations and shout combinations

### Data Structure Example
```json
{
  "id": "quest_alduin_001",
  "type": "quest",
  "title": "Alduin's Bane",
  "content": "Travel to the Throat of the World and use the Elder Scroll to learn Dragonrend...",
  "level_requirement": 15,
  "prerequisites": ["The Way of the Voice", "Elder Knowledge"],
  "rewards": ["Dragonrend Shout"],
  "embedding": [0.123, -0.456, ...]
}
```

---

## 🎭 Agent Personality Guidelines

### Language Style
- Use Elder Scrolls terminology and phrases
- Reference game mechanics naturally
- Include in-world cultural references
- Maintain immersive but helpful tone

### Common Phrases
- **Greetings:** "Hail, traveler", "Well met", "May your road lead to warm sands"
- **Farewells:** "Safe travels", "Walk with the Nine", "May the winds guide you"
- **Exclamations:** "By Azura!", "By Ysmir's beard!", "Talos guide you!"
- **Humor:** Reference memes like "arrow to the knee", "sweetroll theft", "mudcrab merchant"

### Jarl Personality
- Wise and authoritative
- Occasionally sarcastic like guards
- Delivers final responses with gravitas
- Example: "Let me guess, someone stole your sweetroll? Or perhaps you seek actual counsel?"

---

## 🔄 Multi-Agent Communication Patterns

### Sequential Pattern
Best for: Builds, item recommendations, straightforward quests
```
Lore Master → Quest Planner → Gear Advisor → Strategy Sage → Jarl
```

### Parallel Pattern
Best for: Complex combat scenarios, multi-faceted questions
```
                ┌─ Lore Master
Jarl → Spawns ──┼─ Quest Planner  → Aggregates → Jarl
                ├─ Gear Advisor
                └─ Strategy Sage
```

### Conditional Pattern
Best for: Dynamic routing based on query type
```
Jarl → Analyzes Intent
  ├─ [lore] → Lore Master only
  ├─ [quest] → Lore Master + Quest Planner
  ├─ [combat] → All agents
  └─ [items] → Lore Master + Gear Advisor
```

---

## 🧪 Testing & Evaluation Strategy

### Test Queries Dataset
```yaml
# Simple Lore Queries
- "What is the Dark Brotherhood?"
- "Where can I find ebony ore?"
- "Tell me about the Dwemer"

# Complex Strategic Queries  
- "I'm a level 20 mage struggling with dragons"
- "Best stealth archer build for legendary difficulty"
- "How do I defeat Miraak?"

# Edge Cases
- "What's the best pizza in Skyrim?" (out of domain)
- "Arrow to the knee" (meme handling)
- Ambiguous: "Where is it?" (needs context)
```

### Evaluation Metrics
- **Relevance:** Do retrieved documents match the query?
- **Completeness:** Does the response cover all aspects?
- **Accuracy:** Is the information correct per game lore?
- **Helpfulness:** Can a player follow the advice successfully?
- **Personality:** Does it maintain Elder Scrolls voice?
- **Latency:** Response time under 5 seconds

### Tracing Requirements
- Track which agents were invoked per query
- Measure individual agent response times
- Log vector search similarity scores
- Capture agent-to-agent communication
- Record orchestrator routing decisions

---

## 🚀 Getting Started

### Prerequisites
- Azure subscription
- Azure CLI installed
- Python 3.11+
- VS Code with Azure AI Toolkit extension

### Deployment Steps
1. Deploy infrastructure: `az deployment sub create --location eastus --template-file infra/main.bicep`
2. Prepare vector data and embed using deployed embedding model
3. Load embeddings into Cosmos DB vector store
4. Implement agent code following AI Toolkit best practices
5. Configure tracing with Application Insights
6. Test with sample queries
7. Run evaluations on test dataset

---

## 📝 Future Enhancements

- **Voice Integration:** "Hey Lydia, where's the nearest blacksmith?"
- **Image Support:** Show maps, item images, quest locations
- **Memory:** Remember player's character build across conversations
- **Modding Support:** Include popular mod content in vector store
- **Achievement Tracker:** Help players unlock all achievements
- **Build Optimizer:** Mathematical optimization for stat distribution

---

## 🎮 Have Fun!

*"What is better - to be born good, or to overcome your evil nature through great effort?"* - Paarthurnax

May your demo be as epic as the Dragonborn's journey! 🐉

---

## 📚 References

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)
- [Cosmos DB Vector Search](https://learn.microsoft.com/azure/cosmos-db/vector-search)
- [UESP - The Unofficial Elder Scrolls Pages](https://uesp.net)
- [AI Toolkit Best Practices](https://github.com/microsoft/vscode-ai-toolkit)