package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PaddockBuyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockBuyRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5951;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var proposedPrice:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5951;
      }
      
      public function initPaddockBuyRequestMessage(param1:uint = 0) : PaddockBuyRequestMessage
      {
         this.proposedPrice = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.proposedPrice = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockBuyRequestMessage(param1);
      }
      
      public function serializeAs_PaddockBuyRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.proposedPrice < 0)
         {
            throw new Error("Forbidden value (" + this.proposedPrice + ") on element proposedPrice.");
         }
         else
         {
            param1.writeVarInt(this.proposedPrice);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockBuyRequestMessage(param1);
      }
      
      public function deserializeAs_PaddockBuyRequestMessage(param1:ICustomDataInput) : void
      {
         this.proposedPrice = param1.readVarUhInt();
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
