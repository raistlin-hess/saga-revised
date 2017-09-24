-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:16 PM

local QuestID = 225;
local ReqClv = 14;
local ReqJlv = 0;
local NextQuest = 226;
local RewZeny = 536;
local RewCxp = 1215;
local RewJxp = 477;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 13;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 22501);
	Saga.AddStep(cid, QuestID, 22502);
	Saga.AddStep(cid, QuestID, 22503);
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
	-- Talk with Regina Salisbury
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1010);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1010 then
		Saga.GeneralDialog(cid, 3132);
		local freeslots = Saga.FreeInventoryCount(cid, 0);
		if freeslots > 0 then
			Saga.NpcGiveItem(cid, 4013, 1);
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
	-- Receive Pretty Flower Pelshia Hiltrud;
	-- Receive '??? ?' from Volker Stanwood;
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1013);
	Saga.AddWaypoint(cid, QuestID, StepID, 2, 1009);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1013 then
		Saga.GeneralDialog(cid, 3135);
	
		local freeslots = Saga.FreeInventoryCount(cid, 0);
		if freeslots > 0 then
			Saga.NpcGiveItem(cid, 4014, 1);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
	elseif ret == 1009 then
		Saga.GeneralDialog(cid, 3138);
	
		local freeslots = Saga.FreeInventoryCount(cid, 0);
		if freeslots > 0 then
			Saga.NpcGiveItem(cid, 4015, 1);
			Saga.SubstepComplete(cid, QuestID, StepID, 2);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 2 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid, StepID)
	-- Report to Regina Salisbury
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1010);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1010 then
		Saga.GeneralDialog(cid, 3141);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4014);
		local ItemCountB = Saga.CheckUserInventory(cid, 4015);
		if ItemCountA > 0 and ItemCountB > 0 then
			Saga.NpcTakeItem(cid, 4014, 1);
			Saga.NpcTakeItem(cid, 4015, 1);
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

	if CurStepID == 22501 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 22502 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 22503 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
