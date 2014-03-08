package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Companion extends Object implements IDataCenter
   {
      
      public function Companion() {
         super();
      }
      
      public static const MODULE:String = "Companions";
      
      public static function getCompanionById(param1:uint) : Companion {
         return GameData.getObject(MODULE,param1) as Companion;
      }
      
      public static function getCompanions() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var look:String;
      
      public var webDisplay:Boolean;
      
      public var descriptionId:uint;
      
      public var startingSpellLevelId:uint;
      
      public var assetId:uint;
      
      public var characteristics:Vector.<uint>;
      
      public var spells:Vector.<uint>;
      
      public var creatureBoneId:int;
      
      private var _name:String;
      
      private var _desc:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String {
         if(!this._desc)
         {
            this._desc = I18n.getText(this.descriptionId);
         }
         return this._desc;
      }
   }
}
