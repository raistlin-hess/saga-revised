-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 27;
local ReqClv = 7;
local ReqJlv = 0;
local NextQuest = 148;
local RewZeny = 154;
local RewCxp = 328;
local RewJxp = 128;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 4;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 2701);
	Saga.AddStep(cid, QuestID, 2702);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 0 then
		Saga.GiveZeny(RewZeny);
		Saga.GiveExp( RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1 );
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
    --Find Hodemimes Blue Shark's eye
	Saga.FindQuestItem(cid,QuestID,StepID,10054,2656,8000,2,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10055,2656,8000,2,1);

    -- check if substeps are completed
	for i = 1, 1 do
	    if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
	        return -1;
	    end
    end
	
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_2(cid)
    --Deliver Shark's Eye Averro Reinhold
	Saga.AddWaypoint(cid, QuestID, 2702, 1, 1004);

    --check for completion
	local ret = Saga.GetNPCIndex(cid);
	local ItemCount = Saga.CheckUserInventory(cid, 2656);
	if ret == 1004 then
	    Saga.GeneralDialog(cid, 3936);
	    if Itemcount > 1 then
	        Saga.NpcTakeItem(cid, 3936, 2);
	        Saga.SubstepComplete(cid,QuestID,StepID,1);
	    end
    end
	
    --check if all substeps are completed
	for i = 1, 1 do
	    if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
	        return -1;
	    end
    end
	
	Saga.StepComplete(cid,QuestID,StepID);
	Saga.ClearWaypoints(cid, QuestID);
	Sage.QuestComplete(cid, QuestID);
	return -1;
end

	

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 2701 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 2702 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end

	
