package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class MonsterSuperRace extends Object implements IDataCenter
   {
      
      public function MonsterSuperRace() {
         super();
      }
      
      public static const MODULE:String = "MonsterSuperRaces";
      
      public static function getMonsterSuperRaceById(param1:uint) : MonsterSuperRace {
         return GameData.getObject(MODULE,param1) as MonsterSuperRace;
      }
      
      public static function getMonsterSuperRaces() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
