package com.ankamagames.dofus.datacenter.monsters
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class MonsterMiniBoss implements IDataCenter 
    {

        public static const MODULE:String = "MonsterMiniBoss";

        public var id:int;
        public var monsterReplacingId:int;


        public static function getMonsterById(id:uint):MonsterMiniBoss
        {
            return ((GameData.getObject(MODULE, id) as MonsterMiniBoss));
        }

        public static function getMonsters():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.monsters

