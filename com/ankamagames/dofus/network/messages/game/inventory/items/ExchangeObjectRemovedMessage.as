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
      
      public function initExchangeObjectRemovedMessage(remote:Boolean=false, objectUID:uint=0) : ExchangeObjectRemovedMessage {
         super.initExchangeObjectMessage(remote);
         this.objectUID = objectUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objectUID = 0;
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
         this.serializeAs_ExchangeObjectRemovedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectRemovedMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMessage(output);
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectRemovedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectRemovedMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.objectUID = input.readInt();
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
