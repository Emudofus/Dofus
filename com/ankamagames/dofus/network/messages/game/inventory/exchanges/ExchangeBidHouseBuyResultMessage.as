package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeBidHouseBuyResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseBuyResultMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6272;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var uid:uint = 0;
      
      public var bought:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 6272;
      }
      
      public function initExchangeBidHouseBuyResultMessage(param1:uint = 0, param2:Boolean = false) : ExchangeBidHouseBuyResultMessage
      {
         this.uid = param1;
         this.bought = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.uid = 0;
         this.bought = false;
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
         this.serializeAs_ExchangeBidHouseBuyResultMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseBuyResultMessage(param1:ICustomDataOutput) : void
      {
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         else
         {
            param1.writeVarInt(this.uid);
            param1.writeBoolean(this.bought);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseBuyResultMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseBuyResultMessage(param1:ICustomDataInput) : void
      {
         this.uid = param1.readVarUhInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of ExchangeBidHouseBuyResultMessage.uid.");
         }
         else
         {
            this.bought = param1.readBoolean();
            return;
         }
      }
   }
}
