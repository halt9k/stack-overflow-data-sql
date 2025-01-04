ALTER TABLE badges
	ADD FOREIGN KEY (UserId) REFERENCES users(Id);
    
ALTER TABLE posts
  	ADD FOREIGN KEY (PostTypeId) REFERENCES post_types(Id),
  	ADD FOREIGN KEY (OwnerUserId) REFERENCES users(Id),
  	ADD FOREIGN KEY (LastEditorUserId) REFERENCES users(Id);

SET SQL_SAFE_UPDATES = 0;
DELETE c FROM comments c LEFT JOIN users u ON c.UserId=u.Id WHERE u.Id IS NULL;
SET SQL_SAFE_UPDATES = 1;

-- Couldn't execute the below query. Error code: 1206 - tried updating "innodb_buffer_pool_size = 999M"
-- in C:\ProgramData\MySQL\MySQL Server 8.0\my.ini - still no good.  
-- ALTER TABLE comments ADD FOREIGN KEY (PostId) REFERENCES posts(Id);

ALTER TABLE comments  ADD FOREIGN KEY (UserId) REFERENCES users(Id);

-- Error Code: 1206
-- SET SQL_SAFE_UPDATES = 0;
-- DELETE v FROM votes AS v LEFT JOIN posts AS p ON v.PostId=p.Id WHERE p.Id IS NULL;
-- SET SQL_SAFE_UPDATES = 1;

-- Error Code: 1452
-- ALTER TABLE votes ADD FOREIGN KEY (PostId) REFERENCES posts(Id);

ALTER TABLE votes ADD FOREIGN KEY (VoteTypeId) REFERENCES vote_types(Id);
  
-- -- Create Views

CREATE OR REPLACE VIEW Questions AS SELECT * FROM posts WHERE PostTypeId = 1;
CREATE OR REPLACE VIEW Answers AS SELECT * FROM posts WHERE PostTypeId = 2;

-- SELECT * FROM Questions;
-- SELECT COUNT(*) FROM Questions;
-- SELECT COUNT(*) FROM Answers;

-- -- Create Indexes

CREATE INDEX comments_idx_1 ON comments(PostId);
CREATE INDEX comments_idx_2 ON comments(UserId);

CREATE INDEX posts_idx_1 ON posts(AcceptedAnswerId);
CREATE INDEX posts_idx_2 ON posts(ParentId);
CREATE INDEX posts_idx_3 ON posts(OwnerUserId);
CREATE INDEX posts_idx_4 ON posts(LastEditorUserId);
CREATE INDEX posts_idx_5 ON posts(Tags);
CREATE INDEX posts_idx_6 ON posts(PostTypeId);

CREATE INDEX votes_idx_1 ON votes(PostId);




-- -- REFERENCES

-- https://meta.stackexchange.com/questions/2677/database-schema-documentation-for-the-public-data-dump-and-sede/2678#2678
