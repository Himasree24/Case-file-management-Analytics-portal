DROP DATABASE IF EXISTS bookflow_db;
CREATE DATABASE bookflow_db;

USE bookflow_db;


CREATE TABLE Books
(
    book_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(200) NOT NULL,

    author VARCHAR(150) NOT NULL,

    genre VARCHAR(100),

    description TEXT,

    published_year INT
);

INSERT INTO Books
(
    title,
    author,
    genre,
    description,
    published_year
)
VALUES

(
    'The Martian',
    'Andy Weir',
    'Science Fiction',
    'An astronaut struggles to survive alone on Mars.',
    2011
),

(
    'Dune',
    'Frank Herbert',
    'Science Fiction',
    'A story involving planets, politics, survival and space.',
    1965
),

(
    'The Hitchhikers Guide to the Galaxy',
    'Douglas Adams',
    'Science Fiction',
    'A humorous adventure across space and alien worlds.',
    1979
),

(
    'Pride and Prejudice',
    'Jane Austen',
    'Romance',
    'A classic story about relationships and social expectations.',
    1813
),

(
    'The Great Gatsby',
    'F. Scott Fitzgerald',
    'Classic',
    'A story of ambition, wealth, love and the American dream.',
    1925
),

(
    'Foundation',
    'Isaac Asimov',
    'Science Fiction',
    'A futuristic story about mathematics, civilization and space.',
    1951
),

(
    'The Hobbit',
    'J.R.R. Tolkien',
    'Fantasy',
    'A fantasy adventure involving Bilbo Baggins and a dangerous journey.',
    1937
),

(
    'Enders Game',
    'Orson Scott Card',
    'Science Fiction',
    'A young student is trained for an interstellar conflict.',
    1985
),

(
    'Harry Potter and the Sorcerers Stone',
    'J.K. Rowling',
    'Fantasy',
    'A young wizard begins his magical education.',
    1997
),

(
    'Twenty Thousand Leagues Under the Seas',
    'Jules Verne',
    'Adventure',
    'A fantastic underwater adventure aboard a mysterious submarine.',
    1870
);

SELECT
    book_id,
    title,
    author,
    genre,
    published_year
FROM Books
ORDER BY book_id;

ALTER TABLE Books
ADD COLUMN embedding JSON;

DESCRIBE Books;

UPDATE Books
SET embedding = JSON_ARRAY(0.90, 0.80, 0.20)
WHERE book_id = 1;
UPDATE Books
SET embedding = JSON_ARRAY(0.85, 0.75, 0.25)
WHERE book_id = 2;
UPDATE Books
SET embedding = JSON_ARRAY(0.80, 0.70, 0.30)
WHERE book_id = 3;
UPDATE Books
SET embedding = JSON_ARRAY(0.10, 0.20, 0.90)
WHERE book_id = 4;
UPDATE Books
SET embedding = JSON_ARRAY(0.15, 0.30, 0.80)
WHERE book_id = 5;
UPDATE Books
SET embedding = JSON_ARRAY(0.95, 0.65, 0.20)
WHERE book_id = 6;
UPDATE Books
SET embedding = JSON_ARRAY(0.30, 0.75, 0.90)
WHERE book_id = 7;
UPDATE Books
SET embedding = JSON_ARRAY(0.88, 0.85, 0.15)
WHERE book_id = 8;
UPDATE Books
SET embedding = JSON_ARRAY(0.20, 0.55, 0.95)
WHERE book_id = 9;
UPDATE Books
SET embedding = JSON_ARRAY(0.70, 0.90, 0.40)
WHERE book_id = 10;

SELECT
    book_id,
    title,
    embedding
FROM Books
ORDER BY book_id;


SELECT

    book_id,

    title,

    author,

    genre,

    ROUND(

        SQRT(

            POW(
                CAST(
                    JSON_EXTRACT(embedding, '$[0]')
                    AS DECIMAL(10,6)
                ) - 0.90,
                2
            )

            +

            POW(
                CAST(
                    JSON_EXTRACT(embedding, '$[1]')
                    AS DECIMAL(10,6)
                ) - 0.80,
                2
            )

            +

            POW(
                CAST(
                    JSON_EXTRACT(embedding, '$[2]')
                    AS DECIMAL(10,6)
                ) - 0.20,
                2
            )

        ),

        4

    ) AS l2_distance

FROM Books

WHERE embedding IS NOT NULL

ORDER BY l2_distance ASC

LIMIT 3;

SELECT

    book_id,

    title,

    author,

    genre,

    ROUND(

        (

            CAST(
                JSON_EXTRACT(embedding, '$[0]')
                AS DECIMAL(10,6)
            ) * 0.90

            +

            CAST(
                JSON_EXTRACT(embedding, '$[1]')
                AS DECIMAL(10,6)
            ) * 0.80

            +

            CAST(
                JSON_EXTRACT(embedding, '$[2]')
                AS DECIMAL(10,6)
            ) * 0.20

        )

        /

        (

            SQRT(

                POW(
                    CAST(
                        JSON_EXTRACT(embedding, '$[0]')
                        AS DECIMAL(10,6)
                    ),
                    2
                )

                +

                POW(
                    CAST(
                        JSON_EXTRACT(embedding, '$[1]')
                        AS DECIMAL(10,6)
                    ),
                    2
                )

                +

                POW(
                    CAST(
                        JSON_EXTRACT(embedding, '$[2]')
                        AS DECIMAL(10,6)
                    ),
                    2
                )

            )

            *

            SQRT(

                POW(0.90, 2)

                +

                POW(0.80, 2)

                +

                POW(0.20, 2)

            )

        ),

        4

    ) AS cosine_similarity

FROM Books

WHERE embedding IS NOT NULL

ORDER BY cosine_similarity DESC

LIMIT 3;

SELECT
    book_id,
    title,
    author,
    genre,
    published_year,
    embedding
FROM Books
ORDER BY book_id;