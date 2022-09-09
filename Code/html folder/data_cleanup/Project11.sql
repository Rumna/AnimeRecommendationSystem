create database animeDB;
use animeDB;
show databases;
show tables;

drop table if exists AnimeInfo;
create table AnimeInfo(MALID int not null , Name varchar(50) not null,Score float, EnglishName varchar(50), JapaneseName varchar(50),
						Type char(8), Episodes int, Aired varchar(30), Aired_start date, Aired_end date, Premiered VARCHAR(15),
                        Source char(20), Duration VARCHAR(30),  hr_duration INT, min_duration INT, Duration_in_min_per_episode INT, 
                        Rating Char(10), Ranked int, Popularity int, Members int, Favourites int, Watching int, Completed int, 
                        OnHold int, Dropped int, PlanToWatch int, PRIMARY KEY (MALID));
load data local infile 'C:/Fall21/ECE656/project_dataset/anime.csv' ignore into table AnimeInfo
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1, @col2,@col3, @col4,@col5, @col6,@col7, @col8,@col9, @col10,@col11, @col12,@col13, @col14,@col15, @col16,@col17, @col18,@col19,
 @col20,@col21, @col22, @col23, @col24,@col25, @col26,@col27, @col28,@col29, @col30, @col31, @col32, @col33, @col34, @col35)
 set MALID = @col1, Name = @col2, Score = @col3, EnglishName = @col5, JapaneseName = @col6, Type = @col7, Episodes = @col8, Aired = @col9,
	 Aired_start = NULL, Aired_end = Null, Premiered = @col10, Source= @col14, Duration = @col15, 
     hr_duration = regexp_replace(regexp_substr(Duration, '^[0-9]{1,2} hr'),' hr',''),                
     min_duration = regexp_replace(regexp_substr(@col15,'[0-9]{1,2} min'),' min',''),-- converting null to 0 and then converting from hrs to minw
     Duration_in_min_per_episode = (coalesce(hr_duration*60,0) + coalesce(min_duration,0)),
	 Rating = regexp_substr(@col16,'(^R - 17\+)|(^PG-13)|(^PG)|(^R\+)|(G)|(^Rx)|(^Unknown)'), Ranked= @col17, Popularity=@col18, 
     Members= @col19, Favourites = @col20, Watching = @col21, Completed= @col22,OnHold= @col23, Dropped= @col24, PlanToWatch= @col25;
update AnimeInfo set Aired_start = str_to_date(regexp_replace(regexp_substr(Aired, '^[a-zA-Z]{3} [0-9]{1,2}, [0-9]{4}'),',' ,''),"%M %d %Y");
update AnimeInfo set Aired_end = str_to_date(regexp_replace(regexp_substr(regexp_substr(Aired, 'to [a-zA-Z]{3} [0-9]{1,2}, [0-9]{4}$'),'[a-zA-Z]{3} [0-9]{1,2}, [0-9]{4}$'),',',''),"%M %d %Y");
update AnimeInfo set hr_duration = 0 where hr_duration is NULL;
update AnimeInfo set Rating = NULL where Rating ='Unknown';
update AnimeInfo set Premiered = NULL where Premiered ='Unknown';
update AnimeInfo set Source  = NULL where Source ='Unknown';
Alter table AnimeInfo drop Aired,drop Duration,drop hr_duration, drop min_duration;

 

 
 
 
select * from animeinfo;