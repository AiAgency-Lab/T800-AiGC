from sympy import Integer, symbols, Poly, Matrix
import yfinance as yf

# XYO node identity → math
node = Integer(int("466e84dfcbfbae8d50ad4276e8f2b5d37e8834a8", 16))

print("=== XYO NODE + MARKET + MARK OF CHAINS ENGINE ===\n")

# 1. Node as integer
print("Node as integer:")
print(node)
print()

# 2. Polynomial
x = symbols('x')
poly = Poly(node * x**2 + x + 1)
print("Polynomial:")
print(poly)
print()

# 3. Matrix
M = Matrix([
    [node % 997, node % 991],
    [node % 983, node % 977]
])
print("Matrix:")
print(M)
print()

# 4. Lattice coordinates
coord = (node % 4096, (node >> 12) % 4096)
print("Lattice coordinates:")
print(coord)
print()

# 5. Entropy seed
entropy = node % (2**64)
print("Entropy seed:")
print(entropy)
print()

# 6. Stock market data → math
ticker = "AAPL"
data = yf.download(ticker, period="5d", interval="1d")

print(f"Market data for {ticker}:")
print(data)
print()

# Multi-index column access for last close
last_close = float(data[("Close", ticker)].iloc[-1])

market_int = Integer(int(last_close * 100))
print("Last close as SymPy integer:")
print(market_int)
print()

# 7. Mark of Chains — Markov transition engine

# Simple 2‑state Markov chain using entropy + market_int
p = (entropy % 100) / 100
q = 1 - p

T = Matrix([
    [p, q],
    [q, p]
])

print("Markov transition matrix (Mark of Chains):")
print(T)
print()

state0 = Matrix([market_int % 2, (market_int + 1) % 2])

print("Initial state vector:")
print(state0)
print()

state1 = T * state0

print("State after one Markov transition:")
print(state1)
print()

print("=== ENGINE COMPLETE ===")

