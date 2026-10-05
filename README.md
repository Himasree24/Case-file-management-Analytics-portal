>> Legal Case Management System

A database-driven web application for managing legal cases, clients, lawyers, hearings, documents, judgments, and case analytics through a centralized platform.

The project combines **React, FastAPI, Spring Boot microservices, REST APIs, and MySQL** to demonstrate relational database engineering and distributed backend development.

---

>> Project Overview

Legal case management involves handling a large amount of interconnected information such as clients, lawyers, judges, cases, hearings, documents, and judgments.

When this information is scattered across paper files, spreadsheets, or separate systems, it becomes difficult to:

- Track case progress
- Monitor upcoming hearings
- Manage case documents
- Maintain consistent records
- Retrieve related information
- Analyze case workloads

The **Legal Case Management System** provides a centralized web-based platform where lawyers and clients can access and manage case-related information according to their roles.

The application uses a normalized **MySQL relational database** and a distributed backend consisting of **FastAPI and three Spring Boot microservices**.

---

>> Objectives

The main objectives of the project are to:

- Maintain a centralized database for legal case information.
- Provide role-based access for lawyers and clients.
- Manage cases, hearings, documents, and judgments.
- Maintain relationships between legal entities using relational database constraints.
- Decompose the backend into independent microservices.
- Provide REST-based communication between services.
- Generate SQL-driven analytics from the current database state.
- Demonstrate practical DBMS and backend engineering concepts.

---

✨ Key Features
👤 Role-Based Access

The system supports two primary roles:

- **Lawyer**
- **Client**

Lawyers can manage cases and associated records, while clients can view cases filed on their behalf.

 ⚖️ Case Management

- Create cases
- View cases
- Update cases
- Delete cases
- Track case status
- Associate cases with clients and lawyers

### 📅 Hearing Management

- Store hearing information
- Associate hearings with cases
- Track hearing-related records

### 📄 Document Management

- Maintain document metadata associated with cases
- Associate documents with the appropriate case

### 🧑‍⚖️ Judgment Management

- Store judgment information
- Associate judgments with cases
- Maintain case outcomes

### 📊 Analytics Dashboard

The system provides SQL-driven analytics including:

- Cases by status
- Cases by type
- Cases by month
- Hearing statistics
- Document counts
- Judgment counts

Analytics are generated from the current database state.

---

# 🏗️ System Architecture

The system follows a **layered, service-oriented architecture** consisting of:

1. Presentation Layer
2. Application / Backend Layer
3. Data Layer

```text
                         ┌───────────────────────┐
                         │         USER          │
                         │    Lawyer / Client    │
                         └───────────┬───────────┘
                                     │
                                     ▼
                         ┌───────────────────────┐
                         │     React + Vite      │
                         │       Frontend        │
                         └───────────┬───────────┘
                                     │
                                  REST APIs
                                     │
                 ┌───────────────────┴──────────────────┐
                 │              BACKEND                  │
                 │                                      │
                 │  ┌────────────────────────────────┐  │
                 │  │            FastAPI              │  │
                 │  │ Authentication / Sessions /     │  │
                 │  │ Analytics                       │  │
                 │  └────────────────────────────────┘  │
                 │                                      │
                 │  ┌────────────┐ ┌────────────┐       │
                 │  │    User    │ │    Case    │       │
                 │  │   Service  │ │   Service  │       │
                 │  │ Spring Boot│ │ Spring Boot│       │
                 │  └────────────┘ └────────────┘       │
                 │                                      │
                 │  ┌───────────────────────────────┐   │
                 │  │       Record Service          │   │
                 │  │          Spring Boot          │   │
                 │  └───────────────────────────────┘   │
                 └───────────────────┬──────────────────┘
                                     │
                                     ▼
                         ┌───────────────────────┐
                         │       MySQL 8         │
                         │   Relational Database │
                         └───────────────────────┘
