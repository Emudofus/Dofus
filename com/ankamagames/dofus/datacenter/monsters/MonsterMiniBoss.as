package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class MonsterMiniBoss extends Object implements IDataCenter
   {
      
      public function MonsterMiniBoss() {
         super();
      }
      
      public static const MODULE:String = "MonsterMiniBoss";
      
      public static function getMonsterById(id:uint) : MonsterMiniBoss {
         return GameData.getObject(MODULE,id) as MonsterMiniBoss;
      }
      
      public static function getMonsters() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var monsterReplacingId:int;
   }
}
