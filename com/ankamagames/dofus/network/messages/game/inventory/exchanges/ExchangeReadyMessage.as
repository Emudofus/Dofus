package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeReadyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5511;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ready:Boolean = false;
      
      public var step:uint = 0;
      
      override public function getMessageId() : uint {
         return 5511;
      }
      
      public function initExchangeReadyMessage(param1:Boolean=false, param2:uint=0) : ExchangeReadyMessage {
         this.ready = param1;
         this.step = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ready = false;
         this.step = 0;
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
         this.serializeAs_ExchangeReadyMessage(param1);
      }
      
      public function serializeAs_ExchangeReadyMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.ready);
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element step.");
         }
         else
         {
            param1.writeShort(this.step);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeReadyMessage(param1);
      }
      
      public function deserializeAs_ExchangeReadyMessage(param1:IDataInput) : void {
         this.ready = param1.readBoolean();
         this.step = param1.readShort();
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element of ExchangeReadyMessage.step.");
         }
         else
         {
            return;
         }
      }
   }
}
