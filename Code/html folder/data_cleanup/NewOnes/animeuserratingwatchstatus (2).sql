use animedb;
show tables;
drop table if exists AnimeUserRatingWatchStatus;
create table AnimeUserRatingWatchStatus(UserID int not null,MALID int,Rating int, WatchingStatus INT, WatchedEpisodes int);
					-- 					,PRIMARY KEY(UserID,MALID), CONSTRAINT fk_AnimeUserRatingWatchStatus_UserInfo FOREIGN KEY
                    --                    (UserID) references UserInfo(UserID), CONSTRAINT fk_AnimeUserRatingWatchStatus_AnimeInfo 
                    --                    FOREIGN KEY (MALID) REFERENCES AnimeInfo(MALID));
load data local infile 'C:/Fall21/ECE656/project_dataset/animelist1.csv' ignore into table AnimeUserRatingWatchStatus
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(UserID,MALID,Rating,WatchingStatus,WatchedEpisodes);
ALTER TABLE animeuserratingwatchstatus ADD CONSTRAINT PK_animeuserratingwatchstatus PRIMARY KEY (UserID,MALID);



