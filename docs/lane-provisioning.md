# Provision a designer lane (admin)

Run this once per designer per product. Designer never SSHs.

## Inputs

| Input | Example | Rules |
| --- | --- | --- |
| **lane_slug** | `james` | lowercase, `[a-z0-9-]`, 2–32 chars, unique per product |
| **designer** | James | display name only |
| **product** | `dotcache` | must match a file in `products/*.lane.yaml` |

## Checklist

```
Lane provisioning — {lane_slug} / {product}:
- [ ] 1. Slug validated (not prod, not reserved)
- [ ] 2. Server path created
- [ ] 3. Deploy SSH key (path-scoped)
- [ ] 4. GitHub repo created from template
- [ ] 5. GitHub secrets set (lane only)
- [ ] 6. Convex project created
- [ ] 7. nginx map includes lane root (or wildcard map live)
- [ ] 8. TLS covers subdomain zone
- [ ] 9. LANE.md filled in repo
- [ ] 10. bushleague-lane skill present in repo
- [ ] 11. Designer smoke test: push main → site loads
```

## 1. Reserved slugs (never assign)

`www`, `api`, `admin`, `builder`, `staging`, `prod`, `production`, `dotcache`, `cachebar`, `foundry`, `app`, `ops`

## 2. Server path

```bash
sudo mkdir -p /var/www/dotcache/lanes/james/dist
sudo chown -R dotcache:dotcache /var/www/dotcache/lanes/james
sudo chmod 755 /var/www/dotcache/lanes/james
```

## 3. Deploy key

Generate a key pair. Add public key to `/home/dotcache/.ssh/authorized_keys` with `command=` restriction if possible, or rely on GitHub Action target path only.

Designer repo secrets:

| Secret | Value |
| --- | --- |
| `LANE_DEPLOY_USER` | `dotcache` |
| `LANE_DEPLOY_PATH` | `/var/www/dotcache/lanes/james` |
| `LANE_DEPLOY_SSH_KEY` | private key |
| `DEPLOY_HOST` | VPS host |
| `APP_URL` | `https://james.dotcache.bushleague.xyz` |
| `VITE_CONVEX_URL` | new Convex URL |
| `CONVEX_DEPLOY_KEY` | new project key |

Do **not** copy cache-bar production secrets.

## 4. nginx (wildcard map — one-time per product)

See `templates/nginx/dotcache-lanes.map.conf`. After edit:

```bash
sudo nginx -t && sudo systemctl reload nginx
```

## 5. Hand off to designer

Send them:

1. GitHub repo URL
2. Filled `LANE.md` (or have them fill slug/designer only)
3. Instruction: *"Tell your agent: use the bushleague-lane skill."*

They customize copy/assets; agent follows branching rules in the skill.

## Rollback

```bash
sudo rm -rf /var/www/dotcache/lanes/james
sudo systemctl reload nginx
```

Production `/var/www/dotcache/dist` untouched.
