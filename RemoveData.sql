-- Drop all tables in the correct order to avoid dependency issues
DROP TABLE IF EXISTS SERVICECOST CASCADE;
DROP TABLE IF EXISTS SCOOTERMODEL CASCADE;
DROP TABLE IF EXISTS TYPEOF CASCADE;
DROP TABLE IF EXISTS STATION CASCADE;
DROP TABLE IF EXISTS PERSON CASCADE;
DROP TABLE IF EXISTS CLIENT CASCADE;
DROP TABLE IF EXISTS EMPLOYEE CASCADE;
DROP TABLE IF EXISTS REPLACEMENTORDER CASCADE;
DROP TABLE IF EXISTS SCOOTER CASCADE;
DROP TABLE IF EXISTS DOCK CASCADE;
DROP TABLE IF EXISTS REPLACEMENT CASCADE;
DROP TABLE IF EXISTS CARD CASCADE;
DROP TABLE IF EXISTS TOPUP CASCADE;
DROP TABLE IF EXISTS TRAVEL CASCADE;