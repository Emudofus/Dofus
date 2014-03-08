package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Monster extends Object implements IDataCenter
   {
      
      public function Monster() {
         super();
      }
      
      public static const MODULE:String = "Monsters";
      
      public static function getMonsterById(param1:uint) : Monster {
         return GameData.getObject(MODULE,param1) as Monster;
      }
      
      public static function getMonsters() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var gfxId:uint;
      
      public var race:int;
      
      public var grades:Vector.<MonsterGrade>;
      
      public var look:String;
      
      public var useSummonSlot:Boolean;
      
      public var useBombSlot:Boolean;
      
      public var canPlay:Boolean;
      
      public var canTackle:Boolean;
      
      public var animFunList:Vector.<AnimFunMonsterData>;
      
      public var isBoss:Boolean;
      
      public var drops:Vector.<MonsterDrop>;
      
      public var subareas:Vector.<uint>;
      
      public var spells:Vector.<uint>;
      
      public var favoriteSubareaId:int;
      
      public var isMiniBoss:Boolean;
      
      public var isQuestMonster:Boolean;
      
      public var correspondingMiniBossId:uint;
      
      public var speedAdjust:Number = 0.0;
      
      public var creatureBoneId:int;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get type() : MonsterRace {
         return MonsterRace.getMonsterRaceById(this.race);
      }
      
      public function getMonsterGrade(param1:uint) : MonsterGrade {
         if(param1 < 1 || param1 > this.grades.length)
         {
            param1 = this.grades.length;
         }
         return this.grades[param1-1] as MonsterGrade;
      }
      
      public function toString() : String {
         return this.name;
      }
   }
}
