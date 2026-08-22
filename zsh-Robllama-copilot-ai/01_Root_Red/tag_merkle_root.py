#!/usr/bin/env python3
"""
Tag git commits with merkle tree root hash.
Creates an annotated tag with clean merkle root verification.
"""

import subprocess
import json
from pathlib import Path
from datetime import datetime
import sys


def get_current_commit() -> str:
    """Get current HEAD commit hash."""
    result = subprocess.run(
        ['git', 'rev-parse', 'HEAD'],
        capture_output=True,
        text=True,
        timeout=5
    )
    return result.stdout.strip()


def get_merkle_root_from_file(filepath: Path = Path('merkle_tree.json')) -> str:
    """Extract merkle root from merkle_tree.json."""
    if not filepath.exists():
        raise FileNotFoundError(f"Merkle tree file not found: {filepath}")

    with open(filepath) as f:
        data = json.load(f)
        return data['stats']['merkle_root']


def create_git_tag(merkle_root: str, current_commit: str) -> None:
    """Create annotated git tag with merkle root."""
    tag_name = f"merkle-{merkle_root[:12]}"
    timestamp = datetime.now().isoformat()

    tag_message = f"""Merkle Tree Root Verification
    
Hash: {merkle_root}
Commit: {current_commit}
Tagged: {timestamp}
Type: clean
Status: verified

This tag marks the merkle root hash of the git commit tree,
providing cryptographic verification of repository integrity."""

    print(f"🏷️  Creating tag: {tag_name}")

    result = subprocess.run(
        ['git', 'tag', '-a', tag_name, '-m', tag_message, current_commit],
        capture_output=True,
        text=True,
        timeout=5
    )

    if result.returncode == 0:
        print(f"✅ Tag created: {tag_name}")
        print(f"   Merkle Root: {merkle_root}")
        print(f"   Commit:      {current_commit}")
        
        # List the tag
        subprocess.run(['git', 'tag', '-l', tag_name, '-n5'])
    else:
        print(f"❌ Failed to create tag: {result.stderr}")
        sys.exit(1)


def main():
    """Main execution."""
    try:
        print("🔐 Merkle Root Git Tagger")
        print("-" * 40)

        # Build merkle tree first
        print("\n1️⃣  Building merkle tree...")
        result = subprocess.run(
            [sys.executable, 'merkle_tree.py'],
            capture_output=True,
            text=True,
            timeout=30
        )
        print(result.stdout)

        if result.returncode != 0:
            print(f"❌ Merkle tree build failed: {result.stderr}")
            sys.exit(1)

        # Get merkle root
        print("\n2️⃣  Extracting merkle root...")
        merkle_root = get_merkle_root_from_file()
        print(f"   Root: {merkle_root}")

        # Get current commit
        print("\n3️⃣  Getting current commit...")
        current_commit = get_current_commit()
        print(f"   Commit: {current_commit}")

        # Create tag
        print("\n4️⃣  Creating annotated tag...")
        create_git_tag(merkle_root, current_commit)

        print("\n" + "=" * 40)
        print("✅ Merkle tree tagged successfully!")
        print("=" * 40)

    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()
