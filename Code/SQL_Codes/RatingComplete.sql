use animedb;
show tables;

drop table if exists AnimeRatingComplete;
create table AnimeRatingComplete(UserID int not null,MALID int not null,rating int not NULL);
load data local infile 'D:/ECE 656/proj/rating_complete.csv' ignore into table AnimeRatingComplete
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(UserID,MALID,Rating);
ALTER TABLE AnimeRatingComplete ADD CONSTRAINT PK_AnimeRatingComplete PRIMARY KEY (UserID,MALID);