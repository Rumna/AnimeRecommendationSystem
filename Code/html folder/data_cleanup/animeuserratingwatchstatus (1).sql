drop table if exists AnimeUserRatingWatchStatus;
create table AnimeUserRatingWatchStatus(UserID int not null,MALID int,Rating int, WatchingDescription char(30), WatchedEpisodes int);
load data local infile 'C:/Fall21/ECE656/project_dataset/animelist.csv' ignore into table AnimeUserRatingWatchStatus
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(UserID,MALID,Rating,@col4,WatchedEpisodes)