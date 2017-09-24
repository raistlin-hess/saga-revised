-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 387;
local ReqClv = 20;
local ReqJlv = 0;
local NextQuest = 388;
local RewZeny = 859;
local RewCxp = 1950;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 0;
local RewItem2 = 0;
local RewItemCount1 = 0;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 38701);
	Saga.AddStep(cid, QuestID, 38702);
	Saga.AddStep(cid, QuestID, 38703);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.InsertQuest(cid, NextQuest, 1);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk with Monika Reynolds
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1012);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1012 then
		Saga.GeneralDialog(cid, 3831);

		local freeslots = Saga.FreeInventoryCount(cid, 0);
		if freeslots > 0 then
			Saga.NpcGiveItem(cid, 4085, 1);
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
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Deliver 'Agreement' to Pelshia Hiltrud
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1013);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1013 then
		Saga.GeneralDialog(cid, 3834);
	
		local freeslots = Saga.FreeInventoryCount(cid, 0);
		local ItemCountA = Saga.CheckUserInventory(cid, 4085);
		if ItemCountA > 0 and freeslots > 0 then
			Saga.NpcTakeItem(cid, 4085, 1);
			Saga.NpcGiveItem(cid, 4086, 1);
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
	return 0;
end

function QUEST_STEP_3(cid, StepID)
	-- Deliver 'Box' to Volker Stanwood
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1009);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1009 then
		Saga.GeneralDialog(cid, 3837);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4086);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 4086, 1);
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

	if CurStepID == 38701 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 38702 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 38703 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
