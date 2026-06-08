# miono inventory (bushleague)

Snapshot from server audit. Update when adding lanes or ports.

## DNS

- Wildcard resolves: `*.bushleague.xyz` and nested names like `{lane}.dotcache.bushleague.xyz` → VPS `198.71.54.203`
- No per-lane A record needed if wildcard is in place

## TLS gap (fix before designer lanes go live)

- nginx on dotcache accepts `*.dotcache.bushleague.xyz` but cert is apex-only today
- Before lanes: `certbot certonly --dns-*` for `*.dotcache.bushleague.xyz` (DNS-01)

## Linux users → web roots

| User | Path | Site |
| --- | --- | --- |
| dotcache | `/var/www/dotcache/dist` | production apex |
| dotcache | `/var/www/dotcache/lanes/{lane}/dist` | designer lanes (planned) |
| cachebar | `/var/www/cachebar/dist` | legacy alias |
| foundry | `/var/www/foundry/dist` | foundry.bushleague.xyz |
| foundry | `/var/www/foundry/lanes/{lane}/dist` | lane pattern (if used) |
| www-data | `/var/www/radar/dist` | radar.bushleague.xyz |

## Loopback / app ports (informal registry)

| Port | Owner | nginx proxy |
| --- | --- | --- |
| 4001 | printrn | — |
| 4101 | hvac | — |
| 4173 | floatie | — |
| 4202 | fathom | — |
| 4301 | verse | verse.bushleague.xyz |
| 7310 | radar (www-data) | radar.bushleague.xyz, miono.live `/api/` |
| 7401 | trading-machine adapter (local dev doc) | — |

**Lane rule:** static-only products use no port. Backend lanes allocate from a block (e.g. radar `7320–7399`) — one port per lane, document in lane manifest.

## Deploy pattern

GitHub Actions → SCP `dist/` → `{deploy_user}:{deploy_path}` → nginx serves. Convex deploy uses `CONVEX_DEPLOY_KEY` per repo, not on VPS.
