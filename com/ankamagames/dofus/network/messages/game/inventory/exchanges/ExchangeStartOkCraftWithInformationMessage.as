package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkCraftWithInformationMessage extends ExchangeStartOkCraftMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkCraftWithInformationMessage() {
         super();
      }
      
      public static const protocolId:uint = 5941;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var nbCase:uint = 0;
      
      public var skillId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5941;
      }
      
      public function initExchangeStartOkCraftWithInformationMessage(nbCase:uint = 0, skillId:uint = 0) : ExchangeStartOkCraftWithInformationMessage {
         this.nbCase = nbCase;
         this.skillId = skillId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.nbCase = 0;
         this.skillId = 0;
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
         this.serializeAs_ExchangeStartOkCraftWithInformationMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkCraftWithInformationMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeStartOkCraftMessage(output);
         if(this.nbCase < 0)
         {
            throw new Error("Forbidden value (" + this.nbCase + ") on element nbCase.");
         }
         else
         {
            output.writeByte(this.nbCase);
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            else
            {
               output.writeInt(this.skillId);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkCraftWithInformationMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkCraftWithInformationMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.nbCase = input.readByte();
         if(this.nbCase < 0)
         {
            throw new Error("Forbidden value (" + this.nbCase + ") on element of ExchangeStartOkCraftWithInformationMessage.nbCase.");
         }
         else
         {
            this.skillId = input.readInt();
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangeStartOkCraftWithInformationMessage.skillId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
