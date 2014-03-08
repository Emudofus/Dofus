package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShortcutBarRemoveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarRemoveRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6228;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var barType:uint = 0;
      
      public var slot:uint = 0;
      
      override public function getMessageId() : uint {
         return 6228;
      }
      
      public function initShortcutBarRemoveRequestMessage(barType:uint=0, slot:uint=0) : ShortcutBarRemoveRequestMessage {
         this.barType = barType;
         this.slot = slot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.barType = 0;
         this.slot = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShortcutBarRemoveRequestMessage(output);
      }
      
      public function serializeAs_ShortcutBarRemoveRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.barType);
         if((this.slot < 0) || (this.slot > 99))
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         else
         {
            output.writeInt(this.slot);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutBarRemoveRequestMessage(input);
      }
      
      public function deserializeAs_ShortcutBarRemoveRequestMessage(input:IDataInput) : void {
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarRemoveRequestMessage.barType.");
         }
         else
         {
            this.slot = input.readInt();
            if((this.slot < 0) || (this.slot > 99))
            {
               throw new Error("Forbidden value (" + this.slot + ") on element of ShortcutBarRemoveRequestMessage.slot.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
