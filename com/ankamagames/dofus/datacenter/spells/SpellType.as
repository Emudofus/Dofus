package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SpellType extends Object implements IDataCenter
   {
      
      public function SpellType() {
         super();
      }
      
      public static const MODULE:String = "SpellTypes";
      
      public static function getSpellTypeById(id:int) : SpellType {
         return GameData.getObject(MODULE,id) as SpellType;
      }
      
      public var id:int;
      
      public var longNameId:uint;
      
      public var shortNameId:uint;
      
      private var _longName:String;
      
      private var _shortName:String;
      
      public function get longName() : String {
         if(!this._longName)
         {
            this._longName = I18n.getText(this.longNameId);
         }
         return this._longName;
      }
      
      public function get shortName() : String {
         if(!this._shortName)
         {
            this._shortName = I18n.getText(this.shortNameId);
         }
         return this._shortName;
      }
   }
}
