package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShortcutBarRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarRemovedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6224;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var barType:uint = 0;
      
      public var slot:uint = 0;
      
      override public function getMessageId() : uint {
         return 6224;
      }
      
      public function initShortcutBarRemovedMessage(barType:uint=0, slot:uint=0) : ShortcutBarRemovedMessage {
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
         this.serializeAs_ShortcutBarRemovedMessage(output);
      }
      
      public function serializeAs_ShortcutBarRemovedMessage(output:IDataOutput) : void {
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
         this.deserializeAs_ShortcutBarRemovedMessage(input);
      }
      
      public function deserializeAs_ShortcutBarRemovedMessage(input:IDataInput) : void {
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarRemovedMessage.barType.");
         }
         else
         {
            this.slot = input.readInt();
            if((this.slot < 0) || (this.slot > 99))
            {
               throw new Error("Forbidden value (" + this.slot + ") on element of ShortcutBarRemovedMessage.slot.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
