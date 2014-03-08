package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Tips extends Object implements IDataCenter
   {
      
      public function Tips() {
         super();
      }
      
      public static const MODULE:String = "Tips";
      
      public static function getTipsById(param1:int) : Tips {
         return GameData.getObject(MODULE,param1) as Tips;
      }
      
      public static function getAllTips() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var descId:uint;
      
      private var _description:String;
      
      public function get description() : String {
         if(!this._description)
         {
            this._description = I18n.getText(this.descId);
         }
         return this._description;
      }
   }
}
