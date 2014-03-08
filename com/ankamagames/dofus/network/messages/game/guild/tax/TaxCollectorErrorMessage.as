package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TaxCollectorErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5634;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:int = 0;
      
      override public function getMessageId() : uint {
         return 5634;
      }
      
      public function initTaxCollectorErrorMessage(param1:int=0) : TaxCollectorErrorMessage {
         this.reason = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 0;
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
         this.serializeAs_TaxCollectorErrorMessage(param1);
      }
      
      public function serializeAs_TaxCollectorErrorMessage(param1:IDataOutput) : void {
         param1.writeByte(this.reason);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TaxCollectorErrorMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorErrorMessage(param1:IDataInput) : void {
         this.reason = param1.readByte();
      }
   }
}
