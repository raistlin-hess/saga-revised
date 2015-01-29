-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 35;
local ReqClv = 4;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 60;
local RewCxp = 108;
local RewJxp = 42;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points
	Saga.AddStep(cid, QuestID, 3501);
	Saga.AddStep(cid, QuestID, 3502);
	Saga.AddStep(cid, QuestID, 3503);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	Saga.GiveZeny(RewZeny);
	Saga.GiveExp(RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk to zarko
	Saga.AddWaypoint(cid, QuestID, 3501, 1, 1004);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1004 then
		local freeslots = Saga.FreeInventoryCount(cid, 0);
        if freeslots > 0 then
			Saga.NpcGiveItem(cid, 2609, 1);
			Saga.SubstepComplete(cid, QuestID, 3501, 1);
		end
	end
	
    -- Check if all substeps are completed
	if Saga.IsSubStepCompleted(cid,QuestID,3501, 1) == false then
		return -1;
	end
	
    Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 3501);
end

function QUEST_STEP_2(cid)
	-- Get 5 Vadon Loot
	Saga.FindQuestItem(cid, QuestID, 3501, 10017, 2610, 10000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, 3501, 10018, 2610, 10000, 5, 1);
	
    -- Check if all substeps are completed
         if Saga.IsSubStepCompleted(cid,QuestID,3501, 1) == false then
			return -1;
		 end
	
	Saga.StepComplete(cid, QuestID, 3501);
end

function QUEST_STEP_3(cid)
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1123 then
		Saga.NpcTakeItem(cid, 2610, 5);
		Saga.SubstepComplete(cid, QuestID, 3503, 1);
	end
	
    -- Check if all substeps are completed
     if Saga.IsSubStepCompleted(cid,QuestID,3503, 1) == false then
		return -1;
	 end
	
    Saga.StepComplete(cid, QuestID, 3503);
    Saga.QuestComplete(cid, QuestID);
	return 0;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid);
	local ret = -1;

	if CurStepID == 3501 then
		ret = QUEST_STEP_1();
	elseif CurStepID == 3502 then
		ret = QUEST_STEP_2();
	elseif CurStepID == 3503 then
		ret = QUEST_STEP_3();
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return -1;
end
