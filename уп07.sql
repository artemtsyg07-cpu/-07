CREATE TABLE clients(
   client_id SERIAL PRIMARY KEY,
   login TEXT NOT NULL UNIQUE,
   client_password INT NOT NULL
   );
   
CREATE TABLE outfits(
   outfit_id SERIAL PRIMARY KEY,
   outfit_login TEXT NOT NULL UNIQUE
   );
CREATE TABLE sizes(
   size_id SERIAL PRIMARY KEY,
   size_login TEXT NOT NULL UNIQUE
   );
CREATE TABLE outfits_sizes(
   outfits_size_id SERIAL PRIMARY KEY,
   outfit_id INT References outfits(outfit_id),
   size_id INT References sizes(size_id)
   );
CREATE TABLE issuances(
   issuance_id SERIAL PRIMARY KEY,
   client_id INT References clients(client_id),
   outfits_size_id INT References outfits_sizes(outfits_size_id)
   );
   
INSERT INTO clients (login, client_password) VALUES 
('ivan_99', 1111),
('anna_s', 2222),
('sergey_pro', 3333),
('elena_kn', 4444),
('dmitry_v', 5555);


INSERT INTO outfits (outfit_login) VALUES 
('Смокинг классический'),
('Вечернее платье красное'),
('Костюм-тройка серый'),
('Спортивное худи'),
('Кожаная куртка кулиса');


INSERT INTO sizes (size_login) VALUES 
('Размер XS (42)'),
('Размер S (44)'),
('Размер M (46)'),
('Размер L (48)'),
('Размер XL (50)');


INSERT INTO outfits_sizes (outfit_id, size_id) VALUES 
(1, 3),
(2, 2), 
(3, 4), 
(4, 3),
(5, 5); 


INSERT INTO issuances (client_id, outfits_size_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

SELECT 
    i.issuance_id,
    c.login AS client_name,
    o.outfit_login AS outfit_name,
    s.size_login AS outfit_size
FROM issuances i
JOIN clients c ON i.client_id = c.client_id
JOIN outfits_sizes os ON i.outfits_size_id = os.outfits_size_id
JOIN outfits o ON os.outfit_id = o.outfit_id
JOIN sizes s ON os.size_id = s.size_id;

SELECT 
    c.login AS client_name,
    COUNT(i.issuance_id) AS total_items_taken
FROM clients c
LEFT JOIN issuances i ON c.client_id = i.client_id
GROUP BY c.login
ORDER BY total_items_taken DESC;

UPDATE clients SET login = 'ivan_superstar' WHERE login = 'ivan_ivanov';

SELECT 
    rolname AS db_user,
    rolsuper AS is_admin,
    rolcreaterole AS can_create_roles,
    rolcreatedb AS can_create_db,
    rolcanlogin AS can_login
FROM pg_roles;
