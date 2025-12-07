# POS Software Requirements Specification - Flashlight Project

**Version**: 1.0
**Date**: December 2025
**Scope**: Staff / Admin Dashboard Only

---

## 1. Introduction

### 1.1 Purpose
This document defines the functional and non-functional requirements specifically for the **Flashlight POS/Dashboard Application**. This application is designed for staff and administrators to manage daily operations, including work orders, customer data, and inventory.

### 1.2 User Roles
- **Staff (Operator)**: Focuses on daily tasks (Processing Work Orders, Managing Customers).
- **Admin**: Has elevated privileges (Managing Products, Services, Users, System configuration).

---

## 2. Functional Requirements

### 2.1 Authentication & Security
- **REQ-POS-001**: System shall provide a secure login page requiring Username and Password.
- **REQ-POS-002**: System shall implement JWT-based authentication with Access and Refresh tokens.
- **REQ-POS-003**: System shall automatically log out inactive users after a set duration (security requirement).

### 2.2 Work Order Management (Core)
- **REQ-POS-004**: System shall display a **Live Dashboard** of active Work Orders.
    - Statuses: `Created`, `In Progress`, `Completed`, `Cancelled`.
- **REQ-POS-005**: System shall allow Staff to view full details of a Work Order:
    - Customer Info
    - Vehicle Details (Plate, Model)
    - Services List
    - Products/Food Orders
    - Total Price
- **REQ-POS-006**: System shall allow Staff to update Work Order status (e.g., move from `Created` -> `In Progress` -> `Completed`).
- **REQ-POS-007**: System shall record the timestamp of each status change (especially `CompletedAt`).

### 2.3 Customer & Membership Management
- **REQ-POS-008**: System shall provide a searchable list of all Customers.
- **REQ-POS-009**: System shall allow creating, editing, and deleting Customer profiles.
- **REQ-POS-010**: System shall manage Memberships:
    - View current status.
    - Upgrade/Downgrade membership levels.
    - View registered vehicles associated with the member.

### 2.4 Master Data Management (Admin)
- **REQ-POS-011**: System shall allow Admins to manage **Services** (Wash, Wax, etc.):
    - Edit Names, Descriptions, Prices.
    - Upload/Update Images.
- **REQ-POS-012**: System shall allow Admins to manage **Products** (F&B):
    - Manage Stock/Inventory (Increase/Decrease).
    - Update Pricing.
    - Set availability (In Stock / Out of Stock).
- **REQ-POS-013**: System shall allow Admins to manage **System Users**:
    - Create new Staff accounts.
    - Reset Staff passwords.

### 2.5 Reporting (Future/Placeholder)
- **REQ-POS-014**: System should support basic reporting features (Daily Revenue, Total Cars Washed) - *To be confirmed with Backend availability*.

---

## 3. Non-Functional Requirements

### 3.1 User Interface (UI/UX)
- **NFR-POS-001**: UI must be "Data Dense" but readable, optimized for desktop/tablet landscape orientation.
- **NFR-POS-002**: Design should use a **Dark Mode** theme with premium accents (consistent with Kiosk).
- **NFR-POS-003**: Dashboard should use real-time or near real-time updates for Work Orders (auto-refresh or socket-based if available).

### 3.2 Performance
- **NFR-POS-004**: List views (Work Orders, Customers) must support pagination to handle large datasets efficiently.

### 3.3 Security
- **NFR-POS-005**: Admin routes (Master Data) must have role-based protection (Staff cannot delete Products).

---

## 4. API Integration
The POS application will consume the following endpoints defined in `API_CONTRACT.md`:
- `POST /api/login` & `POST /api/refresh-token`
- `GET /api/work-orders` & `PUT /api/work-orders/:id/status`
- `GET /api/customers` (CRUD)
- `GET /api/products` (CRUD)
- `GET /api/services` (CRUD)
- `GET /api/users` (Admin only)
