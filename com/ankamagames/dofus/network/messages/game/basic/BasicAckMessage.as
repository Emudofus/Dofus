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
      
      public function initBasicAckMessage(param1:uint=0, param2:uint=0) : BasicAckMessage {
         this.seq = param1;
         this.lastPacketId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.seq = 0;
         this.lastPacketId = 0;
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
         this.serializeAs_BasicAckMessage(param1);
      }
      
      public function serializeAs_BasicAckMessage(param1:IDataOutput) : void {
         if(this.seq < 0)
         {
            throw new Error("Forbidden value (" + this.seq + ") on element seq.");
         }
         else
         {
            param1.writeInt(this.seq);
            if(this.lastPacketId < 0)
            {
               throw new Error("Forbidden value (" + this.lastPacketId + ") on element lastPacketId.");
            }
            else
            {
               param1.writeShort(this.lastPacketId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicAckMessage(param1);
      }
      
      public function deserializeAs_BasicAckMessage(param1:IDataInput) : void {
         this.seq = param1.readInt();
         if(this.seq < 0)
         {
            throw new Error("Forbidden value (" + this.seq + ") on element of BasicAckMessage.seq.");
         }
         else
         {
            this.lastPacketId = param1.readShort();
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
