package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ShortcutEmote extends Shortcut implements INetworkType
   {
      
      public function ShortcutEmote() {
         super();
      }
      
      public static const protocolId:uint = 389;
      
      public var emoteId:uint = 0;
      
      override public function getTypeId() : uint {
         return 389;
      }
      
      public function initShortcutEmote(param1:uint=0, param2:uint=0) : ShortcutEmote {
         super.initShortcut(param1);
         this.emoteId = param2;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.emoteId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ShortcutEmote(param1);
      }
      
      public function serializeAs_ShortcutEmote(param1:IDataOutput) : void {
         super.serializeAs_Shortcut(param1);
         if(this.emoteId < 0 || this.emoteId > 255)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         else
         {
            param1.writeByte(this.emoteId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShortcutEmote(param1);
      }
      
      public function deserializeAs_ShortcutEmote(param1:IDataInput) : void {
         super.deserialize(param1);
         this.emoteId = param1.readUnsignedByte();
         if(this.emoteId < 0 || this.emoteId > 255)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of ShortcutEmote.emoteId.");
         }
         else
         {
            return;
         }
      }
   }
}
