CREATE DATABASE stats DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- DROP DATABASE stats;

USE stats;

DROP TABLE IF EXISTS badges;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS post_history;
DROP TABLE IF EXISTS post_links;
DROP TABLE IF EXISTS post_types;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS vote_types;
DROP TABLE IF EXISTS votes;

-- Badges
CREATE TABLE badges (
	Id INT NOT NULL PRIMARY KEY,
	UserId INT,
	Name VARCHAR(50),
	Date DATETIME
);

-- Comments
CREATE TABLE comments (
	Id INT NOT NULL PRIMARY KEY,
    	PostId INT NOT NULL,
    	Score INT NOT NULL DEFAULT 0,   -- number of upvotes - number of downvotes
    	Text TEXT,
    	CreationDate DATETIME,
    	UserId INT NOT NULL
);

-- Post History
CREATE TABLE post_history (
	Id INT NOT NULL PRIMARY KEY,
    	PostHistoryTypeId SMALLINT NOT NULL,
    	PostId INT NOT NULL,
    	RevisionGUID VARCHAR(36),
    	CreationDate DATETIME,
    	UserId INT NOT NULL,
    	Text TEXT
);

-- Post Links
CREATE TABLE post_links (
	Id INT NOT NULL PRIMARY KEY,
    	CreationDate DATETIME DEFAULT NULL,
    	PostId INT NOT NULL,
    	RelatedPostId INT NOT NULL,
    	LinkTypeId INT DEFAULT NULL
);

-- Post Types
CREATE TABLE post_types (
	Id SMALLINT NOT NULL PRIMARY KEY,
    	Description VARCHAR(32) NOT NULL
);

INSERT INTO post_types (Id, Description) VALUES
  (1, 'Question'),
  (2, 'Answer'),
  (3, 'Wiki'),
  (4, 'Tag Wiki Excerpt'),
  (5, 'Tag Wiki'),
  (6, 'Moderator Nomination'),
  (7, 'Wiki Placeholder'),
  (8, 'Privilege Wiki');

-- Posts
CREATE TABLE posts (
    Id INT NOT NULL PRIMARY KEY,
    PostTypeId SMALLINT,    -- 1 = Question; 2 = Answer
    AcceptedAnswerId INT,   -- only present if PostTypeId = 1
    ParentId INT,           -- only present if PostTypeId = 2
    Score INT NULL,
    ViewCount INT NULL,
    Body text NULL,
    OwnerUserId INT DEFAULT 0,
    OwnerDisplayName varchar(256),
    LastEditorUserId INT,
    LastEditDate DATETIME,
    LastActivityDate DATETIME,
    Title varchar(256) NULL,
    Tags VARCHAR(256),
    AnswerCount INT DEFAULT 0,
    CommentCount INT DEFAULT 0,
    FavoriteCount INT DEFAULT 0,
    CreationDate DATETIME
);

-- Tags
CREATE TABLE tags (
  Id INT NOT NULL PRIMARY KEY,
  TagName VARCHAR(50) CHARACTER SET latin1 DEFAULT NULL,
  Count INT DEFAULT NULL,
  ExcerptPostId INT DEFAULT NULL,
  WikiPostId INT DEFAULT NULL
);

-- Users
CREATE TABLE users (
    Id INT NOT NULL PRIMARY KEY,
    Reputation INT NOT NULL,
    CreationDate DATETIME,
    DisplayName VARCHAR(50) NULL,
    LastAccessDate DATETIME,
    Views INT DEFAULT 0,
    WebsiteUrl VARCHAR(256) NULL,
    Location VARCHAR(256) NULL,
    AboutMe TEXT NULL,
    UpVotes INT,
    DownVotes INT,
    AccountId INT
);

-- Vote Types
CREATE TABLE vote_types (
  	Id SMALLINT NOT NULL PRIMARY KEY,
  	Description VARCHAR(32) NOT NULL
);

INSERT INTO vote_types (Id, Description) VALUES
  (1, 'AcceptedByOriginator'),
  (2, 'UpMod'),
  (3, 'DownMod'),
  (4, 'Offensive'),
  (5, 'Favorite'),
  (6, 'Close'),
  (7, 'Reopen'),
  (8, 'BountyStart'),
  (9, 'BountyClose'),
  (10, 'Deletion'),
  (11, 'Undeletion'),
  (12, 'Spam'),
  (15, 'ModeratorReview'),
  (16, 'ApproveEditSuggestion');

-- Votes
CREATE TABLE votes (
    Id INT NOT NULL PRIMARY KEY,
    PostId INT NOT NULL,
    VoteTypeId SMALLINT,
    CreationDate DATETIME
);

-- SHOW VARIABLES LIKE "local_infile";

-- SET GLOBAL local_infile = 'ON';

-- SHOW VARIABLES LIKE "secure_file_priv";

-- Load Badges data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/Badges.xml' 
-- INTO TABLE badges
-- rows identified by '<row>';

-- SELECT * FROM badges;

-- Load Comments data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/Comments.xml' 
-- INTO TABLE comments
-- rows identified by '<row>';

-- SELECT * FROM comments;
-- SELECT COUNT(*) FROM comments;

-- Load Post History data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/PostHistory.xml' 
-- INTO TABLE post_history
-- rows identified by '<row>';

-- SELECT * FROM post_history;
-- SELECT COUNT(*) FROM post_history;

-- Load Post Links data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/PostLinks.xml' 
-- INTO TABLE post_links
-- rows identified by '<row>';

-- SELECT * FROM post_links;

-- Load Posts data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/Posts.xml'
-- INTO TABLE posts
-- rows identified by '<row>';

-- SELECT * FROM posts;
-- SELECT COUNT(*) FROM posts;

-- Load Tags data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/Tags.xml' 
-- INTO TABLE tags
-- rows identified by '<row>';

-- SELECT * FROM tags;

-- Load Users data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/Users.xml' 
-- INTO TABLE users
-- rows identified by '<row>';

-- SELECT * FROM users;

-- Load Votes data
-- LOAD XML LOCAL INFILE 'd:\MIR\GitRepos\local\SQL/stats.stackexchange.com/Votes.xml' 
-- INTO TABLE votes
-- rows identified by '<row>';

-- SELECT * FROM votes;
-- SELECT COUNT(*) FROM votes;