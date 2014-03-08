package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeIsReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeIsReadyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5509;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      public var ready:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5509;
      }
      
      public function initExchangeIsReadyMessage(param1:uint=0, param2:Boolean=false) : ExchangeIsReadyMessage {
         this.id = param1;
         this.ready = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
         this.ready = false;
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
         this.serializeAs_ExchangeIsReadyMessage(param1);
      }
      
      public function serializeAs_ExchangeIsReadyMessage(param1:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeInt(this.id);
            param1.writeBoolean(this.ready);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeIsReadyMessage(param1);
      }
      
      public function deserializeAs_ExchangeIsReadyMessage(param1:IDataInput) : void {
         this.id = param1.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ExchangeIsReadyMessage.id.");
         }
         else
         {
            this.ready = param1.readBoolean();
            return;
         }
      }
   }
}
