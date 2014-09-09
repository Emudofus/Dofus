package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PaddockBuyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockBuyRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5951;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var proposedPrice:uint = 0;
      
      override public function getMessageId() : uint {
         return 5951;
      }
      
      public function initPaddockBuyRequestMessage(proposedPrice:uint = 0) : PaddockBuyRequestMessage {
         this.proposedPrice = proposedPrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.proposedPrice = 0;
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
         this.serializeAs_PaddockBuyRequestMessage(output);
      }
      
      public function serializeAs_PaddockBuyRequestMessage(output:IDataOutput) : void {
         if(this.proposedPrice < 0)
         {
            throw new Error("Forbidden value (" + this.proposedPrice + ") on element proposedPrice.");
         }
         else
         {
            output.writeInt(this.proposedPrice);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockBuyRequestMessage(input);
      }
      
      public function deserializeAs_PaddockBuyRequestMessage(input:IDataInput) : void {
         this.proposedPrice = input.readInt();
         if(this.proposedPrice < 0)
         {
            throw new Error("Forbidden value (" + this.proposedPrice + ") on element of PaddockBuyRequestMessage.proposedPrice.");
         }
         else
         {
            return;
         }
      }
   }
}
