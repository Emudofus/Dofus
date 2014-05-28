package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseSearchMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseSearchMessage() {
         super();
      }
      
      public static const protocolId:uint = 5806;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      public var genId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5806;
      }
      
      public function initExchangeBidHouseSearchMessage(type:uint = 0, genId:uint = 0) : ExchangeBidHouseSearchMessage {
         this.type = type;
         this.genId = genId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.type = 0;
         this.genId = 0;
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
         this.serializeAs_ExchangeBidHouseSearchMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseSearchMessage(output:IDataOutput) : void {
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element type.");
         }
         else
         {
            output.writeInt(this.type);
            if(this.genId < 0)
            {
               throw new Error("Forbidden value (" + this.genId + ") on element genId.");
            }
            else
            {
               output.writeInt(this.genId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseSearchMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseSearchMessage(input:IDataInput) : void {
         this.type = input.readInt();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ExchangeBidHouseSearchMessage.type.");
         }
         else
         {
            this.genId = input.readInt();
            if(this.genId < 0)
            {
               throw new Error("Forbidden value (" + this.genId + ") on element of ExchangeBidHouseSearchMessage.genId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
