-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 380;
local ReqClv = 18;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 740;
local RewCxp = 2580;
local RewJxp = 1032;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 38001);
	Saga.AddStep(cid, QuestID, 38002);
	Saga.AddStep(cid, QuestID, 38003);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk with Pelshia Hiltrud
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1013);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1013 then
		Saga.GeneralDialog(cid, 3778);
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
	-- Search for the missing Necklace (1)
	Saga.FindQuestItem(cid, QuestID, StepID, 10131, 2790, 10000, 1, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10132, 2790, 10000, 1, 1);
	
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
	-- Deliver Necklace to Pelshia Hiltrud (1)
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1013);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1013 then
		Saga.GeneralDialog(cid, 3781);

		local ItemCountA = Saga.CheckUserInventory(cid, 2790);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 2790, 10);
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

	if CurStepID == 38001 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 38002 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 38003 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
