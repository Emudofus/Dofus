package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ServerStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerStatusUpdateMessage() {
         this.server = new GameServerInformations();
         super();
      }
      
      public static const protocolId:uint = 50;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var server:GameServerInformations;
      
      override public function getMessageId() : uint {
         return 50;
      }
      
      public function initServerStatusUpdateMessage(server:GameServerInformations = null) : ServerStatusUpdateMessage {
         this.server = server;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.server = new GameServerInformations();
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
         this.serializeAs_ServerStatusUpdateMessage(output);
      }
      
      public function serializeAs_ServerStatusUpdateMessage(output:IDataOutput) : void {
         this.server.serializeAs_GameServerInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerStatusUpdateMessage(input);
      }
      
      public function deserializeAs_ServerStatusUpdateMessage(input:IDataInput) : void {
         this.server = new GameServerInformations();
         this.server.deserialize(input);
      }
   }
}
