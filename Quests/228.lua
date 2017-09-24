-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:16 PM

local QuestID = 228;
local ReqClv = 13;
local ReqJlv = 0;
local NextQuest = 229;
local RewZeny = 493;
local RewCxp = 1035;
local RewJxp = 423;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 12;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 22801);
	Saga.AddStep(cid, QuestID, 22802);
	Saga.AddStep(cid, QuestID, 22803);
	Saga.AddStep(cid, QuestID, 22804);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk with Sophie
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1151);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1151 then
		Saga.GeneralDialog(cid, 2596);
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
	-- Report to Monika Reynolds
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1012);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1012 then
		Saga.GeneralDialog(cid, 2599);
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
	return 0;
end

function QUEST_STEP_3(cid, StepID)
  	-- Collect Potemkin's Sample (1)
	Saga.FindQuestItem(cid, QuestID, StepID, 10116, 4018, 8000, 1, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10117, 4018, 8000, 1, 1);
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_4(cid, StepID)
	-- Report to Monika Reynolds
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1012);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1012 then
		Saga.GeneralDialog(cid, 2602);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4018);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 4018, 1);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
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

	if CurStepID == 22801 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 22802 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 22803 then
		ret = QUEST_STEP_3(cid, StepID);
	elseif CurStepID == 22804 then
		ret = QUEST_STEP_4(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
