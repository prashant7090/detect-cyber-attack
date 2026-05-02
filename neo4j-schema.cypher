// Neo4j schema and import script for cybersecurity.csv

CREATE CONSTRAINT IF NOT EXISTS FOR (i:IPAddress) REQUIRE i.address IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (p:Protocol) REQUIRE p.name IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (u:UserAgent) REQUIRE u.name IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (x:URL) REQUIRE x.value IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (a:AttackType) REQUIRE a.name IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (e:NetworkEvent) REQUIRE e.eventId IS UNIQUE;


LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/prashant7090/detect-cyber-attack/main/cybersecurity.csv' AS row
WITH row,
     CASE WHEN row.user_agent = '' THEN NULL ELSE row.user_agent END AS userAgentText,
     CASE WHEN row.url = '' THEN NULL ELSE row.url END AS urlText,
     toBoolean(row.is_internal_traffic) AS internalTraffic,
     datetime(replace(row.timestamp, ' ', 'T') + 'Z') AS parsedTimestamp,

     //unique event key
     (
        row.timestamp + '|' +
        row.src_ip + '|' +
        row.dst_ip + '|' +
        row.src_port + '|' +
        row.dst_port + '|' +
        row.attack_type
     ) AS eventKey

MERGE (src:IPAddress {address: row.src_ip})
MERGE (dst:IPAddress {address: row.dst_ip})
MERGE (protocol:Protocol {name: row.protocol})
MERGE (attack:AttackType {name: row.attack_type})


MERGE (event:NetworkEvent {eventId: eventKey})
ON CREATE SET
    event.timestamp = parsedTimestamp,
    event.src_port = toInteger(row.src_port),
    event.dst_port = toInteger(row.dst_port),
    event.bytes_sent = toInteger(row.bytes_sent),
    event.bytes_received = toInteger(row.bytes_received),
    event.is_internal_traffic = internalTraffic,
    event.label = toInteger(row.label)

MERGE (src)-[:ORIGINATED]->(event)
MERGE (event)-[:TARGETED]->(dst)
MERGE (event)-[:USES_PROTOCOL]->(protocol)
MERGE (event)-[:CLASSIFIED_AS]->(attack)

FOREACH (_ IN CASE WHEN userAgentText IS NOT NULL THEN [1] ELSE [] END |
    MERGE (ua:UserAgent {name: userAgentText})
    MERGE (event)-[:HAS_USER_AGENT]->(ua)
)

FOREACH (_ IN CASE WHEN urlText IS NOT NULL THEN [1] ELSE [] END |
    MERGE (url:URL {value: urlText})
    MERGE (event)-[:ACCESSED_URL]->(url)
);