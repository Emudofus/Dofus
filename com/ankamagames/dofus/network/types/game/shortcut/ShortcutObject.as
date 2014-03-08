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
      
      public function initShortcutObject(slot:uint=0) : ShortcutObject {
         super.initShortcut(slot);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShortcutObject(output);
      }
      
      public function serializeAs_ShortcutObject(output:IDataOutput) : void {
         super.serializeAs_Shortcut(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutObject(input);
      }
      
      public function deserializeAs_ShortcutObject(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
