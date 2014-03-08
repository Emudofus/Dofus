package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class HintCategory extends Object implements IDataCenter
   {
      
      public function HintCategory() {
         super();
      }
      
      public static const MODULE:String = "HintCategory";
      
      public static function getHintCategoryById(param1:int) : HintCategory {
         return GameData.getObject(MODULE,param1) as HintCategory;
      }
      
      public static function getHintCategories() : Array {
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
