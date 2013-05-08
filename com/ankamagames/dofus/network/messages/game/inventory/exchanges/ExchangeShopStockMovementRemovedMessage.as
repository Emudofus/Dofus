package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class ExchangeShopStockMovementRemovedMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function ExchangeShopStockMovementRemovedMessage() {
         super();
      }

      public static const protocolId:uint = 5907;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var objectId:uint = 0;

      override public function getMessageId() : uint {
         return 5907;
      }

      public function initExchangeShopStockMovementRemovedMessage(objectId:uint=0) : ExchangeShopStockMovementRemovedMessage {
         this.objectId=objectId;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.objectId=0;
         this._isInitialized=false;
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
         this.serializeAs_ExchangeShopStockMovementRemovedMessage(output);
      }

      public function serializeAs_ExchangeShopStockMovementRemovedMessage(output:IDataOutput) : void {
         if(this.objectId<0)
         {
            throw new Error("Forbidden value ("+this.objectId+") on element objectId.");
         }
         else
         {
            output.writeInt(this.objectId);
            return;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeShopStockMovementRemovedMessage(input);
      }

      public function deserializeAs_ExchangeShopStockMovementRemovedMessage(input:IDataInput) : void {
         this.objectId=input.readInt();
         if(this.objectId<0)
         {
            throw new Error("Forbidden value ("+this.objectId+") on element of ExchangeShopStockMovementRemovedMessage.objectId.");
         }
         else
         {
            return;
         }
      }
   }

}