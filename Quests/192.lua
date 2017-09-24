-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 192;
local ReqClv = 13;
local ReqJlv = 0;
local NextQuest = 193;
local RewZeny = 232;
local RewCxp = 777;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 19201);
	Saga.AddStep(cid, QuestID, 19202);
	Saga.AddStep(cid, QuestID, 19203);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.InsertQuest(cid, NextQuest, 1);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk with Sabena Denton
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1082);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1082 then
		Saga.GeneralDialog(cid, 3006);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Eliminate Weeds (5)
	Saga.Eliminate(cid, QuestID, StepID, 4, 5, 1);
	
	-- (De-)Activates the Action Objectd on request
	if Saga.IsSubStepCompleted(cid, QuestID, StepID, 1) == false then
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 4, 0);
	else
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 4, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid, StepID)
	-- Talk with Sabena Denton
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1082);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1082 then
		Saga.GeneralDialog(cid, 3009);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local StepID = CurStepID;
	local ret = -1;

	if CurStepID == 19201 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 19202 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 19203 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
