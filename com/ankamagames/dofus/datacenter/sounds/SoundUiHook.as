package com.ankamagames.dofus.datacenter.sounds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;


   public class SoundUiHook extends Object implements IDataCenter
   {
         

      public function SoundUiHook() {
         super();
      }

      public static var MODULE:String = "SoundUiHook";

      public static function getSoundUiHookById(id:uint) : SoundUiHook {
         return GameData.getObject(MODULE,id) as SoundUiHook;
      }

      public static function getSoundUiHooks() : Array {
         return GameData.getObjects(MODULE);
      }

      public var id:uint;

      public var name:String;
   }

}