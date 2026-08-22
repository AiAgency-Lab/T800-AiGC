#!/usr/bin/env python3
"""
Merkle Tree implementation for git commits.
Builds a cryptographic merkle tree from git commit hashes and computes the root.
"""

import hashlib
import subprocess
import json
from pathlib import Path
from typing import List, Dict, Optional
from dataclasses import dataclass
from datetime import datetime


@dataclass
class MerkleNode:
    """Represents a node in the merkle tree."""
    hash: str
    left: Optional['MerkleNode'] = None
    right: Optional['MerkleNode'] = None
    data: Optional[str] = None
    level: int = 0

    def to_dict(self) -> Dict:
        """Serialize node to dictionary."""
        return {
            'hash': self.hash,
            'level': self.level,
            'left': self.left.to_dict() if self.left else None,
            'right': self.right.to_dict() if self.right else None,
            'data': self.data[:50] if self.data else None
        }


class MerkleTree:
    """Builds and manages a merkle tree from git commits."""

    def __init__(self, max_commits: int = 100):
        self.max_commits = max_commits
        self.leaves: List[MerkleNode] = []
        self.root: Optional[MerkleNode] = None
        self.build_time: Optional[datetime] = None

    def get_git_commits(self) -> List[str]:
        """Fetch commit hashes from git history."""
        try:
            result = subprocess.run(
                ['git', 'log', f'--format=%H', f'-{self.max_commits}'],
                capture_output=True,
                text=True,
                timeout=10
            )
            commits = result.stdout.strip().split('\n')
            return [c for c in commits if c]
        except Exception as e:
            print(f"Error fetching git commits: {e}")
            return []

    @staticmethod
    def hash_data(data: str) -> str:
        """SHA-256 hash of data."""
        return hashlib.sha256(data.encode()).hexdigest()

    @staticmethod
    def hash_pair(left: str, right: str) -> str:
        """Hash pair of nodes for merkle tree."""
        combined = f"{left}{right}"
        return hashlib.sha256(combined.encode()).hexdigest()

    def build_tree(self, commits: List[str]) -> None:
        """Build merkle tree from commit list."""
        self.build_time = datetime.now()

        # Create leaf nodes from commits
        self.leaves = [
            MerkleNode(hash=commit, data=commit, level=0)
            for commit in commits
        ]

        if not self.leaves:
            print("No commits to process")
            return

        # If odd number of leaves, duplicate the last one
        if len(self.leaves) % 2 != 0:
            last = self.leaves[-1]
            self.leaves.append(
                MerkleNode(hash=last.hash, data=last.data, level=0)
            )

        # Build tree bottom-up
        current_level = self.leaves[:]
        level = 1

        while len(current_level) > 1:
            next_level = []

            for i in range(0, len(current_level), 2):
                left = current_level[i]
                right = current_level[i + 1] if i + 1 < len(current_level) else left

                parent_hash = self.hash_pair(left.hash, right.hash)
                parent = MerkleNode(
                    hash=parent_hash,
                    left=left,
                    right=right,
                    level=level
                )
                next_level.append(parent)

            current_level = next_level
            level += 1

        self.root = current_level[0] if current_level else None

    def get_merkle_root(self) -> Optional[str]:
        """Return merkle root hash."""
        return self.root.hash if self.root else None

    def get_tree_stats(self) -> Dict:
        """Return tree statistics."""
        if not self.root:
            return {}

        height = self.root.level + 1
        return {
            'merkle_root': self.get_merkle_root(),
            'leaf_count': len(self.leaves),
            'height': height,
            'built_at': self.build_time.isoformat() if self.build_time else None
        }

    def verify_commit_in_tree(self, commit: str) -> bool:
        """Verify if a commit is in the tree."""
        return any(leaf.data == commit for leaf in self.leaves)

    def export_tree(self, filepath: Path) -> None:
        """Export tree to JSON file."""
        if not self.root:
            print("Tree not built")
            return

        tree_data = {
            'stats': self.get_tree_stats(),
            'root': self.root.to_dict(),
            'leaves': [leaf.hash for leaf in self.leaves]
        }

        filepath.write_text(json.dumps(tree_data, indent=2))
        print(f"Tree exported to {filepath}")


def main():
    """Main execution."""
    tree = MerkleTree(max_commits=100)

    print("🌳 Building Merkle Tree from git commits...")
    commits = tree.get_git_commits()

    if not commits:
        print("No commits found")
        return

    print(f"   Found {len(commits)} commits")
    tree.build_tree(commits)

    stats = tree.get_tree_stats()
    print("\n📊 Merkle Tree Built:")
    print(f"   Merkle Root: {stats['merkle_root']}")
    print(f"   Leaves:      {stats['leaf_count']}")
    print(f"   Height:      {stats['height']}")
    print(f"   Built at:    {stats['built_at']}")

    # Export tree structure
    tree_file = Path('merkle_tree.json')
    tree.export_tree(tree_file)

    # Return root for tagging
    merkle_root = stats['merkle_root']
    return merkle_root


if __name__ == '__main__':
    root = main()
    if root:
        print(f"\n✅ Merkle root hash: {root}")
