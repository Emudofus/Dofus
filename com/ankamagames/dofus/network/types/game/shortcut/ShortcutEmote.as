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
      
      public function initShortcutEmote(slot:uint = 0, emoteId:uint = 0) : ShortcutEmote {
         super.initShortcut(slot);
         this.emoteId = emoteId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.emoteId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShortcutEmote(output);
      }
      
      public function serializeAs_ShortcutEmote(output:IDataOutput) : void {
         super.serializeAs_Shortcut(output);
         if((this.emoteId < 0) || (this.emoteId > 255))
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         else
         {
            output.writeByte(this.emoteId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutEmote(input);
      }
      
      public function deserializeAs_ShortcutEmote(input:IDataInput) : void {
         super.deserialize(input);
         this.emoteId = input.readUnsignedByte();
         if((this.emoteId < 0) || (this.emoteId > 255))
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
