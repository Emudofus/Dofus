package com.ankamagames.dofus.datacenter.livingObjects
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class LivingObjectSkinJntMood extends Object implements IDataCenter
   {
      
      public function LivingObjectSkinJntMood() {
         super();
      }
      
      public static const MODULE:String = "LivingObjectSkinJntMood";
      
      protected static const _log:Logger;
      
      public static function getLivingObjectSkin(objectId:int, moodId:int, skinId:int) : int {
         var losjm:LivingObjectSkinJntMood = GameData.getObject(MODULE,objectId) as LivingObjectSkinJntMood;
         if((!losjm) || (!losjm.moods[moodId]))
         {
            return 0;
         }
         var ve:Vector.<int> = losjm.moods[moodId] as Vector.<int>;
         return ve[Math.max(0,skinId - 1)];
      }
      
      public static function getLivingObjectSkins() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var skinId:int;
      
      public var moods:Vector.<Vector.<int>>;
   }
}
