package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartedWithPodsMessage extends ExchangeStartedMessage implements INetworkMessage
   {
      
      public function ExchangeStartedWithPodsMessage() {
         super();
      }
      
      public static const protocolId:uint = 6129;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var firstCharacterId:int = 0;
      
      public var firstCharacterCurrentWeight:uint = 0;
      
      public var firstCharacterMaxWeight:uint = 0;
      
      public var secondCharacterId:int = 0;
      
      public var secondCharacterCurrentWeight:uint = 0;
      
      public var secondCharacterMaxWeight:uint = 0;
      
      override public function getMessageId() : uint {
         return 6129;
      }
      
      public function initExchangeStartedWithPodsMessage(exchangeType:int = 0, firstCharacterId:int = 0, firstCharacterCurrentWeight:uint = 0, firstCharacterMaxWeight:uint = 0, secondCharacterId:int = 0, secondCharacterCurrentWeight:uint = 0, secondCharacterMaxWeight:uint = 0) : ExchangeStartedWithPodsMessage {
         super.initExchangeStartedMessage(exchangeType);
         this.firstCharacterId = firstCharacterId;
         this.firstCharacterCurrentWeight = firstCharacterCurrentWeight;
         this.firstCharacterMaxWeight = firstCharacterMaxWeight;
         this.secondCharacterId = secondCharacterId;
         this.secondCharacterCurrentWeight = secondCharacterCurrentWeight;
         this.secondCharacterMaxWeight = secondCharacterMaxWeight;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.firstCharacterId = 0;
         this.firstCharacterCurrentWeight = 0;
         this.firstCharacterMaxWeight = 0;
         this.secondCharacterId = 0;
         this.secondCharacterCurrentWeight = 0;
         this.secondCharacterMaxWeight = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeStartedWithPodsMessage(output);
      }
      
      public function serializeAs_ExchangeStartedWithPodsMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeStartedMessage(output);
         output.writeInt(this.firstCharacterId);
         if(this.firstCharacterCurrentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.firstCharacterCurrentWeight + ") on element firstCharacterCurrentWeight.");
         }
         else
         {
            output.writeInt(this.firstCharacterCurrentWeight);
            if(this.firstCharacterMaxWeight < 0)
            {
               throw new Error("Forbidden value (" + this.firstCharacterMaxWeight + ") on element firstCharacterMaxWeight.");
            }
            else
            {
               output.writeInt(this.firstCharacterMaxWeight);
               output.writeInt(this.secondCharacterId);
               if(this.secondCharacterCurrentWeight < 0)
               {
                  throw new Error("Forbidden value (" + this.secondCharacterCurrentWeight + ") on element secondCharacterCurrentWeight.");
               }
               else
               {
                  output.writeInt(this.secondCharacterCurrentWeight);
                  if(this.secondCharacterMaxWeight < 0)
                  {
                     throw new Error("Forbidden value (" + this.secondCharacterMaxWeight + ") on element secondCharacterMaxWeight.");
                  }
                  else
                  {
                     output.writeInt(this.secondCharacterMaxWeight);
                     return;
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartedWithPodsMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedWithPodsMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.firstCharacterId = input.readInt();
         this.firstCharacterCurrentWeight = input.readInt();
         if(this.firstCharacterCurrentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.firstCharacterCurrentWeight + ") on element of ExchangeStartedWithPodsMessage.firstCharacterCurrentWeight.");
         }
         else
         {
            this.firstCharacterMaxWeight = input.readInt();
            if(this.firstCharacterMaxWeight < 0)
            {
               throw new Error("Forbidden value (" + this.firstCharacterMaxWeight + ") on element of ExchangeStartedWithPodsMessage.firstCharacterMaxWeight.");
            }
            else
            {
               this.secondCharacterId = input.readInt();
               this.secondCharacterCurrentWeight = input.readInt();
               if(this.secondCharacterCurrentWeight < 0)
               {
                  throw new Error("Forbidden value (" + this.secondCharacterCurrentWeight + ") on element of ExchangeStartedWithPodsMessage.secondCharacterCurrentWeight.");
               }
               else
               {
                  this.secondCharacterMaxWeight = input.readInt();
                  if(this.secondCharacterMaxWeight < 0)
                  {
                     throw new Error("Forbidden value (" + this.secondCharacterMaxWeight + ") on element of ExchangeStartedWithPodsMessage.secondCharacterMaxWeight.");
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
}
