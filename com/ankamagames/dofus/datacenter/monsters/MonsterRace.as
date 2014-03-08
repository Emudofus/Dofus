package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class MonsterRace extends Object implements IDataCenter
   {
      
      public function MonsterRace() {
         super();
      }
      
      public static const MODULE:String = "MonsterRaces";
      
      public static function getMonsterRaceById(id:uint) : MonsterRace {
         return GameData.getObject(MODULE,id) as MonsterRace;
      }
      
      public static function getMonsterRaces() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var superRaceId:int;
      
      public var nameId:uint;
      
      public var monsters:Vector.<uint>;
      
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
