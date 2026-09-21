#!/bin/bash
# Enable git hooks for recall.
#
# Hooks live in bin/hooks/ as TRACKED files and git is pointed at them
# via core.hooksPath — no copying, so installed hooks can't drift from
# the committed ones. Run once after cloning.
#
# pre-commit:  rubocop on staged .rb + annotaterb refresh when
#              schema/models/routes change
# pre-push:    bin/check-tests (same gate CI expects)
#
# Usage: bin/install-hooks.sh

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

git -C "$REPO_ROOT" config core.hooksPath bin/hooks

echo "✅ Git hooks enabled (core.hooksPath=bin/hooks):"
echo "   pre-commit:  rubocop (staged .rb) + annotaterb refresh"
echo "   pre-push:    bin/check-tests"
echo ""
echo "   Skip with: git commit --no-verify  /  git push --no-verify"
