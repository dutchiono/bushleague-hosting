---
name: bushleague-lane
description: >-
  Bushleague designer lane on *.bushleague.xyz — read LANE.md, auto-bootstrap
  repo and deploy, edit copy/design, never touch production. Use for bushleague
  lane, my subdomain, set up my site, deploy my page, designer fork, or any
  *.bushleague.xyz repo.
disable-model-invocation: false
---

# bushleague-lane

**Audience:** Designer (not a developer). **You** handle setup, git, deploy, and edits.

**Read `LANE.md` first** — slug, product, live URL, forbidden production resources.

---

## Rule #1 — bootstrap first, ask later

Every session: run **Bootstrap** silently. Do not ask about git, Convex, nginx, SSH, or secrets.

Only ask the human:

- "What should change on the site?"
- "Open {live_url} — does that look right?"

---

## Bootstrap

```
Lane bootstrap:
- [ ] LANE.md exists (create from template if missing)
- [ ] bushleague-lane skill + docs/branching.md present
- [ ] git origin = designer fork (not upstream production)
- [ ] main pulled; deploy-lane.yml exists
- [ ] live_url matches LANE.md
- [ ] No production secrets/URLs in diff
```

### `*.bushleague.xyz` URL map

| Host | slug | product | live_url |
| --- | --- | --- | --- |
| `{lane}.dotcache.bushleague.xyz` | `{lane}` | `dotcache` | `https://{lane}.dotcache.bushleague.xyz` |
| `{lane}.foundry.bushleague.xyz` | `{lane}` | `foundry` | `https://{lane}.foundry.bushleague.xyz` |
| `{lane}.bushleague.xyz` | `{lane}` | see admin | `https://{lane}.bushleague.xyz` |
| `builder.dotcache.bushleague.xyz` | `builder` | `dotcache-builder` | reserved platform lane |

Infer from `LANE.md` or hostname. Write `LANE.md` if missing — do not ask designer to pick infra.

Product manifests (deploy path, forbidden list): `bushleague-hosting/products/{product}.lane.yaml`

---

## Rule #2 — git (you, not designer)

```
origin/main           ← deploys to live_url
lane/{slug}/*         ← all work starts here
upstream/main         ← read-only template — never push
```

```bash
git checkout main && git pull origin main
git checkout -b lane/{slug}/short-name
# edits
git checkout main && git merge lane/{slug}/short-name
git push origin main
```

Commit: `lane({slug}): what changed`

---

## Rule #3 — hard stops

- Never push to upstream production repo
- Never use production Convex, bots, Stripe, or deploy paths from `LANE.md` forbidden table
- Never change `lane_slug` without human + admin OK
- Payments / Telegram / bots → "Ask admin — lane is design-only unless approved"

---

## Rule #4 — done

```
- [ ] Matches what they asked
- [ ] main pushed (CI deploys)
- [ ] Reply with full live_url + one plain sentence
```

---

## Designer copy-paste

See `docs/designer-says.md` in the lane repo.

First-time setup message:

```
Set up my bushleague lane. Read LANE.md and make it work.
```

---

## Admin reference

Provisioning: `bushleague-hosting/docs/lane-provisioning.md`  
Slug rules: `bushleague-hosting/docs/lane-slug.md`  
Server inventory: `bushleague-hosting/docs/inventory.md`
