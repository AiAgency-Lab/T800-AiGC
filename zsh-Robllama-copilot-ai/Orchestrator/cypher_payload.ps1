# Target the guest VM's local Neo4j endpoint via REST API primitives
$Neo4jUri = "http://localhost:7474/db/data/transaction/commit"
$Headers = @{
    "Authorization" = "Basic " + [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("neo4j:password"))
    "Content-Type"  = "application/json"
}

# The exact 0.052 Kuramoto loop compiled by Qwen
$Body = @{
    statements = @(
        @{
            statement = "CREATE (c:Crown)-[:CONNECTS {coupling_weight: 0.052}]->(te:ThirdEye)-[:CONNECTS {coupling_weight: 0.052}]->(th:Throat)-[:CONNECTS {coupling_weight: 0.052}]->(h:Heart)-[:CONNECTS {coupling_weight: 0.052}]->(sp:SolarPlexus)-[:CONNECTS {coupling_weight: 0.052}]->(s:Sacral)-[:CONNECTS {coupling_weight: 0.052}]->(r:Root)-[:CONNECTS {coupling_weight: 0.052}]->(c);"
        }
    )
} | ConvertTo-Json -Depth 5

# Execute the payload via the internal network stack inside the sandbox
Invoke-RestMethod -Uri $Neo4jUri -Method Post -Headers $Headers -Body $Body
