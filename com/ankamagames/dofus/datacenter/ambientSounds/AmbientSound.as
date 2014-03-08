package com.ankamagames.dofus.datacenter.ambientSounds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class AmbientSound extends Object implements IDataCenter
   {
      
      public function AmbientSound() {
         super();
      }
      
      public static const AMBIENT_TYPE_ROLEPLAY:int = 1;
      
      public static const AMBIENT_TYPE_AMBIENT:int = 2;
      
      public static const AMBIENT_TYPE_FIGHT:int = 3;
      
      public static const AMBIENT_TYPE_BOSS:int = 4;
      
      public static const MODULE:String = "AmbientSounds";
      
      public static function getAmbientSoundById(param1:uint) : AmbientSound {
         return GameData.getObject(MODULE,param1) as AmbientSound;
      }
      
      public var id:int;
      
      public var volume:uint;
      
      public var criterionId:int;
      
      public var silenceMin:uint;
      
      public var silenceMax:uint;
      
      public var channel:int;
      
      public var type_id:int;
   }
}
