package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismSetSabotagedRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismSetSabotagedRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6468;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6468;
      }
      
      public function initPrismSetSabotagedRequestMessage(subAreaId:uint = 0) : PrismSetSabotagedRequestMessage {
         this.subAreaId = subAreaId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PrismSetSabotagedRequestMessage(output);
      }
      
      public function serializeAs_PrismSetSabotagedRequestMessage(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismSetSabotagedRequestMessage(input);
      }
      
      public function deserializeAs_PrismSetSabotagedRequestMessage(input:IDataInput) : void {
         this.subAreaId = input.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSetSabotagedRequestMessage.subAreaId.");
         }
         else
         {
            return;
         }
      }
   }
}
