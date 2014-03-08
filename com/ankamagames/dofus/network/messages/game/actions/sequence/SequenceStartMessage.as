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
      
      public function initSequenceStartMessage(sequenceType:int=0, authorId:int=0) : SequenceStartMessage {
         this.sequenceType = sequenceType;
         this.authorId = authorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sequenceType = 0;
         this.authorId = 0;
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
         this.serializeAs_SequenceStartMessage(output);
      }
      
      public function serializeAs_SequenceStartMessage(output:IDataOutput) : void {
         output.writeByte(this.sequenceType);
         output.writeInt(this.authorId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SequenceStartMessage(input);
      }
      
      public function deserializeAs_SequenceStartMessage(input:IDataInput) : void {
         this.sequenceType = input.readByte();
         this.authorId = input.readInt();
      }
   }
}
