CREATE TABLE users (
    id SERIAL NOT NULL,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    created_at TIMESTAMP(0),
    PRIMARY KEY (id)
);

CREATE FUNCTION public.insertUsers() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 output TEXT;
BEGIN
    CASE 
        WHEN NEW.age>=18 THEN UPDATE users SET created_at=NOW() WHERE id=NEW.id;
        ELSE DELETE FROM users WHERE id=NEW.id;
    END CASE;
    CASE 
        WHEN NEW.age>=18 THEN output:=CONCAT(NEW.name, ' has been saved as user');
        ELSE output:=CONCAT(NEW.name, ' is under 18 years old');
    END CASE;
    raise notice '%', output;
    RETURN coalesce(NEW, OLD);
END;
$$;

CREATE FUNCTION public.userNameFormat() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    output TEXT;
BEGIN 
    CASE
        WHEN (UPPER(SUBSTR(NEW.name, 1, 1))!=SUBSTR(NEW.name, 1, 1)) OR (LOWER(SUBSTR(NEW.name, 2))!=SUBSTR(NEW.name, 2)) 
        THEN UPDATE users SET name=CONCAT(UPPER(SUBSTR(NEW.name, 1, 1)), LOWER((SUBSTR(NEW.name, 2)))) WHERE id=NEW.id;
        ELSE null;
    END CASE;
    output:=CONCAT(NEW.name, ' became ', CONCAT(UPPER(SUBSTR(NEW.name, 1, 1)), LOWER((SUBSTR(NEW.name, 2)))));
    CASE
        WHEN (UPPER(SUBSTR(NEW.name, 1, 1))!=SUBSTR(NEW.name, 1, 1)) OR (LOWER(SUBSTR(NEW.name, 2))!=SUBSTR(NEW.name, 2)) 
        THEN raise notice '%', output;
        ELSE null;
    END CASE;
    RETURN coalesce(NEW, OLD);
END;
$$;

CREATE TRIGGER insertUsers AFTER INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.insertUsers();
CREATE TRIGGER userNameFormat AFTER INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.userNameFormat();

INSERT INTO users (name, age) VALUES ('Jean', 32);
INSERT INTO users (name, age) VALUES ('Marie', 17);
INSERT INTO users (name, age) VALUES ('marcO', 18);

SELECT * FROM users;

DROP FUNCTION public.insertUsers() CASCADE;
DROP FUNCTION public.userNameFormat() CASCADE;

DELETE FROM users;


