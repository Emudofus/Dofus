package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ServerStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerStatusUpdateMessage()
      {
         this.server = new GameServerInformations();
         super();
      }
      
      public static const protocolId:uint = 50;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var server:GameServerInformations;
      
      override public function getMessageId() : uint
      {
         return 50;
      }
      
      public function initServerStatusUpdateMessage(param1:GameServerInformations = null) : ServerStatusUpdateMessage
      {
         this.server = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.server = new GameServerInformations();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ServerStatusUpdateMessage(param1);
      }
      
      public function serializeAs_ServerStatusUpdateMessage(param1:ICustomDataOutput) : void
      {
         this.server.serializeAs_GameServerInformations(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ServerStatusUpdateMessage(param1);
      }
      
      public function deserializeAs_ServerStatusUpdateMessage(param1:ICustomDataInput) : void
      {
         this.server = new GameServerInformations();
         this.server.deserialize(param1);
      }
   }
}
