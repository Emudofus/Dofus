package com.ankamagames.dofus.datacenter.livingObjects
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class LivingObjectSkinJntMood extends Object implements IDataCenter
   {
      
      public function LivingObjectSkinJntMood() {
         super();
      }
      
      public static const MODULE:String = "LivingObjectSkinJntMood";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemText));
      
      public static function getLivingObjectSkin(param1:int, param2:int, param3:int) : int {
         var _loc4_:LivingObjectSkinJntMood = GameData.getObject(MODULE,param1) as LivingObjectSkinJntMood;
         if(!_loc4_ || !_loc4_.moods[param2])
         {
            return 0;
         }
         var _loc5_:Vector.<int> = _loc4_.moods[param2] as Vector.<int>;
         return _loc5_[Math.max(0,param3-1)];
      }
      
      public static function getLivingObjectSkins() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var skinId:int;
      
      public var moods:Vector.<Vector.<int>>;
   }
}
