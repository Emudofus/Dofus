package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeRemovedPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeRemovedPaymentForCraftMessage() {
         super();
      }
      
      public static const protocolId:uint = 6031;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var onlySuccess:Boolean = false;
      
      public var objectUID:uint = 0;
      
      override public function getMessageId() : uint {
         return 6031;
      }
      
      public function initExchangeRemovedPaymentForCraftMessage(param1:Boolean=false, param2:uint=0) : ExchangeRemovedPaymentForCraftMessage {
         this.onlySuccess = param1;
         this.objectUID = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.onlySuccess = false;
         this.objectUID = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeRemovedPaymentForCraftMessage(param1);
      }
      
      public function serializeAs_ExchangeRemovedPaymentForCraftMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.onlySuccess);
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeInt(this.objectUID);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeRemovedPaymentForCraftMessage(param1);
      }
      
      public function deserializeAs_ExchangeRemovedPaymentForCraftMessage(param1:IDataInput) : void {
         this.onlySuccess = param1.readBoolean();
         this.objectUID = param1.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeRemovedPaymentForCraftMessage.objectUID.");
         }
         else
         {
            return;
         }
      }
   }
}
