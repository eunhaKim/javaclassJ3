show tables;

/* 영화추천테이블 */
create table movieRecommend (
	idx  int not null auto_increment,		/* 게시글의 고유번호 */
  mid  varchar(20) not null,					/* 게시글 올린이 아이디 */
  nickName  varchar(20) not null,			/* 게시글 올린이 별명 */
  title varchar(100)   not null,			/* 게시글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  hostIp  varchar(40) not null,				/* 글 올린이 IP */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  good		int default 0,							/* '좋아요' 클릭 횟수 누적 */
  complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO) */
  listImg		varchar(100) default 'noimage.jpg',			/* 업로드시의 화일명(리스트이미지) */
  listImgfSName   varchar(100), 			/* 실제 서버에 저장되는 파일명(리스트이미지) */
  fName		varchar(200),								/* 업로드시의 화일명(본문삽입이미지) */
  fSName   varchar(200), 							/* 실제 서버에 저장되는 파일명(본문삽입이미지) */
  openSw char(2) default 'OK',				/* 게시글 공개여부(OK:공개, NO:비공개) */
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(mid) references member(mid)
);

drop table  movieRecommend;
desc  movieRecommend;

insert into movieRecommend values (default,'admin','관리자','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,'192.168.0.1',default,default,default,'noimage.jpg','noimage.jpg',default,default);
insert into  movieRecommend values (default,'admin','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,'192.168.50.70',default,default,default,'noimage.jpg','','','');
select * from movieRecommend; 

/* 영화소식테이블 */
create table movieNews (
	idx  int not null auto_increment,		/* 게시글의 고유번호 */
  mid  varchar(20) not null,					/* 게시글 올린이 아이디 */
  nickName  varchar(20) not null,			/* 게시글 올린이 별명 */
  title varchar(100)   not null,			/* 게시글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  hostIp  varchar(40) not null,				/* 글 올린이 IP */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  good		int default 0,							/* '좋아요' 클릭 횟수 누적 */
  complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO) */
  listImg		varchar(100) default 'noimage.jpg',			/* 업로드시의 화일명(리스트이미지) */
  listImgfSName   varchar(100), 			/* 실제 서버에 저장되는 파일명(리스트이미지) */
  fName		varchar(200),								/* 업로드시의 화일명(본문삽입이미지) */
  fSName   varchar(200), 							/* 실제 서버에 저장되는 파일명(본문삽입이미지) */
  openSw char(2) default 'OK',				/* 게시글 공개여부(OK:공개, NO:비공개) */
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(mid) references member(mid)
);

/* 같이영화보러가요 테이블 */
create table movieTogether (
	idx  int not null auto_increment,		/* 게시글의 고유번호 */
  mid  varchar(20) not null,					/* 게시글 올린이 아이디 */
  nickName  varchar(20) not null,			/* 게시글 올린이 별명 */
  title varchar(100)   not null,			/* 게시글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  hostIp  varchar(40) not null,				/* 글 올린이 IP */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  good		int default 0,							/* '좋아요' 클릭 횟수 누적 */
  complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO) */
  listImg		varchar(100) default 'noimage.jpg',			/* 업로드시의 화일명(리스트이미지) */
  listImgfSName   varchar(100), 			/* 실제 서버에 저장되는 파일명(리스트이미지) */
  fName		varchar(200),								/* 업로드시의 화일명(본문삽입이미지) */
  fSName   varchar(200), 							/* 실제 서버에 저장되는 파일명(본문삽입이미지) */
  openSw char(2) default 'OK',				/* 게시글 공개여부(OK:공개, NO:비공개) */
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(mid) references member(mid)
);

/* 댓글 달기 */
create table boardReply (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  bName			varchar(20) not null,		/* 어떤 게시판의 댓글인지.. */
  boardIdx  int not null,						/* 원본글(부모글)의 고유번호 */
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  nickName	varchar(20) not null,		/* 댓글 올린이의 닉네임 */
  wDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  hostIp		varchar(50) not null,		/* 댓글 올린 PC의 고유 IP */
  content		text not null,					/* 댓글 내용 */
  primary key(idx),
  foreign key(mid) references member(mid)
);
desc boardReply;

insert into boardReply values (default, 33, 'kms1234', '김장미', default, '192.168.50.12','글을 참조 했습니다.');
insert into boardReply values (default, 32, 'kms1234', '김장미', default, '192.168.50.12','다녀갑니다.');
insert into boardReply values (default, 34, 'kms1234', '김장미', default, '192.168.50.12','멋진글이군요...');

select * from boardReply;

select * from board;
select * from board where idx = 9;  /* 현재글 */
select idx,title from board where idx > 9 order by idx limit 1;  /* 다음글 */
select idx,title from board where idx < 9 order by idx desc limit 1;  /* 이전글 */

-- 시간으로 비교해서 필드에 값 저장하기
select *, timestampdiff(hour, wDate, now()) as hour_diff from board;

-- 날짜로 비교해서 필드에 값 저장하기
select *, datediff(wDate, now()) as date_diff from board;

-- 관리자는 모든글 보여주고, 일반사용자는 비공개글(openSw='NO')과 신고글(complaint='OK')은 볼수없다. 단, 자신이 작성한 글은 볼수 있다.
select count(*) as cnt from board;
select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO';
select count(*) as cnt from board where mid = 'hkd1234';

select * from board where openSW = 'OK' and complaint = 'NO';
select * from board where mid = 'hkd1234';
select * from board where openSW = 'OK' and complaint = 'NO' union select * from board where mid = 'hkd1234';
select * from board where openSW = 'OK' and complaint = 'NO' union all select * from board where mid = 'hkd1234';

select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234';
select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234') as a;

select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234' and (openSW = 'NO' or complaint = 'OK')) as a;

/* 댓글수 연습 */
select * from board order by idx desc;
select * from boardReply order by boardIdx, idx desc;

-- 부모글(33)의 댓글만 출력
select * from boardReply where boardIdx = 33;
select boardIdx,count(*) as replyCnt from boardReply where boardIdx = 33;

select * from board where idx = 33;
select *,(select count(*) from boardReply where boardIdx = 33) as replyCnt from board where idx = 33;
select *,(select count(*) from boardReply where boardIdx = b.idx) as replyCnt from board b;



/*  view  /  index 파일 연습 */
select * from board where mid = 'admin';

create view adminView as select * from board where mid = 'admin';

select * from adminView;

show tables;

show full tables in javaclass where table_type like 'view';

drop view adminview;

desc board;

create index nickNameIndex on board(nickName);

show index from board;

alter table board drop index nickNameIndex;


/* 신고테이블(complaint) */
create table complaint(
  idx  int not null auto_increment,	/* 신고테이블 고유번호 */
  part varchar(15) not null,				/* 신고 분류(게시판:board, 자료실:pds, 방명록:guest) */
  partIdx int not null,							/* 신고분류항목 글의 고유번호 */
  cpMid varchar(20) not null,				/* 신고자 아이디 */
  cpContent text not null,					/* 신고 사유 */
  cpDate datetime default now(),		/* 신고한 날짜 */
  primary key(idx)
);
desc complaint;

insert into complaint values (default, 'board', 24, 'hkd1234', '광고성 글', default);

select * from complaint;

select c.*, b.title, b.nickName, b.mid from complaint c, board b where c.partIdx = b.idx;

select c.*, b.title as title, b.nickName as nickName, b.mid as mid from complaint c, board b where c.partIdx = b.idx;

select c.*, date_format(c.cpDate, '%Y-%m-%d %H:%i') as cpDate, b.title as title, b.nickName as nickName, b.mid as mid from complaint c, board b where c.partIdx = b.idx;


/* 리뷰 테이블 */
create table review(
  idx   int not null auto_increment,  /* 리뷰 고유번호 */
  part  varchar(20) not null,					/* 분야(게시판:board, 자료실:pds....) */
  partIdx  int not null,							/* 해당 분야의 고유번호 */
  mid			 varchar(20) not null,			/* 리뷰 올린이 */
  nickName varchar(20) not null,			/* 리뷰 올린이 닉네임 */
  star     int not null default 0,		/* 별점 부여 점수 */
  content	 text,											/* 리뷰 내용 */
  rDate		 datetime default now(),		/* 리뷰 등록일자 */
  primary key(idx),
  foreign key(mid) references member(mid)
);
desc review;

/* 리뷰에 댓글 달기 */
create table reviewReply(
  replyIdx    		int not null auto_increment,/* 댓글의 고유번호 */
  reviewIdx	int not null,								/* 원본글(부모글:리뷰)의 고유번호(외래키로 설정) */
  replyMid			varchar(20) not null,		/* 댓글 올린이의 아이디 */
  replyNickName	varchar(20) not null,		/* 댓글 올린이의 닉네임 */
  replyRDate		datetime default now(),	/* 댓글 올린 날짜 */
  replyContent	text not null,					/* 댓글 내용 */
  primary key(replyIdx),
  foreign key(reviewIdx) references review(idx),
  foreign key(replyMid) references member(mid)
);
desc reviewReply;
drop table reviewReply;

select * from review order by idx desc;
select * from review where partIdx=14;

select * from reviewReply order by replyIdx desc;

select * from review v, reviewReply r where v.partIdx=14 and v.idx=r.reviewIdx;
select * from review v, reviewReply r where v.partIdx=14 and v.idx=r.reviewIdx order by v.idx desc, r.replyIdx desc;
select * from review v left join reviewReply r on v.partIdx=14 and v.idx=r.reviewIdx order by v.idx desc, r.replyIdx desc;
select * from (select * from review where partIdx=14) as v left join reviewReply r on v.partIdx=14 and v.idx=r.reviewIdx order by v.idx desc, r.replyIdx desc;