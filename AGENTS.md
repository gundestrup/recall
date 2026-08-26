# AGENTS.md — recall

> **Single source of truth for all coding agents working on this project.**

This is the canonical project guidance for AI coding assistants, including Devin, Windsurf, Claude-compatible tools, and other repository-aware agents. Keep tool-specific instruction files as pointers to this document rather than duplicating these rules.

## Project Context

Recall is a Ruby on Rails application backed by PostgreSQL.

- Ruby: `3.4.10` (see `.ruby-version`)
- Rails: `8.1.3.1`
- Solid Queue: `1.6.0`
- Solid Cable: `4.0.2`
- Rack Attack: `6.8.0`
- Database: PostgreSQL
- Frontend: Hotwire, Stimulus, Importmap, Tailwind CSS
- Tests: Rails/Minitest

For the complete dependency set, use `Gemfile` and `Gemfile.lock`. Do not infer dependency availability from memory.

## Required First Steps

Before changing code:

1. Read this file.
2. Check the working tree with `git status --short` and preserve unrelated user changes.
3. Read the relevant documentation linked below.
4. Search for existing implementations and tests before introducing new patterns.
5. Check nearby code for project conventions, callbacks, authorization, and error handling.

Do not reset, overwrite, or delete unrelated work.

## Canonical Documentation

Use these documents instead of copying their content into new instruction files:

- [Development setup and workflows](README.development.md)
- [Contribution and quality standards](CONTRIBUTING.md)
- [Dependency inventory](docs/gems.md)
- [Testing strategy and current results](docs/tests.md)
- [Environment variables](docs/configuration.md)
- [Security policy](SECURITY.md)
- [Solid Queue configuration](docs/SOLID_QUEUE_CENTRALIZED_CONFIG.md)
- [Import/export authorization](docs/IMPORT_EXPORT_AUTHORIZATION.md)
- [Database and stack notes](docs/Stack_Database.md)
- [Performance and PostgreSQL pooling](docs/PGBOUNCER.md)

When documentation conflicts with the code, verify the code and update the stale documentation as part of the task when appropriate.

## Development and Verification Commands

Use repository binstubs and Bundler so commands run against the locked dependencies:

```bash
bundle install
bin/rails db:migrate
bundle exec rails test
./bin/check-tests
./bin/check-quality
./bin/check-security
./bin/check-all
bundle exec rake solid_queue:check
```

For focused work, run the smallest relevant test first, then run the full suite before finishing. The current full suite is expected to pass with 0 failures and 0 errors.

Start the Solid Queue supervisor with:

```bash
bin/jobs
```

Do not start background workers during tests unless the test explicitly requires them.

## Coverage (SimpleCov)

`test/test_helper.rb` starts SimpleCov (`"rails"` profile, branch coverage enabled) whenever `COVERAGE` is unset or `"1"`. Two settings matter for how coverage accumulates across runs:

- `command_name "test-#{Process.pid}"` — gives every `bin/rails test` invocation a unique SimpleCov command name. Without this, SimpleCov's `CommandGuesser` assigns the same generic name (`"Unit Tests"`) to every run, and `SimpleCov::ResultMerger` overwrites the prior run's entry instead of merging it. With a unique name, running one test file and then another **accumulates** coverage in `coverage/.resultset.json` instead of one run erasing the other's data. Parallel workers from `parallelize(workers:)` still merge correctly under this scheme (the `"rails"` profile's `merge_subprocesses true` appends a subprocess suffix to whichever command name is active).
- `merge_timeout 86_400` — keeps accumulated resultset entries for 24 hours so sequential single-file runs during a work session merge into the final report.

Implication: local coverage numbers can lag behind deletions/refactors for up to `merge_timeout` seconds, since old runs' data stays unioned into the report. Run `bundle exec simplecov clean` manually if you need a fresh baseline; do not add automatic `simplecov clean` steps before every test run in CI or the Makefile, since that defeats the accumulation this config is built for.

## Coding Guidelines

- Follow existing Rails, Ruby, Minitest, ERB, and JavaScript conventions.
- Prefer small, focused changes over broad refactors.
- Reuse existing models, services, concerns, helpers, and partials.
- Preserve existing comments; do not add or remove comments unless the task requires it.
- Keep authorization checks intact. Review CanCanCan abilities for new actions and resources.
- Use existing error boundaries and logging patterns. Never log passwords, tokens, credentials, or other secrets.
- For database changes, add migrations and consider PostgreSQL indexes, UUIDs, foreign keys, counters, and production migration safety.
- For Action Text, use the `has_rich_text` associations and `action_text_rich_texts`; do not assume cards have `front_id` or `back_id` columns.
- For Solid Queue, keep `config/queue.yml`, `config/recurring.yml`, `config/initializers/solid_queue.rb`, and `db/queue_schema.rb` consistent.
- For user-facing behavior, update or add controller, integration, system, or service tests as appropriate.

## Testing Expectations

For a bug fix:

1. Reproduce the failure with a focused test or command.
2. Identify the root cause.
3. Add or adjust a regression test when the existing test is incorrect or incomplete.
4. Implement the smallest correct fix.
5. Run the focused test and then the full suite.

Tests that seed or truncate shared real-world data must not interfere with other tests through parallel execution. Follow the existing integration-test pattern for isolation.

## Security and Safety

- Treat all user input as untrusted.
- Do not commit secrets, credentials, private keys, database dumps, or local environment files.
- Do not weaken authentication, authorization, rate limiting, CSP, or audit logging to make tests pass.
- Do not run destructive database commands, remove files, rewrite git history, force-push, or alter deployment/security policy without explicit user approval.
- Never use real credentials in tests or examples.

## Git and Change Hygiene

- Do not commit or push unless the user explicitly asks.
- Before proposing a commit, review `git status`, the diff, and relevant tests.
- Keep generated files and documentation changes limited to what the task requires.
- Mention unrelated pre-existing changes rather than modifying them.

## Documentation Rules

- Keep `AGENTS.md` canonical.
- Keep `CLAUDE.md` and other tool-specific files as short references to this document.
- Link to existing documentation instead of repeating setup, security, testing, or deployment instructions.
- Update documentation when commands, versions, configuration paths, or operational behavior change.
- Do not present generated historical reports as current results.
