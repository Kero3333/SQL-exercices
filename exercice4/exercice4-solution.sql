/* 4.1 Select the title of all movies. */

SELECT title FROM movies;

/* 4.2 Show all the distinct ratings in the database. */

SELECT DISTINCT rating FROM movies;

/* 4.3  Show all unrated movies. */

SELECT * FROM movies WHERE rating IS NULL;

/* 4.4 Select all movie theaters that are not currently showing a movie. */

SELECT * FROM movietheaters WHERE movie IS NULL;

/* 4.5 Select all data from all movie theaters and, additionally,
 the data from the movie that is being shown in the theater (if one is being shown). */

SELECT * FROM movietheaters AS mt LEFT JOIN movies AS m ON mt.movie=m.code;

/* 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater. */

SELECT * FROM movies AS m LEFT JOIN movietheaters AS mt ON m.code=mt.movie;

/* 4.7 Show the titles of movies not currently being shown in any theaters. */

SELECT title FROM movies AS m LEFT JOIN movietheaters AS mt ON m.code=mt.movie WHERE mt.movie IS NULL;

/* 4.8 Add the unrated movie "One, Two, Three". */

INSERT INTO movies (code, title) VALUES ((SELECT MAX(code) + 1 FROM movies), 'One, Two, Three');

/* 4.9 Set the rating of all unrated movies to "G". */

UPDATE movies SET rating='G' WHERE rating IS NULL;

/* 4.10 Remove movie theaters projecting movies rated "NC-17". */

DELETE FROM movietheaters AS mt USING movies AS m WHERE mt.movie=m.code AND m.rating='NC-17';
