-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:17 PM

local QuestID = 268;
local ReqClv = 17;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 567;
local RewCxp = 1425;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 1;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	-- Initialize all quest steps
	Saga.AddStep(cid, QuestID, 26801);
	Saga.AddStep(cid, QuestID, 26802);

	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	--Talk with Naihong
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1156);

	--Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1156 then
		Saga.GeneralDialog(cid, 3455);
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
	--Bring Cat Gang Plans Monika Reynolds

	--Make Cat Gang Plans Drop
	Saga.FindQuestItem(cid, QuestID, StepID, 10104, 4036, 2500, 1, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10105, 4036, 2500, 1, 1);

	--Take to Monika Reynolds
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1012);

	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1012 then
		Saga.GeneralDialog(cid, 3458);
		local ItemCountA = Saga.CheckUserInventory(cid, 4036);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 4036, 1);
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

	if CurStepID == 26801 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 26802 then
		ret = QUEST_STEP_2(cid, StepID);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end
