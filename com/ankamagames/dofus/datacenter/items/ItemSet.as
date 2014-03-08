package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ItemSet extends Object implements IDataCenter
   {
      
      public function ItemSet() {
         super();
      }
      
      public static const MODULE:String = "ItemSets";
      
      public static function getItemSetById(id:uint) : ItemSet {
         return GameData.getObject(MODULE,id) as ItemSet;
      }
      
      public static function getItemSets() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var items:Vector.<uint>;
      
      public var nameId:uint;
      
      public var effects:Vector.<Vector.<EffectInstance>>;
      
      public var bonusIsSecret:Boolean;
      
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
