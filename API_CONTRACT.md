# API Contract - Flashlight Kiosk

**Version**: 1.0
**Date**: December 2025
**Base URL**: `http://localhost:8080` (Development)

---

## 1. Global Response Format

All API responses (success and error) follow this standard JSON envelope:

```json
{
  "success": boolean,      // true for 2xx status, false otherwise
  "message": string,       // Description of the result
  "data": any,            // The actual payload (object, array, or null)
  "error_code": integer    // 0 if success, otherwise equals HTTP status code
}
```

**Example Success:**
```json
{
  "success": true,
  "message": "Data retrieved successfully",
  "data": { "id": "123", "name": "Test" },
  "error_code": 0
}
```

**Example Error:**
```json
{
  "success": false,
  "message": "Invalid request parameters",
  "data": null,
  "error_code": 400
}
```

---

## 2. Authentication

### Login
**Endpoint**: `POST /api/login`

**Request Body**:
```json
{
  "username": "string",
  "password": "string"
}
```

**Response Data (`data`)**:
```json
{
  "accessToken": "string (JWT)",
  "refreshToken": "string",
  "user": {
    "id": "string",
    "username": "string",
    "fullName": "string",
    "email": "string",
    "role": "string",
    "status": "active"
  }
}
```

### Refresh Token
**Endpoint**: `POST /api/refresh-token`

**Request Body**:
```json
{
  "refreshToken": "string"
}
```

**Response Data (`data`)**:
```json
{
  "accessToken": "string",
  "refreshToken": "string"
}
```

### Get Profile
**Endpoint**: `GET /api/profile`
**Headers**: `Authorization: Bearer <token>`

**Response Data (`data`)**:
```json
{
  "id": "string",
  "username": "string",
  "fullName": "string",
  "email": "string",
  "role": "string",
  "status": "string"
}
```

---

## 3. Customers

### List Customers
**Endpoint**: `GET /api/customers`

**Response Data (`data`)**:
```json
{
  "customers": [
    {
      "id": "string (UUID)",
      "name": "string",
      "phoneNumber": "string",
      "email": "string",
      "membership": { ... }, // Nullable
      "workOrders": [ ... ]  // List of work orders
    }
  ],
  "total": integer
}
```

### Create Customer
**Endpoint**: `POST /api/customers`

**Request Body**:
```json
{
  "name": "string",
  "phoneNumber": "string",
  "email": "string"
}
```

**Response Data (`data`)**: `Customer Object`

### Get Customer Detail
**Endpoint**: `GET /api/customers/:id`

**Response Data (`data`)**: `Customer Object` (includes `Membership` and `WorkOrders` relations)

### Update Customer
**Endpoint**: `PUT /api/customers/:id`

**Request Body** (Partial updates allowed):
```json
{
  "name": "string",
  "phoneNumber": "string",
  "email": "string"
}
```

**Response Data (`data`)**: `Customer Object`

### Delete Customer
**Endpoint**: `DELETE /api/customers/:id`

**Response Data (`data`)**: `null`

---

## 4. Membership

### Check Membership Status
**Endpoint**: `POST /api/membership/check`

**Request Body**:
```json
{
  "phoneNumber": "string"
}
```

**Response Data (`data`)**:
```json
{
  "type": "member | nonMember",
  "message": "string",
  "membershipLevel": "string | null",
  "isLoading": boolean
}
```

### Create Membership
**Endpoint**: `POST /api/memberships`

**Request Body**:
```json
{
  "customerId": "string (UUID)",
  "membershipType": "string",
  "membershipLevel": "string"
}
```

**Response Data (`data`)**: `Membership Object`

### Get Membership List
**Endpoint**: `GET /api/memberships`

**Response Data (`data`)**:
```json
{
  "memberships": [ ... ],
  "total": integer
}
```

### Update Membership
**Endpoint**: `PUT /api/memberships/:id`

**Request Body**:
```json
{
  "membershipType": "string",
  "membershipLevel": "string",
  "isActive": boolean
}
```

---

## 5. Projects (Food & Beverage)

### List Products
**Endpoint**: `GET /api/products`
**Query Params**: `type` (optional) - e.g., `coffee`, `tea`, `snack`

**Response Data (`data`)**:
```json
{
  "products": [
    {
      "id": "string (UUID)",
      "name": "string",
      "description": "string",
      "price": integer,
      "imageURL": "string",
      "stock": integer,
      "type": "string",
      "isAvailable": boolean
    }
  ],
  "total": integer
}
```

### Create Product
**Endpoint**: `POST /api/products`

**Request Body**:
```json
{
  "name": "string",
  "description": "string",
  "price": integer,
  "imageURL": "string",
  "type": "string",
  "stock": integer
}
```

### Update Product
**Endpoint**: `PUT /api/products/:id`

**Request Body**: (Same fields as Create, optional)

### Delete Product
**Endpoint**: `DELETE /api/products/:id`

---

## 6. Services

### List Services
**Endpoint**: `GET /api/services`
**Query Params**: `type` (optional)

**Response Data (`data`)**:
```json
{
  "services": [
    {
      "id": "string (UUID)",
      "name": "string",
      "description": "string",
      "price": integer,
      "imageURL": "string",
      "type": "string", // wash, wax, etc.
      "isDefault": boolean,
      "isFavorite": boolean
    }
  ],
  "total": integer
}
```

### Create Service
**Endpoint**: `POST /api/services`

**Request Body**:
```json
{
  "name": "string",
  "description": "string",
  "price": integer,
  "imageURL": "string",
  "type": "string"
}
```

---

## 7. Vehicles

### List Vehicles
**Endpoint**: `GET /api/vehicles`

**Response Data (`data`)**:
```json
{
  "vehicles": [
    {
      "id": "string (UUID)",
      "customerId": "string",
      "model": "string",
      "licensePlate": "string",
      "category": "string"
    }
  ],
  "total": integer
}
```

### Create Vehicle
**Endpoint**: `POST /api/vehicles`

**Request Body**:
```json
{
  "customerId": "string",
  "model": "string",
  "licensePlate": "string",
  "category": "string"
}
```

---

## 8. Work Orders

### Create Work Order
**Endpoint**: `POST /api/work-orders`

**Request Body**:
```json
{
  "customerId": "string (UUID)",
  "vehicleData": {
    "licensePlate": "string",
    "vehicleBrand": "string",
    "vehicleColor": "string",
    "vehicleCategory": "string",
    "vehicleSpecs": "string",
    "isFromMemberData": boolean,
    "memberVehicleId": "string (UUID) | null"
  },
  "services": [
    {
      "serviceId": "string (UUID)",
      "quantity": integer
    }
  ],
  "products": [
    {
      "productId": "string (UUID)",
      "quantity": integer
    }
  ],
  "estimatedTime": "string"
}
```

**Response Data (`data`)**:
```json
{
  "id": "string (UUID)",
  "workOrderCode": "string (e.g., WO-173...)",
  "queueNumber": "string",
  "status": "created",
  "totalPrice": integer,
  "createdAt": "string (ISO8601)",
  "vehicleData": { ... },
  "services": [ ... ], // Includes priceAtOrder and subtotal
  "products": [ ... ]  // Includes priceAtOrder and subtotal
}
```

### List Work Orders
**Endpoint**: `GET /api/work-orders`

**Response Data (`data`)**:
```json
{
  "workOrders": [ ... ],
  "total": integer
}
```

### Get Work Order Detail
**Endpoint**: `GET /api/work-orders/:id`

**Response Data (`data`)**: `WorkOrder Object` (with preloaded relations)

### Update Work Order Status
**Endpoint**: `PUT /api/work-orders/:id/status`

**Request Body**:
```json
{
  "status": "inProgress | completed | cancelled"
}
```

**Response Data (`data`)**: Updated `WorkOrder Object`
