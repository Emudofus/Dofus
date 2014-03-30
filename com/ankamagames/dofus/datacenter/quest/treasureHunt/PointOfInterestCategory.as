package com.ankamagames.dofus.datacenter.quest.treasureHunt
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class PointOfInterestCategory extends Object implements IDataCenter
   {
      
      public function PointOfInterestCategory() {
         super();
      }
      
      public static const MODULE:String = "PointOfInterestCategory";
      
      public static function getPointOfInterestCategoryById(id:int) : PointOfInterestCategory {
         return GameData.getObject(MODULE,id) as PointOfInterestCategory;
      }
      
      public static function getPointOfInterestCategories() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var actionLabelId:uint;
      
      private var _actionLabel:String;
      
      public function get actionLabel() : String {
         if(!this._actionLabel)
         {
            this._actionLabel = I18n.getText(this.actionLabelId);
         }
         return this._actionLabel;
      }
   }
}
