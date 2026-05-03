# Detect Cyber Attack

A Neo4j graph modeling project for network traffic events from `cybersecurity.csv`.

## Project files

- `cybersecurity.csv` — raw network event dataset
- `neo4j-schema.cypher` — Neo4j schema and import script

## Schema

Nodes:
- `IPAddress(address)`
- `NetworkEvent(eventKey, timestamp, src_port, dst_port, bytes_sent, bytes_received, is_internal_traffic, label)`
- `Protocol(name)`
- `AttackType(name)`
- `UserAgent(name)`
- `URL(value)`

Relationships:
- `(src:IPAddress)-[:ORIGINATED]->(event:NetworkEvent)`
- `(event:NetworkEvent)-[:TARGETED]->(dst:IPAddress)`
- `(event)-[:USES_PROTOCOL]->(protocol:Protocol)`
- `(event)-[:CLASSIFIED_AS]->(attack:AttackType)`
- `(event)-[:HAS_USER_AGENT]->(ua:UserAgent)`
- `(event)-[:ACCESSED_URL]->(url:URL)`

## Import instructions

### Neo4j Desktop / local Neo4j

1. Place `cybersecurity.csv` into Neo4j’s `import` folder.
2. Open `neo4j-schema.cypher` in Neo4j Browser.
3. Run the script.

### Aura / cloud Neo4j

1. Upload `cybersecurity.csv` to a public HTTPS location. - (In this case, we have given github csc file url.)
2. Update `neo4j-schema.cypher` to use:
   ```cypher
   LOAD CSV WITH HEADERS FROM 'https://your-public-url/cybersecurity.csv' AS row

   Agent Name : Detect Cyber Attack

### What it does :

Find suspicious IPs, repeated malicious destinations, or abnormal traffic patterns.
Detect suspicious clusters of source IPs targeting the same destination
Visualize relationships between events and IPs
Identify repeated AttackType
Use graph traversals to connect IPs, events, protocols, and attack categories.

### Dataset and why a graph fits

1. Cybersecurity Threat Detection Dataset | Kaggle - https://www.kaggle.com/datasets/dhrubangtalukdar/cybersecurity-threat-detection-dataset
2. The dataset is naturally relational: sources, destinations, protocols, and attack labels are all connected.
3. Neo4j lets you query those connections directly instead of flattening them in tabular form.
4. This supports use cases like - find all source IPs that have attacked the same destination” or “group events by attack type and protocol.

**Agent Configuration:**
<img width="1425" height="745" alt="Screenshot 2026-05-03 at 3 11 23 PM" src="https://github.com/user-attachments/assets/8ae2b7e6-fcdc-44f5-9473-d25899da2de5" />

**Cypher template Agent:**
<img width="1432" height="670" alt="Screenshot 2026-05-03 at 3 26 40 PM" src="https://github.com/user-attachments/assets/45e0c4ed-c7fc-4301-abba-349320a0a079" />

**Text2Cypher Agent**
<img width="1440" height="668" alt="Screenshot 2026-05-03 at 3 27 32 PM" src="https://github.com/user-attachments/assets/b25e7923-6bc7-44f9-9b2b-434b64972ecc" />

**Text2Cypher Agent**
<img width="1440" height="671" alt="Screenshot 2026-05-03 at 3 28 23 PM" src="https://github.com/user-attachments/assets/37059141-1f0e-4a39-828f-b3831bbec714" />

<img width="1432" height="669" alt="Screenshot 2026-05-03 at 3 31 39 PM" src="https://github.com/user-attachments/assets/71dcd415-bebb-48bf-931c-b5c5b042fad2" />

**Neo4j Dashboard**
<img width="1280" height="640" alt="Screenshot 2026-05-03 at 3 31 55 PM" src="https://github.com/user-attachments/assets/12f8566c-c52a-4120-8684-336085902821" />

**Neo4j Dashboard**
<img width="1431" height="749" alt="Screenshot 2026-05-03 at 3 32 08 PM" src="https://github.com/user-attachments/assets/9a596b1e-858d-4505-b85a-e1184a850b2b" />




