-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 390;
local ReqClv = 21;
local ReqJlv = 0;
local NextQuest = 391;
local RewZeny = 927;
local RewCxp = 1218;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 6;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
    Saga.AddStep(cid, QuestID, 39001);
    Saga.AddStep(cid, QuestID, 39002);
    Saga.InsertQuest(cid, QuestID, 1);
    return 0;
end

function QUEST_FINISH(cid)
    -- Gives all rewards
    Saga.GiveItem(cid, RewItem1, RewItemCount1 );
    Saga.GiveZeny(cid, RewZeny);
    Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
    Saga.InsertQuest(cid, NextQuest, 1);
    return 0;
end

function QUEST_CANCEL(cid)
    return 0;
end

function QUEST_STEP_1(cid)
    Saga.StepComplete(cid, QuestID, StepID);
    return 0;
end

function QUEST_STEP_2(cid)
    -- Visit Heinrich
    Saga.AddWaypoint(cid, QuestID, StepID, 1, 1050);
	
    -- Check for completion
    local ret = Saga.GetNPCIndex(cid);
    if ret == 1050 then
        Saga.GeneralDialog(cid, 3936);
        Saga.SubstepComplete(cid, QuestID, StepID, 1);
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
    local CurStepID = Saga.GetStepIndex(cid, QuestID );
    StepID = CurStepID;
    local ret = -1;

    if CurStepID == 39001 then
        ret = QUEST_STEP_1(cid);
    elseif CurStepID == 39002 then
        ret = QUEST_STEP_2(cid);
    end
	
    if ret == 0 then
        QUEST_CHECK(cid)
    end
	
    return ret;
end
