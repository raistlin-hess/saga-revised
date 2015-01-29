-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 398;
local ReqClv = 1;
local ReqJlv = 0;
local NextQuest = 399;
local RewZeny = 7;
local RewCxp = 9;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 51500002;
local RewItem2 = 0;
local RewItemCount1 = 5;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points

	Saga.AddStep(cid, QuestID, 39801);
	Saga.AddStep(cid, QuestID, 39802);
	Saga.AddStep(cid, QuestID, 39803);
	Saga.InsertQuest(cid, QuestID, 1);

	return 0;
end

function QUEST_FINISH(cid)
	-- Handout all rewards

	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.InsertQuest(cid, NextQuest, 1 );
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Add all waypoints
	Saga.AddWaypoint(cid, QuestID, 39801, 1, 1146);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1146 then
		Saga.GeneralDialog(cid, 3933);
		Saga.SubstepComplete(cid, QuestID, 39801, 1);
	end
	
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,39801, i) == false then
			return -1;
		 end
    end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 39801);
	return 0;
end

function QUEST_STEP_2(cid)
     -- Capture a Unripe Pukui
     Saga.FindQuestItem(cid, QuestID, 39802, 10000, 2666 , 8000, 1, 1);
     Saga.FindQuestItem(cid, QuestID, 39802, 10001, 2666 , 8000, 1, 1);
	
     -- Check if all substeps are completed
     for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,39802, i) == false then
			return -1;
		 end
     end
	
	 Saga.StepComplete(cid, QuestID, 39802);
     return 0;
end

function QUEST_STEP_3(cid)
	-- Deliver Unripe Pukui to Sally
	Saga.AddWaypoint(cid, QuestID, 39803, 1, 1147);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1147 then
		Saga.NpcTakeItem(cid, 2666, 1 );
		Saga.GeneralDialog(cid, 3933);
		Saga.SubstepComplete(cid, QuestID, 39803, 1);
	end
	
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,39803, i) == false then
			return -1;
		 end
    end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 39803);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end


function QUEST_CHECK(cid)
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 39801 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 39802 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 39803 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid)
	end

	return ret;
end
