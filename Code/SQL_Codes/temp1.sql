use animedb;
DROP TABLE IF EXISTS Genre;
CREATE TABLE Genre(`key` int, genre char(255));

#DROP TABLE IF EXISTS tempGenre;
#CREATE TABLE tempGenre(`key` int, genre CHAR(255));

#INSERT INTO tempGenre VALUES (100, 'abc,def,ghi,ehk,xyz'), (200, 'jkl,mno,pqr');
#SELECT * FROM tempGenre;

#SET @VKey := '';
#SET @VExec := (SELECT CONCAT('INSERT INTO splitVals VALUES', TRIM(TRAILING ',' FROM GROUP_CONCAT(CONCAT('(', @VKey:= `key`, ', \'', REPLACE(concatenatedValue, ',', CONCAT('\'), (', @VKey, ', \'')), '\'),') SEPARATOR '')), ';') FROM concatenatedVals);

#desc Genre;
SET @VKey= '';
SET @VExec= (SELECT CONCAT('INSERT INTO Genre VALUES', TRIM(TRAILING ',' FROM GROUP_CONCAT(CONCAT('(', @VKey:= `key`, ', \'', REPLACE(genre, ',', CONCAT('\'), (', @VKey, ', \'')), '\'),') SEPARATOR '')), ';') FROM tempAnimeGenre);

PREPARE stmt FROM @VExec;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT * FROM Genre;

select count(*) from Genre;