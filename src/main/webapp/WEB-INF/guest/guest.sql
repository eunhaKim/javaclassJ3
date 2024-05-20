show tables;

create table guest (
	idx 			int not null auto_increment primary key,	/* 방명록 고유번호 */
	name 			varchar(20) not null,											/* 방명록 작성자 */
	content		text not null,														/* 방명록 내용 */
	email			varchar(60),															/* 이메일주소 */
	homePage 	varchar(60),															/* 홈페이지주 소*/
	visitDate datetime default now(),										/* 방문일자 */
	hostIp varchar(30) not null													/* 방문자의 접속 IP */
);

desc guest;

insert into guest values (default, '관리자', '방명록 서비스를 시작합니다.', '','',default,'192.168.10.51');
select * from guest;