package com.ankamagames.dofus.datacenter.sounds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SoundUiElement extends Object implements IDataCenter
   {
      
      public function SoundUiElement() {
         super();
      }
      
      public static var MODULE:String = "SoundUiElement";
      
      public var id:uint;
      
      public var name:String;
      
      public var hookId:uint;
      
      public var file:String;
      
      public var volume:uint;
      
      public function get hook() : String {
         var h:SoundUiHook = SoundUiHook.getSoundUiHookById(this.id);
         return h?h.name:null;
      }
   }
}
