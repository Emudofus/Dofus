package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class HouseBuyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseBuyRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5738;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var proposedPrice:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5738;
      }
      
      public function initHouseBuyRequestMessage(param1:uint = 0) : HouseBuyRequestMessage
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
         this.serializeAs_HouseBuyRequestMessage(param1);
      }
      
      public function serializeAs_HouseBuyRequestMessage(param1:ICustomDataOutput) : void
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
         this.deserializeAs_HouseBuyRequestMessage(param1);
      }
      
      public function deserializeAs_HouseBuyRequestMessage(param1:ICustomDataInput) : void
      {
         this.proposedPrice = param1.readVarUhInt();
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
