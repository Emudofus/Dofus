package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Hint extends Object implements IDataCenter
   {
      
      public function Hint() {
         super();
      }
      
      public static const MODULE:String = "Hints";
      
      private static var _allHints:Array;
      
      public static function getHintById(id:int) : Hint {
         return GameData.getObject(MODULE,id) as Hint;
      }
      
      public static function getHints() : Array {
         if(!_allHints)
         {
            _allHints = GameData.getObjects(MODULE) as Array;
         }
         return _allHints;
      }
      
      public var id:int;
      
      public var categoryId:uint;
      
      public var gfx:uint;
      
      public var nameId:uint;
      
      public var mapId:uint;
      
      public var realMapId:uint;
      
      public var x:int;
      
      public var y:int;
      
      public var outdoor:Boolean;
      
      public var subareaId:int;
      
      public var worldMapId:int;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId).replace(" \\n ","\n");
         }
         return this._name;
      }
   }
}
