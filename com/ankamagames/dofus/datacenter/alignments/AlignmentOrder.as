package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AlignmentOrder extends Object implements IDataCenter
   {
      
      public function AlignmentOrder() {
         super();
      }
      
      public static const MODULE:String = "AlignmentOrder";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentOrder));
      
      public static function getAlignmentOrderById(param1:int) : AlignmentOrder {
         return GameData.getObject(MODULE,param1) as AlignmentOrder;
      }
      
      public static function getAlignmentOrders() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var sideId:uint;
      
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
