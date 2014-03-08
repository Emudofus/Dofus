package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeWeightMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeWeightMessage() {
         super();
      }
      
      public static const protocolId:uint = 5793;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var currentWeight:uint = 0;
      
      public var maxWeight:uint = 0;
      
      override public function getMessageId() : uint {
         return 5793;
      }
      
      public function initExchangeWeightMessage(currentWeight:uint=0, maxWeight:uint=0) : ExchangeWeightMessage {
         this.currentWeight = currentWeight;
         this.maxWeight = maxWeight;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.currentWeight = 0;
         this.maxWeight = 0;
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
         this.serializeAs_ExchangeWeightMessage(output);
      }
      
      public function serializeAs_ExchangeWeightMessage(output:IDataOutput) : void {
         if(this.currentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.currentWeight + ") on element currentWeight.");
         }
         else
         {
            output.writeInt(this.currentWeight);
            if(this.maxWeight < 0)
            {
               throw new Error("Forbidden value (" + this.maxWeight + ") on element maxWeight.");
            }
            else
            {
               output.writeInt(this.maxWeight);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeWeightMessage(input);
      }
      
      public function deserializeAs_ExchangeWeightMessage(input:IDataInput) : void {
         this.currentWeight = input.readInt();
         if(this.currentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.currentWeight + ") on element of ExchangeWeightMessage.currentWeight.");
         }
         else
         {
            this.maxWeight = input.readInt();
            if(this.maxWeight < 0)
            {
               throw new Error("Forbidden value (" + this.maxWeight + ") on element of ExchangeWeightMessage.maxWeight.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
