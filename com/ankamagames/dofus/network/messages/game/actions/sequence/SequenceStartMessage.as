package com.ankamagames.dofus.network.messages.game.actions.sequence
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SequenceStartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SequenceStartMessage() {
         super();
      }
      
      public static const protocolId:uint = 955;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var sequenceType:int = 0;
      
      public var authorId:int = 0;
      
      override public function getMessageId() : uint {
         return 955;
      }
      
      public function initSequenceStartMessage(param1:int=0, param2:int=0) : SequenceStartMessage {
         this.sequenceType = param1;
         this.authorId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sequenceType = 0;
         this.authorId = 0;
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
         this.serializeAs_SequenceStartMessage(param1);
      }
      
      public function serializeAs_SequenceStartMessage(param1:IDataOutput) : void {
         param1.writeByte(this.sequenceType);
         param1.writeInt(this.authorId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SequenceStartMessage(param1);
      }
      
      public function deserializeAs_SequenceStartMessage(param1:IDataInput) : void {
         this.sequenceType = param1.readByte();
         this.authorId = param1.readInt();
      }
   }
}
