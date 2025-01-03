select
    p.Id AS [Post Link],
    p.PostTypeId,
    p.CreationDate,
    p.Score,
    p.OwnerUserId
from
    comments c
    -- Posts p
where userid = ##userid?10141885##
and exists (
    select
        *
    from
        posthistory ph
    where
        ph.postid = c.postid
    and
        ph.creationdate > c.creationdate)
    Posts p
WHERE
  p.Score = 0
  AND p.CreationDate < DATEADD(YEAR, -2, GETDATE())
ORDER BY
  p.CreationDate;
