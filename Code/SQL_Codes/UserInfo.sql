#use animedb;
drop table if exists UserInfo;

create table UserInfo(UserID int primary key,
			 Password int not null,
             Role varchar(20) not null);
             
load data local infile 'D:/ECE 656/proj/UserInfo.csv' ignore into table UserInfo
     fields terminated by ','
     enclosed by '"'
     lines terminated by '\n'
	 ignore 353006 lines;
     
Select * from UserInfo;

SELECT * FROM userinfo WHERE userid=(SELECT max(userid) FROM userinfo);

update userinfo set role="Admin User" where userid=1;