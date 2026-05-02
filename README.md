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

1. Upload `cybersecurity.csv` to a public HTTPS location.
2. Update `neo4j-schema.cypher` to use:
   ```cypher
   LOAD CSV WITH HEADERS FROM 'https://your-public-url/cybersecurity.csv' AS row