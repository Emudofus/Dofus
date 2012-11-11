package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class QuestStepRewards extends Object implements IDataCenter
    {
        public var id:uint;
        public var stepId:uint;
        public var levelMin:int;
        public var levelMax:int;
        public var itemsReward:Vector.<Vector.<uint>>;
        public var emotesReward:Vector.<uint>;
        public var jobsReward:Vector.<uint>;
        public var spellsReward:Vector.<uint>;
        private static const MODULE:String = "QuestStepRewards";

        public function QuestStepRewards()
        {
            return;
        }// end function

        public static function getQuestStepRewardsById(param1:int) : QuestStepRewards
        {
            return GameData.getObject(MODULE, param1) as QuestStepRewards;
        }// end function

        public static function getQuestStepRewards() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
