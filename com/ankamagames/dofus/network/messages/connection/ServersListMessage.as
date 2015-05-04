package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ServersListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServersListMessage()
      {
         this.servers = new Vector.<GameServerInformations>();
         super();
      }
      
      public static const protocolId:uint = 30;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var servers:Vector.<GameServerInformations>;
      
      override public function getMessageId() : uint
      {
         return 30;
      }
      
      public function initServersListMessage(param1:Vector.<GameServerInformations> = null) : ServersListMessage
      {
         this.servers = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.servers = new Vector.<GameServerInformations>();
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
         this.serializeAs_ServersListMessage(param1);
      }
      
      public function serializeAs_ServersListMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.servers.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.servers.length)
         {
            (this.servers[_loc2_] as GameServerInformations).serializeAs_GameServerInformations(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ServersListMessage(param1);
      }
      
      public function deserializeAs_ServersListMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:GameServerInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new GameServerInformations();
            _loc4_.deserialize(param1);
            this.servers.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
