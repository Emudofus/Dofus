package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectRemovedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public function ExchangeObjectRemovedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5517;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var objectUID:uint = 0;
      
      override public function getMessageId() : uint {
         return 5517;
      }
      
      public function initExchangeObjectRemovedMessage(param1:Boolean=false, param2:uint=0) : ExchangeObjectRemovedMessage {
         super.initExchangeObjectMessage(param1);
         this.objectUID = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeObjectRemovedMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectRemovedMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMessage(param1);
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
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeObjectRemovedMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectRemovedMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.objectUID = param1.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeObjectRemovedMessage.objectUID.");
         }
         else
         {
            return;
         }
      }
   }
}
