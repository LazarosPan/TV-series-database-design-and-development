# Advanced Database Systems Coursework

## Overview

This project focuses on the design and implementation of a database for managing TV series data, including actors, series, episodes, viewers, and viewership information. The database follows a set of business rules to track various aspects of TV series production and consumption, such as actor participation, viewer demographics, and viewing patterns. The coursework consists of multiple tasks that guide the creation, manipulation, and querying of the database using SQL and Oracle.

## Table of Contents
1. [Project Description](#project-description)
2. [Task 1: Table Specifications](#task-1-table-specifications)
3. [Task 2: SQL Scripts](#task-2-sql-scripts)
    1. [Create Tables](#create-tables)
    2. [Constraints](#constraints)
    3. [Insert Data](#insert-data)
    4. [Drop Tables](#drop-tables)
    5. [Queries](#queries)
4. [Task 3: Test Plan](#task-3-test-plan)
5. [Advanced Database Design](#advanced-database-design)
    1. [Star and Snowflake Schema Implementation](#star-and-snowflake-schema-implementation)
    2. [TF-IDF Implementation](#tf-idf-implementation)

## Project Description

The objective of this project is to create a database for managing data related to TV series production. This database will store information about actors, TV series, episodes, viewers, and viewership records. It will enable querying and analysis of various aspects, such as actor participation in multiple series, viewer demographics, and episode viewership trends.

The database consists of several key entities:
- **Actors**: Records details of actors participating in one or more TV series.
- **Series**: Stores information about TV series, including the title, description, and production year.
- **Casting**: Tracks which actor is cast in which series and their role.
- **Episodes**: Each series has multiple episodes, with details such as title, season number, and length.
- **Viewers**: Contains information about viewers, including personal details.
- **Viewership**: Records which viewer watched which episode and when.

## Task 1: Table Specifications

The database will include tables for all entities, such as `Actors`, `Series`, `Casting`, `Episodes`, `Viewers`, and `Viewership`. Each table will have the appropriate data types, constraints (e.g., primary keys, foreign keys, unique constraints), and default values to maintain data integrity.

### Table Design Considerations:
- **Primary Keys**: Each table will have unique primary keys.
- **Foreign Keys**: Relationships between tables (e.g., between `Actors` and `Casting`, `Series` and `Episodes`) will be enforced through foreign key constraints.
- **Data Integrity**: Constraints such as `NOT NULL`, `DEFAULT`, and `CHECK` will be used to maintain data validity.
  
## Task 2: SQL Scripts

### Create Tables

The `create_tables.sql` contains SQL commands to create the database tables in the correct order, ensuring referential integrity.

### Constraints

The `table_constraints.sql` script defines and adds constraints to the tables, including primary keys, foreign keys, unique constraints, and checks.

### Insert Data

The `insert_tables.sql` script includes commands to insert sample data into each table, ensuring the data supports queries for later tasks.

### Drop Tables

The `drops.sql` script handles dropping tables, constraints, and sequences in the correct order, ensuring no integrity violations.

### Queries

The `queries.sql` script includes queries to:
- Retrieve all records from a table
- Perform projections and restrictions (e.g., pattern matching, negative conditions, date ranges)
- Execute join queries across multiple tables
- Perform aggregations, such as counting viewers per country or identifying the most popular episode
- Complex queries such as finding actors by birth month, viewers by address, and calculating average episode lengths

## Task 3: Test Plan

The test plan documents the testing of all database elements, including:
- Table creation and structure verification
- Successful insertion of sample data
- Execution of queries to verify the correctness of the data and constraints
- Correctness of dropping all tables and constraints

### Test Plan Structure
| Test Element        | SQL Command                 | Expected Result            | Success Status | Screenshot |
|---------------------|-----------------------------|----------------------------|----------------|------------|
| Table Creation      | `CREATE TABLE Actors...`     | Table created successfully | Yes            | ![Screenshot](path) |
| Query 1 (Projection)| `SELECT name, surname...`    | Correct data returned      | Yes            | ![Screenshot](path) |
| Drop Tables         | `DROP TABLE Actors...`       | Tables dropped successfully| Yes            | ![Screenshot](path) |

## Advanced Database Design

### Star and Snowflake Schema Implementation

In Part B of the coursework, a star or snowflake schema could be introduced to restructure the database for analytical purposes. These schema models are typically used in data warehousing to optimize complex queries.

- **Star Schema**: A central fact table (e.g., `Viewership`) and dimension tables (e.g., `Actors`, `Series`, `Episodes`, `Viewers`) could be created to store dimension data.
- **Snowflake Schema**: Normalized dimension tables could be used, splitting each dimension into sub-dimensions for further granularity.

### TF-IDF Implementation

The second part of the advanced task involves calculating Term Frequency-Inverse Document Frequency (TF-IDF) scores for a set of two documents. The scores will be calculated using simple term frequency for the 10 most frequent terms, which can be useful for identifying important terms in the documents.

---

## Conclusion

This project covers the full spectrum of database creation, from designing tables and relationships to writing SQL queries for real-world scenarios. Additionally, it explores advanced concepts like schema design and TF-IDF scoring, providing a comprehensive learning experience in database management.
