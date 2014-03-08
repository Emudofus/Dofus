package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismsListUpdateMessage extends PrismsListMessage implements INetworkMessage
   {
      
      public function PrismsListUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6438;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6438;
      }
      
      public function initPrismsListUpdateMessage(prisms:Vector.<PrismSubareaEmptyInfo>=null) : PrismsListUpdateMessage {
         super.initPrismsListMessage(prisms);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
         this.serializeAs_PrismsListUpdateMessage(output);
      }
      
      public function serializeAs_PrismsListUpdateMessage(output:IDataOutput) : void {
         super.serializeAs_PrismsListMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismsListUpdateMessage(input);
      }
      
      public function deserializeAs_PrismsListUpdateMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
