show tables;

/* 댓글 달기 */
create table movieReply (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  movie_id			varchar(10) not null,		/* 어떤 영화의 댓글인지.. */
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  nickName	varchar(20) not null,		/* 댓글 올린이의 닉네임 */
  star     int not null default 0,		/* 별점 부여 점수 */
  rDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  hostIp		varchar(50) not null,		/* 댓글 올린 PC의 고유 IP */
  content		text not null,					/* 댓글 내용 */
  primary key(idx),
  foreign key(mid) references member(mid)
);
desc movieReply;

insert into movieReply values (default, '748783', 'admin', '아톰맨', default, default, '192.168.50.70','댓글 테스트');

select * from movieReply;

select movieReply.*, member.photo from movieReply left join member on movieReply.mid = member.mid;