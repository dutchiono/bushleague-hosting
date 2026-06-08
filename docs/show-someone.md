# Show someone bushleague lanes (30 seconds)

## The skill

| | |
| --- | --- |
| **Name** | `bushleague-lane` |
| **File** | `bushleague-hosting/templates/lane-repo/.cursor/skills/bushleague-lane/SKILL.md` |
| **Live example** | https://github.com/dutchiono/dotcache-james (James on dotcache) |

Open that SKILL.md in Cursor or GitHub — that's the whole playbook.

## One sentence

> Any designer gets `{name}.{product}.bushleague.xyz` — their own fork, their agent runs the **bushleague-lane** skill, push `main` goes live. Production never touched.

## URL pattern (all products)

```
https://{slug}.{product}.bushleague.xyz
```

DNS is wildcard — no new A records per person.

| product | example | production (frozen) |
| --- | --- | --- |
| `dotcache` | james.dotcache.bushleague.xyz | dotcache.bushleague.xyz |
| `foundry` | maya.foundry.bushleague.xyz | foundry.bushleague.xyz |
| `radar` | _(needs port block)_ | radar.bushleague.xyz |
| apex | studio.bushleague.xyz | bushleague.xyz |

## What the designer says

```
Set up my bushleague lane. Read LANE.md and make it work.
```

Then plain English edits. Agent handles git + deploy.

## What you (admin) do once per lane

1. Pick slug → [lane-slug.md](./lane-slug.md)
2. Create server folder + deploy key → [lane-provisioning.md](./lane-provisioning.md)
3. Drop `templates/lane-repo/` into their GitHub fork
4. Fill `LANE.md` slug + product

Product-specific rules: [products/](./products/)

## Repos

| Repo | Purpose |
| --- | --- |
| [bushleague-hosting](.) | Templates, skill, admin docs |
| [dotcache-james](https://github.com/dutchiono/dotcache-james) | James pilot (working) |
| cache-bar, dotcache-builder, foundry… | Each gets a `products/*.lane.yaml` manifest |
