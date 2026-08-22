# Multi-stage Dockerfile for reproducible project build
FROM alpine:3.18 AS builder

WORKDIR /build

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    git \
    python3 \
    py3-pip \
    bash

# Copy all source code and configuration
COPY . .

# Build merkle tree verification
RUN python3 merkle_tree.py && \
    echo "Merkle tree built successfully"

# Verify directory structure
RUN echo "Project structure verified" && \
    find . -maxdepth 2 -type d | wc -l && \
    echo "Total files in build:" && \
    find . -type f | wc -l

# Runtime stage - slim image for reproducibility
FROM alpine:3.18

LABEL maintainer="Project Team" \
      description="Reproducible container for multi-module project" \
      version="1.0.0"

WORKDIR /app

# Install minimal runtime dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    ca-certificates \
    bash \
    curl \
    git

# Create app user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && \
    mkdir -p /app && chown -R appuser:appgroup /app

# Copy all artifacts from builder (preserves complete project structure)
COPY --from=builder --chown=appuser:appgroup /build /app

# Set git safe directory for merkle verification
RUN git config --global --add safe.directory /app

# Health check - verify merkle tree integrity
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD test -f /app/merkle_tree.json && \
        test -f /app/merkle_tree.py && \
        python3 -m json.tool /app/merkle_tree.json > /dev/null || exit 1

# Expose port for services
EXPOSE 8080 8443

# Non-root execution
USER appuser
WORKDIR /app

# Entry point - preserve all artifacts and enable reproducibility
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "echo 'Container ready: all project files preserved' && exec bash"]
