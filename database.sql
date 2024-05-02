DROP DATABASE IF EXISTS magazzino;
CREATE DATABASE magazzino;
USE magazzino;

CREATE TABLE IF NOT EXISTS prodotto (
    id_prodotto INT PRIMARY KEY AUTO_INCREMENT,
    descrizione VARCHAR(250) NOT NULL,
    prezzo DECIMAL(10, 2) NOT NULL,
    taglia VARCHAR(50) NOT NULL,
    disponibilita INT NOT NULL
);

-- Creazione della tabella "account"
CREATE TABLE IF NOT EXISTS account (
    id_account INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(150) NOT NULL,
    password VARCHAR(150) NOT NULL,
    nome VARCHAR(250) NOT NULL,
    cognome VARCHAR(250) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    data_nascita DATE NOT NULL
);

-- Creazione della tabella "ordine"
CREATE TABLE IF NOT EXISTS ordine (
    id_ordine INT PRIMARY KEY AUTO_INCREMENT,
    id_prodotto INT NOT NULL,
    id_account INT NOT NULL,
    data_ordine DATE NOT NULL,
    FOREIGN KEY (id_prodotto) REFERENCES prodotto(id_prodotto),
    FOREIGN KEY (id_account) REFERENCES account(id_account)
);


-- Inserimento di dati casuali nella tabella "prodotto"
INSERT INTO prodotto (descrizione, prezzo, taglia, disponibilita)
VALUES
    ('Maglietta', 19.99, 'M', 100),
    ('Pantaloni', 29.99, 'L', 50),
    ('Scarpe sportive', 49.99, '42', 30),
    ('Felpa con cappuccio', 39.99, 'S', 70),
    ('Giacca invernale', 79.99, 'XL', 20);

-- Inserimento di dati casuali nella tabella "account"
INSERT INTO account (username, password, nome, cognome, telefono, data_nascita)
VALUES
    ('utente1', 'password1', 'Mario', 'Rossi', '123456789', '1990-05-15'),
    ('utente2', 'password2', 'Laura', 'Bianchi', '987654321', '1985-08-20'),
    ('utente3', 'password3', 'Giovanni', 'Verdi', '555123456', '2000-02-10');

-- Inserimento di dati casuali nella tabella "ordine"
INSERT INTO ordine (id_prodotto, id_account, data_ordine)
VALUES
    (1, 1, '2024-04-01'),
    (2, 2, '2024-04-05'),
    (3, 3, '2024-04-10'),
    (4, 1, '2024-04-15'),
    (5, 2, '2024-04-20');
