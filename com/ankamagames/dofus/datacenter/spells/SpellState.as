package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SpellState extends Object implements IDataCenter
   {
      
      public function SpellState() {
         super();
      }
      
      public static const MODULE:String = "SpellStates";
      
      public static function getSpellStateById(id:int) : SpellState {
         return GameData.getObject(MODULE,id) as SpellState;
      }
      
      public static function getSpellStates() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var preventsSpellCast:Boolean;
      
      public var preventsFight:Boolean;
      
      public var critical:Boolean;
      
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
