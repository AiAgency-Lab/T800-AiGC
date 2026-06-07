from __future__ import annotations

from sympy import simplify
from sympy.logic.boolalg import Boolean

from engine14.sympy.constraints.invariants import invariant_constraints


def evaluate_invariants() -> dict:
    """
    Evaluate and simplify the ENGINE14 invariant set.

    Returns a plain dict so orchestration / XYO layers
    can consume it without depending on SymPy types.
    """
    expr: Boolean = invariant_constraints()
    simplified = simplify(expr)

    return {
        "expression": str(expr),
        "simplified": str(simplified),
    }
