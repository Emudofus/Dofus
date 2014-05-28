package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public function ExchangeObjectModifiedMessage() {
         this.object = new ObjectItem();
         super();
      }
      
      public static const protocolId:uint = 5519;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var object:ObjectItem;
      
      override public function getMessageId() : uint {
         return 5519;
      }
      
      public function initExchangeObjectModifiedMessage(remote:Boolean = false, object:ObjectItem = null) : ExchangeObjectModifiedMessage {
         super.initExchangeObjectMessage(remote);
         this.object = object;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.object = new ObjectItem();
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
         this.serializeAs_ExchangeObjectModifiedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectModifiedMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMessage(output);
         this.object.serializeAs_ObjectItem(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectModifiedMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.object = new ObjectItem();
         this.object.deserialize(input);
      }
   }
}
