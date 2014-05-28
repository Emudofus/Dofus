package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ShortcutSmiley extends Shortcut implements INetworkType
   {
      
      public function ShortcutSmiley() {
         super();
      }
      
      public static const protocolId:uint = 388;
      
      public var smileyId:uint = 0;
      
      override public function getTypeId() : uint {
         return 388;
      }
      
      public function initShortcutSmiley(slot:uint = 0, smileyId:uint = 0) : ShortcutSmiley {
         super.initShortcut(slot);
         this.smileyId = smileyId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.smileyId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShortcutSmiley(output);
      }
      
      public function serializeAs_ShortcutSmiley(output:IDataOutput) : void {
         super.serializeAs_Shortcut(output);
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         else
         {
            output.writeByte(this.smileyId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutSmiley(input);
      }
      
      public function deserializeAs_ShortcutSmiley(input:IDataInput) : void {
         super.deserialize(input);
         this.smileyId = input.readByte();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of ShortcutSmiley.smileyId.");
         }
         else
         {
            return;
         }
      }
   }
}
