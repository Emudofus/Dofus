package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShortcutBarSwapRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarSwapRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6230;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var barType:uint = 0;
      
      public var firstSlot:uint = 0;
      
      public var secondSlot:uint = 0;
      
      override public function getMessageId() : uint {
         return 6230;
      }
      
      public function initShortcutBarSwapRequestMessage(barType:uint=0, firstSlot:uint=0, secondSlot:uint=0) : ShortcutBarSwapRequestMessage {
         this.barType = barType;
         this.firstSlot = firstSlot;
         this.secondSlot = secondSlot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.barType = 0;
         this.firstSlot = 0;
         this.secondSlot = 0;
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
         this.serializeAs_ShortcutBarSwapRequestMessage(output);
      }
      
      public function serializeAs_ShortcutBarSwapRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.barType);
         if((this.firstSlot < 0) || (this.firstSlot > 99))
         {
            throw new Error("Forbidden value (" + this.firstSlot + ") on element firstSlot.");
         }
         else
         {
            output.writeInt(this.firstSlot);
            if((this.secondSlot < 0) || (this.secondSlot > 99))
            {
               throw new Error("Forbidden value (" + this.secondSlot + ") on element secondSlot.");
            }
            else
            {
               output.writeInt(this.secondSlot);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutBarSwapRequestMessage(input);
      }
      
      public function deserializeAs_ShortcutBarSwapRequestMessage(input:IDataInput) : void {
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarSwapRequestMessage.barType.");
         }
         else
         {
            this.firstSlot = input.readInt();
            if((this.firstSlot < 0) || (this.firstSlot > 99))
            {
               throw new Error("Forbidden value (" + this.firstSlot + ") on element of ShortcutBarSwapRequestMessage.firstSlot.");
            }
            else
            {
               this.secondSlot = input.readInt();
               if((this.secondSlot < 0) || (this.secondSlot > 99))
               {
                  throw new Error("Forbidden value (" + this.secondSlot + ") on element of ShortcutBarSwapRequestMessage.secondSlot.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
