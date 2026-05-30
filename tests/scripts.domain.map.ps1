# ============================
# DOMAIN → MESH NODE MAPPER
# ============================

$global:DomainMesh = @(
    @{
        Domain = "robdoe.com"
        Node   = "identity.primary"
        Role   = "root-human"
        Weight = 1.0
    },
    @{
        Domain = "robertdoe.pw"
        Node   = "identity.secondary"
        Role   = "root-shadow"
        Weight = 0.9
    },
    @{
        Domain = "aiagency101.pw"
        Node   = "agency.surface"
        Role   = "public-face"
        Weight = 0.8
    },
    @{
        Domain = "aiagency101.depin"
        Node   = "agency.compute"
        Role   = "sovereign-compute"
        Weight = 1.0
    },
    @{
        Domain = "aiagency101.xyo"
        Node   = "agency.anchor"
        Role   = "xyo-anchor"
        Weight = 0.95
    },
    @{
        Domain = "(   .   Y    .   )ENGINE"
        Node   = "engine.core"
        Role   = "internal-pattern"
        Weight = 1.0
    }
)

Write-Host "Domain mesh loaded:" -ForegroundColor Cyan
$DomainMesh | Format-Table Domain,Node,Role,Weight
