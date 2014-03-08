package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ServerSelectionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerSelectionMessage() {
         super();
      }
      
      public static const protocolId:uint = 40;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var serverId:int = 0;
      
      override public function getMessageId() : uint {
         return 40;
      }
      
      public function initServerSelectionMessage(serverId:int=0) : ServerSelectionMessage {
         this.serverId = serverId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.serverId = 0;
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
         this.serializeAs_ServerSelectionMessage(output);
      }
      
      public function serializeAs_ServerSelectionMessage(output:IDataOutput) : void {
         output.writeShort(this.serverId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerSelectionMessage(input);
      }
      
      public function deserializeAs_ServerSelectionMessage(input:IDataInput) : void {
         this.serverId = input.readShort();
      }
   }
}
