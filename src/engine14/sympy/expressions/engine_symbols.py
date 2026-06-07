from __future__ import annotations

from sympy import symbols

# Core identity symbols
engine_id, revision = symbols("engine_id revision")

# Behavioural invariants
deterministic, idempotent, reproducible = symbols(
    "deterministic idempotent reproducible"
)

__all__ = [
    "engine_id",
    "revision",
    "deterministic",
    "idempotent",
    "reproducible",
]
