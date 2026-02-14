# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BC Cli is a Business Central Per-Tenant Extension (PTE) that exposes custom API pages for Customers, Sales Orders, and Production Orders. Published by "Mikkel Christiansen" targeting BC 2025 release wave 2 (runtime 16.0, platform 27.0.0.0).

## Build

The AL compiler is available locally via the VS Code AL extension:
```
/home/mikkel/.vscode/extensions/ms-dynamics-smb.al-16.3.2065053/bin/linux/alc
```

To compile, open `al.code-workspace` in VS Code and use `Ctrl+Shift+B`. Symbols must be downloaded first via "AL: Download Symbols" (connects to `sandbox-msc` environment).

CI builds run via AL-Go workflows on GitHub (`.github/workflows/CICD.yaml`).

## Architecture

- **`app/`** — The AL app. Contains `app.json` manifest and `src/` with API page objects.
- **`.AL-Go/`** — AL-Go for GitHub configuration. `settings.json` defines `appFolders: ["app"]`.
- **`.github/workflows/`** — AL-Go CI/CD workflows (auto-generated, do not edit manually).

### API Pages

All pages follow the same pattern: `PageType = API`, read+update only (`InsertAllowed = false`, `DeleteAllowed = false`), `ODataKeyFields = SystemId`, `Extensible = false`. Primary key fields (`No.`, `Status` on Production Order) and `SystemId` are `Editable = false`. All pages expose `lastModifiedDateTime` (SystemModifiedAt) for delta sync.

| Page  | File                        | Source Table          | Endpoint           |
|-------|-----------------------------|-----------------------|--------------------|
| 50300 | CustomerAPI.Page.al         | Customer (18)         | `.../customers`    |
| 50301 | SalesOrderAPI.Page.al       | Sales Header (36)     | `.../salesOrders`  |
| 50302 | ProductionOrderAPI.Page.al  | Production Order (5405) | `.../productionOrders` |

API base path: `api/mschristiansen/bcCli/v1.0/companies({id})/`

### Permission Set

`BCCliAPI.PermissionSet.al` (ID 50300) — grants execute on all three API pages and Read+Modify on their source tables. Assign "BC Cli API" to users needing API access.

## Conventions

- **ID range**: 50300–50399
- **API config**: `APIPublisher = 'mschristiansen'`, `APIGroup = 'bcCli'`, `APIVersion = 'v1.0'`
- Field names use camelCase in API pages
- `SystemId` is always exposed as `id` with `Editable = false`
- Primary key and status fields are `Editable = false` to prevent renames and bypass of release/change-status logic
- All pages include `lastModifiedDateTime` for delta sync
- `.vscode/` is gitignored — launch.json contains environment-specific settings
