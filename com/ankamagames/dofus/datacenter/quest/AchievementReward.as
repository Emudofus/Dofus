package com.ankamagames.dofus.datacenter.quest
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;

    public class AchievementReward implements IDataCenter 
    {

        public static const MODULE:String = "AchievementRewards";

        public var id:uint;
        public var achievementId:uint;
        public var levelMin:int;
        public var levelMax:int;
        public var itemsReward:Vector.<uint>;
        public var itemsQuantityReward:Vector.<uint>;
        public var emotesReward:Vector.<uint>;
        public var spellsReward:Vector.<uint>;
        public var titlesReward:Vector.<uint>;
        public var ornamentsReward:Vector.<uint>;


        public static function getAchievementRewardById(id:int):AchievementReward
        {
            return ((GameData.getObject(MODULE, id) as AchievementReward));
        }

        public static function getAchievementRewards():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.quest

