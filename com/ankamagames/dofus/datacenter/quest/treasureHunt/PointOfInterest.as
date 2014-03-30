package com.ankamagames.dofus.datacenter.quest.treasureHunt
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class PointOfInterest extends Object implements IDataCenter
   {
      
      public function PointOfInterest() {
         super();
      }
      
      public static const MODULE:String = "PointOfInterest";
      
      public static function getPointOfInterestById(id:int) : PointOfInterest {
         return GameData.getObject(MODULE,id) as PointOfInterest;
      }
      
      public static function getPointOfInterests() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var categoryId:uint;
      
      private var _name:String;
      
      private var _categoryActionLabel:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get categoryActionLabel() : String {
         if(!this._categoryActionLabel)
         {
            this._categoryActionLabel = PointOfInterestCategory.getPointOfInterestCategoryById(this.categoryId).actionLabel;
         }
         return this._categoryActionLabel;
      }
   }
}
