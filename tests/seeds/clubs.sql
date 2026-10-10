-- Membership and section seeds assign every club. The schema does not ship
-- clubs, so the suite needs a few rows before those scripts run.
INSERT INTO clubs (ssv, name, bfs_name) VALUES
('9101', 'Test Schützengesellschaft Eins', 'Eins'),
('9102', 'Test Schützengesellschaft Zwei', 'Zwei');
