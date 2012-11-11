package com.ankamagames.dofus.datacenter.monsters
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MonsterMiniBoss extends Object implements IDataCenter
    {
        public var id:int;
        public var monsterReplacingId:int;
        private static const MODULE:String = "MonsterMiniBoss";

        public function MonsterMiniBoss()
        {
            return;
        }// end function

        public static function getMonsterById(param1:uint) : MonsterMiniBoss
        {
            return GameData.getObject(MODULE, param1) as MonsterMiniBoss;
        }// end function

        public static function getMonsters() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
