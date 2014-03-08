package com.ankamagames.dofus.network.messages.game.actions.sequence
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SequenceEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SequenceEndMessage() {
         super();
      }
      
      public static const protocolId:uint = 956;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var actionId:uint = 0;
      
      public var authorId:int = 0;
      
      public var sequenceType:int = 0;
      
      override public function getMessageId() : uint {
         return 956;
      }
      
      public function initSequenceEndMessage(param1:uint=0, param2:int=0, param3:int=0) : SequenceEndMessage {
         this.actionId = param1;
         this.authorId = param2;
         this.sequenceType = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.actionId = 0;
         this.authorId = 0;
         this.sequenceType = 0;
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
         this.serializeAs_SequenceEndMessage(param1);
      }
      
      public function serializeAs_SequenceEndMessage(param1:IDataOutput) : void {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         else
         {
            param1.writeShort(this.actionId);
            param1.writeInt(this.authorId);
            param1.writeByte(this.sequenceType);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SequenceEndMessage(param1);
      }
      
      public function deserializeAs_SequenceEndMessage(param1:IDataInput) : void {
         this.actionId = param1.readShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of SequenceEndMessage.actionId.");
         }
         else
         {
            this.authorId = param1.readInt();
            this.sequenceType = param1.readByte();
            return;
         }
      }
   }
}
