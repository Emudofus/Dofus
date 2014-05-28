package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseBuyResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseBuyResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 6272;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var uid:uint = 0;
      
      public var bought:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6272;
      }
      
      public function initExchangeBidHouseBuyResultMessage(uid:uint = 0, bought:Boolean = false) : ExchangeBidHouseBuyResultMessage {
         this.uid = uid;
         this.bought = bought;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.uid = 0;
         this.bought = false;
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
         this.serializeAs_ExchangeBidHouseBuyResultMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseBuyResultMessage(output:IDataOutput) : void {
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         else
         {
            output.writeInt(this.uid);
            output.writeBoolean(this.bought);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseBuyResultMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseBuyResultMessage(input:IDataInput) : void {
         this.uid = input.readInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of ExchangeBidHouseBuyResultMessage.uid.");
         }
         else
         {
            this.bought = input.readBoolean();
            return;
         }
      }
   }
}
