
# Portfolio 5 Distributed and Cloud Database Exercise

## Current setup
The current implementation relies on a single local MongoDB instance (mongosh) managing the student_portal_nosql database and its student_activities collection, which holds four sample event documents. A multi-node distributed topology or automated replica set cluster has not been deployed or verified locally.

## Proposed replication
To ensure high availability and fault tolerance for critical event streams such as an ENROLLMENT_SUBMISSION, a three-member replica set is proposed[cite: 1]. This configuration deploys voting, data-holding members across separate failure zones.

| Member | Starting role | Location |
| :--- | :--- | :--- |
| `node-primary` | Primary | Zone A (Primary Datacenter) |
| `node-secondary-1` | Secondary | Zone B (Failover Facility) |
| `node-secondary-2` | Secondary | Disaster Recovery Site |

## Failure and consistency
If the primary node fails, the remaining secondaries automatically trigger an election to select a new primary, resulting in a brief interruption for write operations[cite: 2]. If a majority of voting nodes are unreachable, the replica set cannot elect a primary and rejects new writes. Using majority write concern (w: "majority") guarantees that a write is only acknowledged after persisting to a majority of voting nodes, though secondary replication lag can cause temporary read inconsistencies[cite: 3]. Operational data consistency decisions remain managed by the authoritative MongoDB database instance.

## Sharding and cloud deployment
Sharding distributes subsets of data across multiple instances, whereas replication copies identical datasets to ensure redundancy[cite: 4]. The current small dataset of four student activity records does not require sharding. Moving to a managed cloud deployment requires strict security controls—including authentication, encryption in transit and at rest, and restricted network access—alongside automated backup and restore policies, higher financial costs, and increased operational complexity[cite: 5]. Furthermore, MongoDB replication does not replicate PostgreSQL databases or synchronize data between the two distinct database engines automatically.

## References
- MongoDB Manual — [Replication](https://www.mongodb.com/docs/manual/replication/)[cite: 1]
- MongoDB Manual — [Replica Set Elections](https://www.mongodb.com/docs/v8.0/core/replica-set-elections/)[cite: 2]
- MongoDB Reference — [Write Concern](https://www.mongodb.com/docs/v8.0/reference/write-concern/)[cite: 3]
- MongoDB Manual — [Sharding](https://www.mongodb.com/docs/manual/sharding/)[cite: 4]
- MongoDB Atlas — [Backup and Restore Cluster](https://www.mongodb.com/docs/atlas/backup-restore-cluster/)[cite: 5]