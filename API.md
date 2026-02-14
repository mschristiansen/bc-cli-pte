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
- **POST** — Not allowed (returns 405)
- **DELETE** — Not allowed (returns 405)

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
