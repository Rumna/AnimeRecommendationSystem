drop table if exists AnimeInfo;

Create table AnimeInfo(MAL_ID int,Name varchar(50),Score float,EnlglishName varchar(50));
Insert into AnimeInfo values(1,"Cowboy Bebop",8.78,"Cowboy Bebop");
Insert into AnimeInfo values(5,"Cowboy Bebop: Tengoku no Tobira",8.29,"Cowboy Bebop:The Movie");
Insert into AnimeInfo values(6,"Trigun",8.24,"Trigun");

select * from AnimeInfo;
