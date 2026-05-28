# AiAgency Sovereign Mesh

This repository defines a sovereign identity and mesh ecosystem anchored to:

`0x1ae2af702063d304f8ebac2153c91d79c62e381c`

## Domains

- `robdoe.com`  public identity root  
- `robertdoe.pw`  sovereign identity root  
- `aiagency101.pw`  agency and verification portal  
- `aiagency101.xyo`  mesh coordinate layer (placeholder, not yet owned)

## Layers

- **Static mesh:** JSON definitions in `domain/`, `mesh/`, `slots/`, `registry/`
- **Live mesh:** Cloudflare Workers in `workers/` and config in `cloudflare/`
- **Engines:** Logical definitions in `engines/` including the identity resolver

## Resolver

The resolver engine maps:

`domain  slot  coordinate  node  wallet`

See `engines/identity_resolver.json` and `ecosystem.json`.
