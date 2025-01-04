-- Source:
-- https://github.com/leerssej/SEDESchema/blob/master/info_schema_create_tables.sql

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_PostTypes FOREIGN KEY ( PostTypeId ) 
REFERENCES PostTypes( Id ) ;

ALTER TABLE PostHistory 
ADD CONSTRAINT Fk_PostHistory_PostHistoryTypes FOREIGN KEY ( PostHistoryTypeId ) 
REFERENCES PostHistoryTypes( Id ) ;

ALTER TABLE PostHistory 
ADD CONSTRAINT Fk_PostHistory_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostHistory 
ADD CONSTRAINT Fk_PostHistory_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Votes 
ADD CONSTRAINT Fk_Votes_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Votes 
ADD CONSTRAINT Fk_Votes_VoteTypes FOREIGN KEY ( VoteTypeId ) 
REFERENCES VoteTypes( Id ) ;

ALTER TABLE Votes 
ADD CONSTRAINT Fk_Votes_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Badges 
ADD CONSTRAINT Fk_Badges_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Comments 
ADD CONSTRAINT Fk_Comments_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Comments 
ADD CONSTRAINT Fk_Comments_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostFeedback 
ADD CONSTRAINT Fk_PostFeedback_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostFeedback 
ADD CONSTRAINT Fk_PostFeedback_VoteTypes FOREIGN KEY ( VoteTypeId ) 
REFERENCES VoteTypes( Id ) ;

ALTER TABLE SuggestedEdits 
ADD CONSTRAINT Fk_SuggestedEdits_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_SuggestedEdits FOREIGN KEY ( SuggestedEditId ) 
REFERENCES SuggestedEdits( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_VoteTypes FOREIGN KEY ( VoteTypeId ) 
REFERENCES VoteTypes( Id ) ;

ALTER TABLE PostLinks 
ADD CONSTRAINT Fk_PostLinks_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_FlagTypes FOREIGN KEY ( FlagTypeId ) 
REFERENCES FlagTypes( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_CloseReasonTypes FOREIGN KEY ( CloseReasonTypeId ) 
REFERENCES CloseReasonTypes( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_CloseAsOffTopicReasonTypes FOREIGN KEY ( CloseAsOffTopicReasonTypeId ) 
REFERENCES CloseAsOffTopicReasonTypes( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_ReviewTaskTypes FOREIGN KEY ( ReviewTaskTypeId ) 
REFERENCES ReviewTaskTypes( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_ReviewTaskStates FOREIGN KEY ( ReviewTaskStateId ) 
REFERENCES ReviewTaskStates( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_SuggestedEdits FOREIGN KEY ( SuggestedEditId ) 
REFERENCES SuggestedEdits( Id ) ;

ALTER TABLE ReviewTaskResults 
ADD CONSTRAINT Fk_ReviewTaskResults_ReviewTasks FOREIGN KEY ( ReviewTaskId ) 
REFERENCES ReviewTasks( Id ) ;

ALTER TABLE ReviewTaskResults 
ADD CONSTRAINT Fk_ReviewTaskResults_ReviewTaskResultTypes FOREIGN KEY ( ReviewTaskResultTypeId ) 
REFERENCES ReviewTaskResultTypes( Id ) ;

ALTER TABLE ReviewRejectionReasons 
ADD CONSTRAINT Fk_ReviewRejectionReasons_PostTypes FOREIGN KEY ( PostTypeId ) 
REFERENCES PostTypes( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_PostNoticeTypes FOREIGN KEY ( PostNoticeTypeId ) 
REFERENCES PostNoticeTypes( Id ) ;

ALTER TABLE PostTags 
ADD CONSTRAINT Fk_PostTags_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostTags 
ADD CONSTRAINT Fk_PostTags_Tags FOREIGN KEY ( TagId ) 
REFERENCES Tags( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_PostTypes FOREIGN KEY ( PostTypeId ) 
REFERENCES PostTypes( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Users FOREIGN KEY ( LastEditorUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonyms_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonyms_Users FOREIGN KEY ( ApprovedByUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE SuggestedEdits 
ADD CONSTRAINT Fk_SuggestedEdits_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_Users FOREIGN KEY ( TargetUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE CloseAsOffTopicReasonTypes 
ADD CONSTRAINT Fk_CloseAsOffTopicReasonTypes_Users FOREIGN KEY ( CreationModeratorId ) 
REFERENCES Users( Id ) ;

ALTER TABLE CloseAsOffTopicReasonTypes 
ADD CONSTRAINT Fk_CloseAsOffTopicReasonTypes_Users FOREIGN KEY ( ApprovalModeratorId ) 
REFERENCES Users( Id ) ;

ALTER TABLE CloseAsOffTopicReasonTypes 
ADD CONSTRAINT Fk_CloseAsOffTopicReasonTypes_Users FOREIGN KEY ( DeactivationModeratorId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_Users FOREIGN KEY ( DeletionUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Users FOREIGN KEY ( LastEditorUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Posts FOREIGN KEY ( AcceptedAnswerId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Posts FOREIGN KEY ( ParentId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostLinks 
ADD CONSTRAINT Fk_PostLinks_Posts FOREIGN KEY ( RelatedPostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_Posts FOREIGN KEY ( DuplicateOfQuestionId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Tags 
ADD CONSTRAINT Fk_Tags_Posts FOREIGN KEY ( ExcerptPostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Tags 
ADD CONSTRAINT Fk_Tags_Posts FOREIGN KEY ( WikiPostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Posts FOREIGN KEY ( AcceptedAnswerId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Posts FOREIGN KEY ( ParentId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE ReviewTaskResults 
ADD CONSTRAINT Fk_ReviewTaskResults_ReviewRejectionReasons FOREIGN KEY ( RejectionReasonId ) 
REFERENCES ReviewRejectionReasons( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_CompletedByReviewTaskId FOREIGN KEY ( CompletedByReviewTaskId ) 
REFERENCES ReviewTaskResults( Id ) ;

ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonymsSourceTagName_Tags FOREIGN KEY ( SourceTagName ) 
REFERENCES Tags( TagName ) ;
ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonymsTargetTagName_Tags FOREIGN KEY ( TargetTagName ) 
REFERENCES Tags( TagName ) ;

