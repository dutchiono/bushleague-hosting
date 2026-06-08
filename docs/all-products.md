# Bushleague lanes — all products

Same pattern everywhere. James on dotcache is the first live one.

## Pattern

```
{slug}.{product}.bushleague.xyz  →  /var/www/{product}/lanes/{slug}/dist
```

| Layer | Who owns it |
| --- | --- |
| DNS | Wildcard — already works |
| nginx | One map per product zone (dotcache done on miono) |
| GitHub repo | `{product}-{slug}` fork with bushleague-lane skill |
| CI | `deploy-lane.yml` on push to `main` |
| Secrets | Lane-only — never production |

## Product registry

| Product | Manifest | Production | Lane nginx map |
| --- | --- | --- | --- |
| dotcache | [dotcache.lane.yaml](../products/dotcache.lane.yaml) | dotcache.bushleague.xyz | ✅ on miono |
| foundry | [foundry.lane.yaml](../products/foundry.lane.yaml) | foundry.bushleague.xyz | ⬜ add when needed |
| bushleague apex | [bushleague.lane.yaml](../products/bushleague.lane.yaml) | bushleague.xyz | per-user today |
| radar | _(add manifest)_ | radar.bushleague.xyz | needs port + systemd |
| dotcache-builder | builder.dotcache… | builder lane | separate repo |

## New product checklist

1. Add `products/{name}.lane.yaml`
2. Add `templates/nginx/{name}-lanes.map.conf`
3. Install map on miono + reload nginx
4. Wildcard TLS for `*.{name}.bushleague.xyz` when lanes go live
5. Copy `templates/lane-repo/` into first designer fork

## Show a human

→ [show-someone.md](./show-someone.md)
