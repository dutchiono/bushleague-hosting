# Lane slug rules

Used by admin (provisioning) and agent (branch names). Same rules everywhere.

## Format

```
^[a-z][a-z0-9-]{1,30}[a-z0-9]$
```

- lowercase only
- 2–32 characters
- start with a letter, end with letter or digit
- hyphens allowed inside (not at edges)

## Good

`james`, `studio-a`, `maya2`, `cozy-devs`

## Bad

`James` (case), `-james`, `james-`, `j`, `www`, `prod`, `builder`

## Reserved (platform)

Never assign as designer slugs:

`www`, `api`, `admin`, `builder`, `staging`, `prod`, `production`, `dotcache`, `cachebar`, `foundry`, `app`, `ops`, `mail`, `ftp`

## Where slug appears

| Place | Example |
| --- | --- |
| URL | `https://james.dotcache.bushleague.xyz` |
| Server path | `/var/www/dotcache/lanes/james/dist` |
| Git branch prefix | `lane/james/hero-copy` |
| Commit prefix | `lane(james): update hero` |
| GitHub repo (optional) | `dotcache-james` |

Slug in `LANE.md` is the **single source of truth**. Branch prefix must match.
