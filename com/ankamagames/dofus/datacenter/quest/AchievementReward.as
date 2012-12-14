package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class AchievementReward extends Object implements IDataCenter
    {
        public var id:uint;
        public var achievementId:uint;
        public var levelMin:int;
        public var levelMax:int;
        public var itemsReward:Vector.<Vector.<uint>>;
        public var emotesReward:Vector.<uint>;
        public var spellsReward:Vector.<uint>;
        public var titlesReward:Vector.<uint>;
        public var ornamentsReward:Vector.<uint>;
        private static const MODULE:String = "AchievementRewards";

        public function AchievementReward()
        {
            return;
        }// end function

        public static function getAchievementRewardById(param1:int) : AchievementReward
        {
            return GameData.getObject(MODULE, param1) as AchievementReward;
        }// end function

        public static function getAchievementRewards() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
