-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 425;
local ReqClv = 30;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1726;
local RewCxp = 6958;
local RewJxp = 2783;
local RewWxp = 0;
local RewItem1 = 1700115;
local RewItem2 = 0;
local RewItemCount1 = 1;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 42501);
	Saga.AddStep(cid, QuestID, 42502);
	Saga.AddStep(cid, QuestID, 42503);
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
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Collect Blut Runner's Foot (6)
	Saga.FindQuestItem(cid,QuestID,StepID,10345,4235,8000,6,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10346,4235,8000,6,1);
	
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false then
			return -1;
		 end
    end
	
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_3(cid)
    -- Hand in to Kafra Board Mailbox
    local ret = Saga.GetActionObjectIndex(cid);
    if ret == 1123 then
        local ItemCountA = Saga.CheckUserInventory(cid, 4235);
        if ItemCountA > 5 then
            Saga.NpcTakeItem(cid, 4235, 1);
            Saga.SubstepComplete(cid, QuestID, StepID, 6);
        else
			Saga.InventoryNotFound(cid);
        end
    end
	
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
            return -1;
         end
    end
	
    Saga.StepComplete(cid, QuestID, StepID);
    Saga.ClearWaypoints(cid, QuestID);
    Saga.QuestComplete(cid, QuestID);
    return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 42501 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 42502 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 42503 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
