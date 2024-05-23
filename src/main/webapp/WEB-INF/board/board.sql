show tables;

create table movieRecommend (
	idx  int not null auto_increment,		/* 게시글의 고유번호 */
  mid  varchar(20) not null,					/* 게시글 올린이 아이디 */
  title varchar(100)   not null,			/* 게시글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  hostIp  varchar(40) not null,				/* 글 올린이 IP */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  good		int default 0,							/* '좋아요' 클릭 횟수 누적 */
  complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO) */
  listImg		varchar(100) default 'noimage.jpg',			/* 업로드시의 화일명(리스트이미지) */
  listImgfSName   varchar(100), 		/* 실제 서버에 저장되는 파일명(리스트이미지) */
  fName		varchar(200),			/* 업로드시의 화일명(본문삽입이미지) */
  fSName   varchar(200), 		/* 실제 서버에 저장되는 파일명(본문삽입이미지) */
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(mid) references member(mid)
);

drop table  movieRecommend;
desc  movieRecommend;

insert into  movieRecommend values (default,'admin','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,'192.168.50.70',default,default,default,'noimage.jpg','','','');
select * from movieRecommend; 
