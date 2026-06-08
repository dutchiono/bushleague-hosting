# Branching (agent only — James ignores this)

James never runs these commands. The **bushleague-lane** skill runs them.

## Remotes

| Remote | URL | Purpose |
| --- | --- | --- |
| `origin` | designer's fork (`this_repo` in LANE.md) | push deployable work here |
| `upstream` | template / cache-bar (`upstream_repo`) | read-only reference for sync |

```bash
git remote add upstream https://github.com/dutchiono/cache-bar.git
git fetch upstream
```

Never push to `upstream`. Designer has no write access there.

## Branches

```
upstream/main          ← production template (read-only)
       │
       │  occasional sync (admin or agent, explicit)
       ▼
origin/main            ← DEPLOYS to lane URL — keep green
       │
       ├── lane/james/hero-copy
       ├── lane/james/theme-colors
       └── lane/james/fix-mobile-nav
```

| Branch | Who | Deploys? | Rule |
| --- | --- | --- | --- |
| `main` | designer | **Yes** — CI deploys on push | Only merge tested work |
| `lane/{slug}/*` | designer + agent | No | All edits start here |
| `upstream/main` | platform owner | N/A | Never commit on fork |
| `sync/*` | optional | No | merge upstream → test → PR to main |

## Workflow (agent)

1. Read `LANE.md` — confirm slug and forbidden list.
2. `git checkout main && git pull origin main`
3. `git checkout -b lane/james/short-description`
4. Make changes (scope: lane only).
5. Run local checks if repo has them (`bun run check`, `npm run ci`, etc.).
6. Merge to `main` via PR or fast-forward merge — **never force-push main**.
7. Push `main` → CI deploys to `live_url`.
8. Verify `live_url` in browser or report URL for human check.

## Syncing template fixes from upstream

Only when designer asks or admin announces a template update:

```bash
git fetch upstream
git checkout -b sync/upstream-YYYY-MM-DD
git merge upstream/main
# resolve conflicts — prefer lane customizations for copy/theme;
# take upstream fixes for security/build
git checkout main
git merge sync/upstream-YYYY-MM-DD
# test, then push main
```

**Never** sync if it would re-enable production secrets, Stripe, or prod Telegram paths in the lane repo.

## Commit messages

```
lane(james): update hero headline

lane(james): fix mobile nav overlap on cache.html
```

Prefix with `lane({slug}):` so history is scannable.

## Anti-patterns

- Working directly on `main` for risky refactors
- Opening PRs to `dutchiono/cache-bar`
- Renaming branch away from `main` as deploy branch without updating CI
- Copying `.env` or GitHub secrets from production repo
- Using lane slug `builder` when that name is reserved for platform experiments
