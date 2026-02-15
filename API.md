# BC Cli API Reference

Custom Business Central API for accessing Customers, Sales Orders, and Production Orders.

## Connection

Base URL:
```
https://{environment}.api.businesscentral.dynamics.com/v2.0/{tenant}/{environment}/api/mschristiansen/bcCli/v1.0/companies({companyId})
```

Authentication: OAuth2 via Azure AD. All responses are OData v4 JSON.

## Allowed Operations

- **GET** — List or read records
- **PATCH** — Update existing records (requires `If-Match` header with `@odata.etag`)
- **POST** — Not allowed (returns 405), except for bound actions (see below)
- **DELETE** — Not allowed (returns 405)

## Field Editability

Fields marked `Editable = no` in the endpoint tables below cannot be changed via PATCH. They are read-only for these reasons:

- **`id`** (SystemId) — Platform-managed primary key.
- **`number`** (No.) — Assigned by number series. Renaming would require cascading updates to ledger entries and posted documents.
- **`status`** — Must be changed through BC codeunits that enforce business rules (validation, reservations, warehouse handling, posting). Direct field writes would bypass this logic.
- **`lastModifiedDateTime`** — Platform-managed timestamp for delta sync.

Fields without `Editable = no` can be freely updated via PATCH. BC's standard table-level validation (e.g., customer existence checks, date logic) still applies.

Single record access: `/{entitySetName}({id})` where `id` is a SystemId GUID.

OData query options: `$filter`, `$select`, `$top`, `$skip`, `$orderby`, `$count`.

## Endpoints

### GET /customers

Customer master data.

| Field               | Type   | Editable | Description          |
|---------------------|--------|----------|----------------------|
| `id`                | GUID   | no       | SystemId             |
| `number`            | string | no       | Customer No.         |
| `name`              | string | yes      | Customer name        |
| `address`           | string | yes      | Address line 1       |
| `address2`          | string | yes      | Address line 2       |
| `city`              | string | yes      | City                 |
| `postCode`          | string | yes      | Post/ZIP code        |
| `countryRegionCode` | string | yes      | Country/Region code  |
| `phoneNumber`       | string | yes      | Phone number         |
| `email`             | string | yes      | Email address        |
| `lastModifiedDateTime` | datetime | no  | Last modified timestamp |

### GET /salesOrders

Sales orders only (quotes, invoices, etc. are excluded).

| Field                   | Type   | Editable | Description                  |
|-------------------------|--------|----------|------------------------------|
| `id`                    | GUID   | no       | SystemId                     |
| `number`                | string | no       | Order No.                    |
| `sellToCustomerNo`      | string | yes      | Sell-to customer number      |
| `sellToCustomerName`    | string | yes      | Sell-to customer name        |
| `shipToName`            | string | yes      | Ship-to name                 |
| `shipToAddress`         | string | yes      | Ship-to address line 1       |
| `shipToAddress2`        | string | yes      | Ship-to address line 2       |
| `shipToCity`            | string | yes      | Ship-to city                 |
| `shipToPostCode`        | string | yes      | Ship-to post code            |
| `orderDate`             | date   | yes      | Order date                   |
| `postingDate`           | date   | yes      | Posting date                 |
| `shipmentDate`          | date   | yes      | Shipment date                |
| `dueDate`               | date   | yes      | Due date                     |
| `requestedDeliveryDate` | date   | yes      | Requested delivery date      |
| `promisedDeliveryDate`  | date   | yes      | Promised delivery date       |
| `externalDocumentNo`    | string | yes      | External document number     |
| `status`                | string | no       | Order status (Open/Released) |
| `lastModifiedDateTime`  | datetime | no     | Last modified timestamp      |

### GET /productionOrders

Production orders across all statuses.

| Field          | Type   | Editable | Description                                               |
|----------------|--------|----------|-----------------------------------------------------------|
| `id`           | GUID   | no       | SystemId                                                  |
| `number`       | string | no       | Production order No.                                      |
| `status`       | string | no       | Simulated/Planned/Firm Planned/Released/Finished          |
| `sourceType`   | string | yes      | Source type (Item/Family/Sales Header)                    |
| `sourceNo`     | string | yes      | Source number (item no. etc.)                             |
| `description`  | string | yes      | Description                                               |
| `quantity`     | number | yes      | Quantity                                                  |
| `dueDate`      | date   | yes      | Due date                                                  |
| `startingDate` | date   | yes      | Starting date                                             |
| `startingTime` | time   | yes      | Starting time                                             |
| `endingDate`   | date   | yes      | Ending date                                               |
| `endingTime`   | time   | yes      | Ending time                                               |
| `routingNo`    | string | yes      | Routing number                                            |
| `lastModifiedDateTime` | datetime | no | Last modified timestamp                               |

#### Actions

Production order status changes must go through `Codeunit 5407 "Prod. Order Status Management"`, which handles component/routing updates, reservation transfers, and posting. The following bound actions are available:

##### POST /productionOrders({id})/Microsoft.NAV.release

Changes the production order status to **Released**. Applicable from Simulated, Planned, or Firm Planned status.

##### POST /productionOrders({id})/Microsoft.NAV.finish

Changes the production order status to **Finished**. Applicable from Released status. This triggers output and consumption posting.

**Important:** Changing production order status creates a new record and deletes the original. The response contains the new record with a new `id` and potentially a new `number` (from the target status number series). API consumers must use the returned `id` to track the record going forward.
