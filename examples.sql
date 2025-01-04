select *
from comments c
-- where userid = ##userid?10141885##
where userid = 10141885
-- any posthistory happened after the comment was created
and exists (
  select *
  from posthistory ph
  where ph.postid = c.postid
  and ph.creationdate > c.creationdate)


-- years:years ago
select p.id as [Post Link]
     , choose(p.posttypeid, 'Q','A') [Q/A]
     , p.score
     , p.creationdate
     , q.viewcount
from posts p
inner join posts q on q.id = coalesce(p.parentid, p.id)
-- where p.owneruserid = ##userid?10141885##
where p.owneruserid = 10141885
-- and p.creationdate < dateadd(y,-##years?1##,GetDate())
and p.creationdate < dateadd(y,-1,GetDate())
and (
  (p.posttypeid = 1 and p.score < 1 )
or
  (p.posttypeid = 2 and p.score < 2 and p.id <> q.acceptedanswerid)
)
order by creationdate


-- years:years ago
select p.id as [Post Link]
     , choose(p.posttypeid, 'Q','A') [Q/A]
     , p.score
     , p.creationdate
     , q.viewcount
from posts p
inner join posts q on q.id = coalesce(p.parentid, p.id)
-- where p.owneruserid = ##userid?10141885##
where p.owneruserid = 10141885
-- and p.creationdate < dateadd(y,-##years?1##,GetDate())
and p.creationdate < dateadd(y,-1,GetDate())
and (
  (p.posttypeid = 1 and p.score < 1 )
or
  (p.posttypeid = 2 and p.score < 2 and p.id <> q.acceptedanswerid)
)
order by creationdate