package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeCraftResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeCraftResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5790;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var craftResult:uint = 0;
      
      override public function getMessageId() : uint {
         return 5790;
      }
      
      public function initExchangeCraftResultMessage(param1:uint=0) : ExchangeCraftResultMessage {
         this.craftResult = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.craftResult = 0;
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
         this.serializeAs_ExchangeCraftResultMessage(param1);
      }
      
      public function serializeAs_ExchangeCraftResultMessage(param1:IDataOutput) : void {
         param1.writeByte(this.craftResult);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeCraftResultMessage(param1);
      }
      
      public function deserializeAs_ExchangeCraftResultMessage(param1:IDataInput) : void {
         this.craftResult = param1.readByte();
         if(this.craftResult < 0)
         {
            throw new Error("Forbidden value (" + this.craftResult + ") on element of ExchangeCraftResultMessage.craftResult.");
         }
         else
         {
            return;
         }
      }
   }
}
