drop table if exists AnimeUserRatingWatchStatus;
create table AnimeUserRatingWatchStatus(UserID int not null,MALID int,Rating int, WatchingDescription char(30), WatchedEpisodes int,
										PRIMARY KEY(UserID,MALID), CONSTRAINT fk_AnimeUserRatingWatchStatus_UserInfo FOREIGN KEY
                                        (UserID) references UserInfo(UserID), CONSTRAINT fk_AnimeUserRatingWatchStatus_AnimeInfo 
                                        FOREIGN KEY (MALID) REFERENCES AnimeInfo(MALID));
load data local infile 'C:/Fall21/ECE656/project_dataset/animelist.csv' ignore into table AnimeUserRatingWatchStatus
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(UserID,MALID,Rating,@col4,WatchedEpisodes)
set WatchingDescription =if(@col4 = 1, 'Currently Watching', @col4),
	WatchingDescription =if(@col4 = 2, 'Completed', @col4), WatchingDescription =if(@col4 = 3, 'On Hold', @col4),
    WatchingDescription =if(@col4 = 4, 'Dropped', @col4), WatchingDescription =if(@col4 = 6, 'Plan to Watch', @col4);