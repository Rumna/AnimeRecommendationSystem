DROP TABLE IF EXISTS concatenatedVals;
CREATE TABLE concatenatedVals(`key` INTEGER UNSIGNED, concatenatedValue CHAR(255));

DROP TABLE IF EXISTS splitVals;
CREATE TABLE splitVals(`key` INTEGER UNSIGNED, splitValue CHAR(255));

INSERT INTO concatenatedVals VALUES (100, 'abc,def,ghi,ehk,xyz'), (200, 'jkl,mno,pqr');
SELECT * FROM concatenatedVals;

SET @VKey := '';
SET @VExec := (SELECT CONCAT('INSERT INTO splitVals VALUES', TRIM(TRAILING ',' FROM GROUP_CONCAT(CONCAT('(', @VKey:= `key`, ', \'', REPLACE(concatenatedValue, ',', CONCAT('\'), (', @VKey, ', \'')), '\'),') SEPARATOR '')), ';') FROM concatenatedVals);

PREPARE stmt FROM @VExec;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT * FROM splitVals;