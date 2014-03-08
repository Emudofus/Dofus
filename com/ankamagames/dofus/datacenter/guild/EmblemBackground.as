package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class EmblemBackground extends Object implements IDataCenter
   {
      
      public function EmblemBackground() {
         super();
      }
      
      public static const MODULE:String = "EmblemBackgrounds";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemBackground));
      
      public static function getEmblemBackgroundById(id:int) : EmblemBackground {
         return GameData.getObject(MODULE,id) as EmblemBackground;
      }
      
      public static function getEmblemBackgrounds() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var order:int;
   }
}
