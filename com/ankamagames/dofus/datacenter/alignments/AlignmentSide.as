package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AlignmentSide extends Object implements IDataCenter
   {
      
      public function AlignmentSide() {
         super();
      }
      
      public static const MODULE:String = "AlignmentSides";
      
      protected static const _log:Logger;
      
      public static function getAlignmentSideById(id:int) : AlignmentSide {
         return GameData.getObject(MODULE,id) as AlignmentSide;
      }
      
      public static function getAlignmentSides() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var canConquest:Boolean;
      
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
