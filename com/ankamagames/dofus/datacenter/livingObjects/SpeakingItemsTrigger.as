package com.ankamagames.dofus.datacenter.livingObjects
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   
   public class SpeakingItemsTrigger extends Object implements IDataCenter
   {
      
      public function SpeakingItemsTrigger() {
         super();
      }
      
      public static const MODULE:String = "SpeakingItemsTriggers";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemsTrigger));
      
      public static function getSpeakingItemsTriggerById(id:int) : SpeakingItemsTrigger {
         return GameData.getObject(MODULE,id) as SpeakingItemsTrigger;
      }
      
      public static function getSpeakingItemsTriggers() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var triggersId:int;
      
      public var textIds:Vector.<int>;
      
      public var states:Vector.<int>;
   }
}
