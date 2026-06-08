# Lane manifest

**Agent reads this first.** Admin fills slug + product once; designer does not edit unless told.

| Field | Value |
| --- | --- |
| **lane_slug** | `{slug}` |
| **designer** | `{name}` |
| **product** | `{product}` |
| **live_url** | `https://{slug}.{product}.bushleague.xyz` |
| **upstream_repo** | `dutchiono/{template-repo}` |
| **this_repo** | `dutchiono/{product}-{slug}` |
| **deploy_branch** | `main` |

## Examples

| Designer | product | live_url |
| --- | --- | --- |
| james | dotcache | https://james.dotcache.bushleague.xyz |
| maya | foundry | https://maya.foundry.bushleague.xyz |
| studio-a | dotcache | https://studio-a.dotcache.bushleague.xyz |

## Forbidden

Copy from `bushleague-hosting/products/{product}.lane.yaml` — never use production URLs, Convex projects, bots, or deploy paths listed there.
