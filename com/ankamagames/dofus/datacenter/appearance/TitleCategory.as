package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class TitleCategory extends Object implements IDataCenter
   {
      
      public function TitleCategory() {
         super();
      }
      
      public static const MODULE:String = "TitleCategories";
      
      public static function getTitleCategoryById(param1:int) : TitleCategory {
         return GameData.getObject(MODULE,param1) as TitleCategory;
      }
      
      public static function getTitleCategories() : Array {
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
