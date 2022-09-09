use animedb;

drop table if exists tempAnimeGenre;

create table tempAnimeGenre (`key` int,
			 Genre varchar(255)
			 );

load data local infile 'D:/ECE 656/proj/anime.csv' ignore into table tempAnimeGenre
     fields terminated by ','
     enclosed by '"'
     lines terminated by '\n'
	 ignore 1 lines
     (@col1, @col2,@col3, @col4,@col5, @col6,@col7, @col8,@col9, @col10,@col11, @col12,@col13, @col14,@col15, @col16,@col17, @col18,@col19,
 @col20,@col21, @col22, @col23, @col24,@col25, @col26,@col27, @col28,@col29, @col30, @col31)
 set `key` = @col1, Genre = regexp_replace(@col4,' ','');
 
 select * from tempAnimeGenre;