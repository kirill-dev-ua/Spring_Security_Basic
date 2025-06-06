INSERT INTO roles (name)
VALUES ('ADMIN'),
       ('USER');

INSERT INTO permissions (name)
VALUES ('READ'),
       ('WRITE'),
       ('DELETE');

INSERT INTO role_permissions (role_id, permission_id)
VALUES ((select r.id from roles r where r.name = 'ADMIN'),
        (select p.id from permissions p where p.name = 'READ')),
       ((select r.id from roles r where r.name = 'ADMIN'),
        (select p.id from permissions p where p.name = 'WRITE')),
       ((select r.id from roles r where r.name = 'ADMIN'),
        (select p.id from permissions p where p.name = 'DELETE')),
       ((select r.id from roles r where r.name = 'USER'),
        (select p.id from permissions p where p.name = 'READ'));

--password 123456789
INSERT INTO users (username, password, role_id)
VALUES ('admin', '$2a$10$QqBL6O/DQDbdqwcAzcVUE.p9B2tJQXb6i9E9iFhAkOc2C9T/H6PPC',
                                                        (select r.id from roles r where r.name = 'ADMIN'));

-- INSERT INTO users (username, password, role_id)
-- SELECT
--     'user' || generate_series(1, 100),
--     md5(random()::text),
--     CASE WHEN random() > 0.5 THEN (select r.id from roles r where r.name = 'ADMIN')
--         ELSE (select r.id from roles r where r.name = 'USER') END
-- FROM generate_series(1, 100);