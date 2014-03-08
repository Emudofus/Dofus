package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicAckMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicAckMessage() {
         super();
      }
      
      public static const protocolId:uint = 6362;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var seq:uint = 0;
      
      public var lastPacketId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6362;
      }
      
      public function initBasicAckMessage(seq:uint=0, lastPacketId:uint=0) : BasicAckMessage {
         this.seq = seq;
         this.lastPacketId = lastPacketId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.seq = 0;
         this.lastPacketId = 0;
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
         this.serializeAs_BasicAckMessage(output);
      }
      
      public function serializeAs_BasicAckMessage(output:IDataOutput) : void {
         if(this.seq < 0)
         {
            throw new Error("Forbidden value (" + this.seq + ") on element seq.");
         }
         else
         {
            output.writeInt(this.seq);
            if(this.lastPacketId < 0)
            {
               throw new Error("Forbidden value (" + this.lastPacketId + ") on element lastPacketId.");
            }
            else
            {
               output.writeShort(this.lastPacketId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicAckMessage(input);
      }
      
      public function deserializeAs_BasicAckMessage(input:IDataInput) : void {
         this.seq = input.readInt();
         if(this.seq < 0)
         {
            throw new Error("Forbidden value (" + this.seq + ") on element of BasicAckMessage.seq.");
         }
         else
         {
            this.lastPacketId = input.readShort();
            if(this.lastPacketId < 0)
            {
               throw new Error("Forbidden value (" + this.lastPacketId + ") on element of BasicAckMessage.lastPacketId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
