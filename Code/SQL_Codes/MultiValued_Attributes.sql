use animeDB;
drop table if exists Genre;
CREATE TABLE Genre(MALID int not null, Genre char(30), Primary key (MALID,Genre),
				   CONSTRAINT fk_Genre_AnimeInfo Foreign key (MALID) references animeinfo(MALID));
load data local infile 'D:/ECE 656/proj/data_cleanup/CSVs/Genre.csv' ignore into table Genre
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1,@col2)
set MALID = @col1, Genre = @col2;

-- Producers>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
drop table if exists Producer;
CREATE TABLE Producer(MALID int not null, Producer char(50), Primary key (MALID,Producer),
				   CONSTRAINT fk_Producer_AnimeInfo Foreign key (MALID) references animeinfo(MALID));
load data local infile 'D:/ECE 656/proj/data_cleanup/CSVs/Producers.csv' ignore into table Producer
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1,@col2)
set MALID = @col1, Producer = @col2;

-- Licensors>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
drop table if exists Licensor;
CREATE TABLE Licensor(MALID int not null, Licensor char(50), Primary key (MALID,Licensor),
				   CONSTRAINT fk_Licensor_AnimeInfo Foreign key (MALID) references animeinfo(MALID));
load data local infile 'D:/ECE 656/proj/data_cleanup/CSVs/Licensors.csv' ignore into table Licensor
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1,@col2)
set MALID = @col1, Licensor = @col2;



-- Studios>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
drop table if exists Studio;
CREATE TABLE Studio(MALID int not null, Studio char(50), Primary key (MALID,Studio),
				   CONSTRAINT fk_Studio_AnimeInfo Foreign key (MALID) references animeinfo(MALID));
load data local infile 'D:/ECE 656/proj/data_cleanup/CSVs/Studios.csv' ignore into table Studio
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1,@col2)
set MALID = @col1, Studio = @col2;

-- UserInfo>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
drop table if exists UserInfo;
CREATE TABLE UserInfo(UserID int not null, Password int not null, Role char(25), Primary key (UserID));
load data local infile 'D:/ECE 656/proj/data_cleanup/CSVs/UserInfo.csv' ignore into table UserInfo
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1,@col2,@col3)
set UserID = @col1, Password = @col2, Role = @col3;




#show tables;
select * from genre;

#show create table UserInfo;