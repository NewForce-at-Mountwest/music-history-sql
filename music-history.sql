--Query all of the entries in the Genre table
SELECT Id, Label FROM Genre;

--Using the INSERT statement, add one of your favorite artists to the Artist table.
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Lil Wayne', 1993);

--Using the INSERT statement, add one, or more, albums by your artist to the Album table.
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Lights Out', '12/19/2000', 24000, 'Cash Money', (SELECT Id FROM Artist WHERE ArtistName='Lil Wayne'), (SELECT Id FROM Genre WHERE Label='Rap'));
--SELECT * FROM Album;

--Using the INSERT statement, add some songs that are on that album to the Song table.
INSERT INTO Song
(Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId)
VALUES ('Get off the Corner', 1000, '12/19/2000',
(SELECT Id FROM Genre WHERE Label='Rap'),
(SELECT Id FROM Artist WHERE ArtistName='Lil Wayne'),
(SELECT Id FROM Album WHERE Title='Lights Out'));



--Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

SELECT Song.Title AS 'Song Title',
Album.Title AS 'Album Title',
Artist.ArtistName AS 'Artist Name'
FROM Album JOIN Song
ON Song.AlbumId=Album.Id LEFT JOIN
Artist ON Artist.Id=Album.ArtistId
WHERE Artist.ArtistName = 'Lil Wayne';


--Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT Artist.ArtistName, COUNT(Song.Id) AS 'Number of Songs'
FROM Artist
JOIN Song ON Artist.Id = Song.ArtistId GROUP BY (Artist.ArtistName);

--Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT Genre.Label, COUNT(Song.Id) AS 'Number of Songs'
FROM Genre
JOIN Song ON Genre.Id = Song.GenreId
GROUP BY (Genre.Label);

--Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.

SELECT Title, AlbumLength FROM Album WHERE AlbumLength=
(SELECT MAX(Album.AlbumLength) FROM Album);

SELECT TOP 1 Title, AlbumLength FROM ALBUM ORDER BY AlbumLength DESC;

--Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
SELECT TOP 1 Title, SongLength FROM Song ORDER BY SongLength DESC;

--Modify the previous query to also display the title of the album.
SELECT TOP 1 s.Title, s.SongLength, a.Title FROM Song s
JOIN Album a ON s.AlbumId = a.Id
ORDER BY SongLength DESC;

SELECT s.Title, s.SongLength, a.Title FROM Song s
JOIN Album a ON s.AlbumId = a.Id
WHERE s.SongLength=(SELECT MAX(s.SongLength) FROM Song s);

SELECT s.Title, g.Label FROM Song s RIGHT JOIN Genre g ON s.GenreId = g.Id;


