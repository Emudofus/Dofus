package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeObjectUseInWorkshopMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeObjectUseInWorkshopMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6004;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var objectUID:uint = 0;
      
      public var quantity:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6004;
      }
      
      public function initExchangeObjectUseInWorkshopMessage(param1:uint = 0, param2:int = 0) : ExchangeObjectUseInWorkshopMessage
      {
         this.objectUID = param1;
         this.quantity = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
         this.quantity = 0;
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
         this.serializeAs_ExchangeObjectUseInWorkshopMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectUseInWorkshopMessage(param1:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeVarInt(this.objectUID);
            param1.writeVarInt(this.quantity);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectUseInWorkshopMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectUseInWorkshopMessage(param1:ICustomDataInput) : void
      {
         this.objectUID = param1.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeObjectUseInWorkshopMessage.objectUID.");
         }
         else
         {
            this.quantity = param1.readVarInt();
            return;
         }
      }
   }
}
