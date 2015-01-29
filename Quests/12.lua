-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 12;
local ReqClv = 3;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 26;
local RewCxp = 65;
local RewJxp = 25;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 2662;
local RewItemCount1 = 2;
local RewItemCount2 = 5;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 1201);
	Saga.AddStep(cid, QuestID, 1202);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1 );
		Saga.GiveItem(cid, RewItem2, RewItemCount2 );
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)

	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk to mischa
	Saga.AddWaypoint(cid, QuestID, 1201, 1, 1004);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1004 then
		Saga.GeneralDialog(cid, 28);
		Saga.SubstepComplete(cid,QuestID,1201,1);
		Saga.NpcGiveItem(cid, 2661, 5);
	end
	
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,1201,i) == false then
			return -1;
		 end
    end
	
    Saga.ClearWaypoints(cid, QuestID);
    Saga.StepComplete(cid,QuestID,1201);
    return 0;
end

function QUEST_STEP_2(cid)
	-- Talk to mischa
	Saga.AddWaypoint(cid, QuestID, 1202, 1, 1003);
	Saga.AddWaypoint(cid, QuestID, 1202, 2, 1000);
	Saga.AddWaypoint(cid, QuestID, 1202, 3, 1005);
	Saga.AddWaypoint(cid, QuestID, 1202, 4, 1002);
	Saga.AddWaypoint(cid, QuestID, 1202, 5, 1001);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1003 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid,QuestID,1202,1);
		Saga.NpcTakeItem(cid, 2661, 1);
	elseif ret == 1000 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid,QuestID,1202,2);
		Saga.NpcTakeItem(cid, 2661, 1);
	elseif ret == 1005 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid,QuestID,1202,3);
		Saga.NpcTakeItem(cid, 2661, 1);
	elseif ret == 1002 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid,QuestID,1202,4);
		Saga.NpcTakeItem(cid, 2661, 1);
	elseif ret == 1001 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid,QuestID,1202,5);
		Saga.NpcTakeItem(cid, 2661, 1);
	else
	return -1;
	end
	
    -- Check if all substeps are completed
    for i = 1, 5 do
         if Saga.IsSubStepCompleted(cid,QuestID,1202,i) == false then
			return -1;
		 end
    end
	
    Saga.ClearWaypoints(cid, QuestID);
    Saga.StepComplete(cid,QuestID,1202);
	Saga.QuestComplete(cid, QuestID);
    return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 1201 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 1202 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
