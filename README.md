# BC Cli

A Business Central Per-Tenant Extension (PTE) that exposes custom API pages for Customers, Sales Orders, and Production Orders.

## API Endpoints

Base path: `api/mschristiansen/bcCli/v1.0/companies({companyId})/`

| Endpoint             | Source Table            | Description              |
|----------------------|-------------------------|--------------------------|
| `/customers`         | Customer (18)           | Customer master data     |
| `/salesOrders`       | Sales Header (36)       | Sales orders             |
| `/productionOrders`  | Production Order (5405) | Production orders        |

All endpoints support GET and PATCH. POST and DELETE are disabled.

See [API.md](API.md) for full field reference.

## Setup

1. Open `al.code-workspace` in VS Code
2. Download symbols: `Ctrl+Shift+P` > "AL: Download Symbols"
3. Build: `Ctrl+Shift+B`
4. Publish: `F5`

Assign the **BC Cli API** permission set to users that need API access.

## Configuration

- **Publisher**: Mikkel Christiansen
- **ID range**: 50300–50399
- **Runtime**: 16.0 (BC 2025 release wave 2)
- **CI/CD**: [AL-Go for GitHub](https://aka.ms/AL-Go)
