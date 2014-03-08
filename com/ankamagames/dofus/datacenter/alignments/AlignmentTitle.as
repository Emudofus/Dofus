package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AlignmentTitle extends Object implements IDataCenter
   {
      
      public function AlignmentTitle() {
         super();
      }
      
      public static const MODULE:String = "AlignmentTitles";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentTitle));
      
      public static function getAlignmentTitlesById(param1:int) : AlignmentTitle {
         return GameData.getObject(MODULE,param1) as AlignmentTitle;
      }
      
      public static function getAlignmentTitles() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var sideId:int;
      
      public var namesId:Vector.<int>;
      
      public var shortsId:Vector.<int>;
      
      public function getNameFromGrade(param1:int) : String {
         return I18n.getText(this.namesId[param1]);
      }
      
      public function getShortNameFromGrade(param1:int) : String {
         return I18n.getText(this.shortsId[param1]);
      }
   }
}
