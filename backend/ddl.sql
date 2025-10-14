CREATE TABLE
    IF NOT EXISTS public.clan (
        clan_id BIGSERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS public."character" (
        character_id BIGSERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        age INTEGER NOT NULL,
        clan_id BIGINT,
        CONSTRAINT fk_clan FOREIGN KEY (clan_id) REFERENCES public.clan (clan_id)
    );

INSERT INTO
    public.clan (name)
VALUES
    ('Uzumaki'),
    ('Uchiha'),
    ('Hyuga'),
    ('Haruno');

INSERT INTO
    public."character" (name, age, clan_id)
VALUES
    ('Naruto', 17, 1),
    ('Sasuke', 17, 2),
    ('Hinata', 16, 3),
    ('Sakura', 17, 4);