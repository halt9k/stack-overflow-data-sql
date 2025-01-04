-- Source:
-- https://github.com/leerssej/SEDESchema/blob/master/info_schema_create_tables.sql

DROP TABLE IF EXISTS Badges;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS PostHistory;
DROP TABLE IF EXISTS PostLinks;
DROP TABLE IF EXISTS PostTypes;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS VoteTypes;
DROP TABLE IF EXISTS Votes;

CREATE TABLE Badges (
	Id INT NOT NULL,
	UserId INT NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Date DATETIME NOT NULL,
	Class TINYINT NOT NULL,
	TagBased BIT NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE CloseAsOffTopicReasonTypes (
	Id SMALLINT NOT NULL,
	IsUniversal BIT NOT NULL,
	MarkdownMini NVARCHAR(500) NOT NULL,
	CreationDate DATETIME NOT NULL,
	CreationModeratorId INT NULL,
	ApprovalDate DATETIME NULL,
	ApprovalModeratorId INT NULL,
	DeactivationDate DATETIME NULL,
	DeactivationModeratorId INT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE CloseReasonTypes (
	Id TINYINT NOT NULL,
	Name NVARCHAR(200) NOT NULL,
	Description NVARCHAR(500) NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE Comments (
	Id INT NOT NULL,
	PostId INT NOT NULL,
	Score INT NOT NULL,
	Text NVARCHAR(600) NOT NULL,
	CreationDate DATETIME NOT NULL,
	UserDisplayName NVARCHAR(30) NULL,
	UserId INT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE FlagTypes (
	Id TINYINT NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(500) NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PendingFlags (
	Id INT NOT NULL,
	FlagTypeId TINYINT NOT NULL,
	PostId INT NOT NULL,
	CreationDate DATE NULL,
	CloseReasonTypeId TINYINT NULL,
	CloseAsOffTopicReasonTypeId SMALLINT NULL,
	DuplicateOfQuestionId INT NULL,
	BelongsOnBaseHostAddress NVARCHAR(100) NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PostFeedback (
	Id INT NOT NULL,
	PostId INT NOT NULL,
	IsAnonymous BIT NULL,
	VoteTypeId TINYINT NOT NULL,
	CreationDate DATETIME NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PostHistory (
	Id INT NOT NULL,
	PostHistoryTypeId TINYINT NOT NULL,
	PostId INT NOT NULL,
	RevisionGUID UNIQUEIDENTIFIER NOT NULL,
	CreationDate DATETIME NOT NULL,
	UserId INT NULL,
	UserDisplayName NVARCHAR(40) NULL,
	Comment NVARCHAR(400) NULL,
	Text NVARCHAR(800) NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PostHistoryTypes (
	Id TINYINT NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PostLinks (
	Id INT NOT NULL,
	CreationDate DATETIME NOT NULL,
	PostId INT NOT NULL,
	RelatedPostId INT NOT NULL,
	LinkTypeId TINYINT NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PostNoticeTypes (
	Id INT NOT NULL,
	ClassId TINYINT NOT NULL,
	Name NVARCHAR(80) NULL,
	Body NVARCHAR(800) NULL,
	IsHidden BIT NOT NULL,
	Predefined BIT NOT NULL,
	PostNoticeDurationId INT NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PostNotices (
	Id INT NOT NULL,
	PostId INT NOT NULL,
	PostNoticeTypeId INT NULL,
	CreationDate DATETIME NOT NULL,
	DeletionDate DATETIME NULL,
	ExpiryDate DATETIME NULL,
	Body NVARCHAR(800) NULL,
	OwnerUserId INT NULL,
	DeletionUserId INT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE PostTags (
	PostId INT NOT NULL,
	TagId INT NOT NULL,
	-- PRIMARY KEY (PostId, TagId)
    -- PRIMARY KEY (Id)
);

CREATE TABLE PostTypes (
	Id TINYINT NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE Posts (
	Id INT NOT NULL,
	PostTypeId TINYINT NOT NULL,
	AcceptedAnswerId INT NULL,
	ParentId INT NULL,
	CreationDate DATETIME NOT NULL,
	DeletionDate DATETIME NULL,
	Score INT NOT NULL,
	ViewCount INT NULL,
	Body NVARCHAR(800) NULL,
	OwnerUserId INT NULL,
	OwnerDisplayName NVARCHAR(40) NULL,
	LastEditorUserId INT NULL,
	LastEditorDisplayName NVARCHAR(40) NULL,
	LastEditDate DATETIME NULL,
	LastActivityDate DATETIME NULL,
	Title NVARCHAR(250) NULL,
	Tags NVARCHAR(250) NULL,
	AnswerCount INT NULL,
	CommentCount INT NULL,
	FavoriteCount INT NULL,
	ClosedDate DATETIME NULL,
	CommunityOwnedDate DATETIME NULL,
	PRIMARY KEY (Id)
);


CREATE TABLE PostsWithDeleted (
    Id INT NOT NULL,
    PostTypeId TINYINT NOT NULL,
    AcceptedAnswerId INT NULL,
    ParentId INT NULL,
    CreationDate DATETIME NOT NULL,
    DeletionDate DATETIME NULL,
    Score INT NOT NULL,
    ViewCount INT NULL,
    Body NVARCHAR(800) NULL,
    OwnerUserId INT NULL,
    OwnerDisplayName NVARCHAR(40) NULL,
    LastEditorUserId INT NULL,
    LastEditorDisplayName NVARCHAR(40) NULL,
    LastEditDate DATETIME NULL,
    LastActivityDate DATETIME NULL,
    Title NVARCHAR(250) NULL,
    Tags NVARCHAR(250) NULL,
    AnswerCount INT NULL,
    CommentCount INT NULL,
    FavoriteCount INT NULL,
    ClosedDate DATETIME NULL,
    CommunityOwnedDate DATETIME NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE ReviewRejectionReasons (
    Id TINYINT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    PostTypeId TINYINT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE ReviewTaskResultTypes (
    Id TINYINT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE ReviewTaskResults (
    Id INT NOT NULL,
    ReviewTaskId INT NOT NULL,
    ReviewTaskResultTypeId TINYINT NOT NULL,
    CreationDate DATE NULL,
    RejectionReasonId TINYINT NULL,
    Comment NVARCHAR(150) NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE ReviewTaskStates (
    Id TINYINT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE ReviewTaskTypes (
    Id TINYINT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE ReviewTasks (
    Id INT NOT NULL,
    ReviewTaskTypeId TINYINT NOT NULL,
    CreationDate DATE NULL,
    DeletionDate DATE NULL,
    ReviewTaskStateId TINYINT NOT NULL,
    PostId INT NOT NULL,
    SuggestedEditId INT NULL,
    CompletedByReviewTaskId INT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE SuggestedEditVotes (
    Id INT NOT NULL,
    SuggestedEditId INT NOT NULL,
    UserId INT NOT NULL,
    VoteTypeId TINYINT NOT NULL,
    CreationDate DATETIME NOT NULL,
    TargetUserId INT NULL,
    TargetRepChange INT NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE SuggestedEdits (
    Id INT NOT NULL,
    PostId INT NOT NULL,
    CreationDate DATETIME NULL,
    ApprovalDate DATETIME NULL,
    RejectionDate DATETIME NULL,
    OwnerUserId INT NULL,
    Comment NVARCHAR(800) NULL,
    Text NVARCHAR(800) NULL,
    Title NVARCHAR(250) NULL,
    Tags NVARCHAR(250) NULL,
    RevisionGUID UNIQUEIDENTIFIER NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE TagSynonyms (
    Id INT NOT NULL,
    SourceTagName NVARCHAR(35) NULL,
    TargetTagName NVARCHAR(35) NULL,
    CreationDate DATETIME NOT NULL,
    OwnerUserId INT NOT NULL,
    AutoRenameCount INT NOT NULL,
    LastAutoRename DATETIME NULL,
    Score INT NOT NULL,
    ApprovedByUserId INT NULL,
    ApprovalDate DATETIME NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Tags (
    Id INT NOT NULL,
    TagName NVARCHAR(35) NULL,
    Count INT NOT NULL,
    ExcerptPostId INT NULL,
    WikiPostId INT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Users (
    Id INT NOT NULL,
    Reputation INT NOT NULL,
    CreationDate DATETIME NOT NULL,
    DisplayName NVARCHAR(40) NULL,
    LastAccessDate DATETIME NOT NULL,
    WebsiteUrl NVARCHAR(200) NULL,
    Location NVARCHAR(100) NULL,
    AboutMe NVARCHAR(800) NULL,
    Views INT NOT NULL,
    UpVotes INT NOT NULL,
    DownVotes INT NOT NULL,
    ProfileImageUrl NVARCHAR(200) NULL,
    EmailHash VARCHAR(32) NULL,
    AccountId INT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE VoteTypes (
    Id TINYINT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Votes (
    Id INT NOT NULL,
    PostId INT NOT NULL,
    VoteTypeId TINYINT NOT NULL,
    UserId INT NULL,
    CreationDate DATETIME NULL,
    BountyAmount INT NULL,
    PRIMARY KEY (Id)
);


