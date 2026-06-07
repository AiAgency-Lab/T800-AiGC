from __future__ import annotations

from sympy import Eq, And
from sympy.logic.boolalg import Boolean

from engine14.sympy.expressions.engine_symbols import (
    deterministic,
    idempotent,
    reproducible,
)


def invariant_constraints() -> Boolean:
    """
    Symbolic invariant set for ENGINE14.

    Reads as:
      deterministic == True
      idempotent == True
      reproducible == True
    """
    return And(
        Eq(deterministic, True),
        Eq(idempotent, True),
        Eq(reproducible, True),
    )

