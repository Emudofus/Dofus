package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseBuyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseBuyRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5738;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var proposedPrice:uint = 0;
      
      override public function getMessageId() : uint {
         return 5738;
      }
      
      public function initHouseBuyRequestMessage(proposedPrice:uint=0) : HouseBuyRequestMessage {
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
         this.serializeAs_HouseBuyRequestMessage(output);
      }
      
      public function serializeAs_HouseBuyRequestMessage(output:IDataOutput) : void {
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
         this.deserializeAs_HouseBuyRequestMessage(input);
      }
      
      public function deserializeAs_HouseBuyRequestMessage(input:IDataInput) : void {
         this.proposedPrice = input.readInt();
         if(this.proposedPrice < 0)
         {
            throw new Error("Forbidden value (" + this.proposedPrice + ") on element of HouseBuyRequestMessage.proposedPrice.");
         }
         else
         {
            return;
         }
      }
   }
}
