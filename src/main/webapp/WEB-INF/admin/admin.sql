show tables;

create table visitors (
	idx int auto_increment primary key, /* 테이블 고유번호 */
	visitTime datetime default now(),	/* 방문시간 */
	visitIp varchar(45) not null
);

desc visitors;
drop table visitors;
select date_format(now(),'%Y-%m-%d');
insert into visitors values (default, date_format(now(),'%Y-%m-%d'), 127.0.0.1);