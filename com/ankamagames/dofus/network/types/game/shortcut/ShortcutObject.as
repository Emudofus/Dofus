package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ShortcutObject extends Shortcut implements INetworkType
   {
      
      public function ShortcutObject() {
         super();
      }
      
      public static const protocolId:uint = 367;
      
      override public function getTypeId() : uint {
         return 367;
      }
      
      public function initShortcutObject(param1:uint=0) : ShortcutObject {
         super.initShortcut(param1);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ShortcutObject(param1);
      }
      
      public function serializeAs_ShortcutObject(param1:IDataOutput) : void {
         super.serializeAs_Shortcut(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShortcutObject(param1);
      }
      
      public function deserializeAs_ShortcutObject(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
