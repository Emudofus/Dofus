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
      
      public function initServerSelectionMessage(param1:int=0) : ServerSelectionMessage {
         this.serverId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.serverId = 0;
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
         this.serializeAs_ServerSelectionMessage(param1);
      }
      
      public function serializeAs_ServerSelectionMessage(param1:IDataOutput) : void {
         param1.writeShort(this.serverId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ServerSelectionMessage(param1);
      }
      
      public function deserializeAs_ServerSelectionMessage(param1:IDataInput) : void {
         this.serverId = param1.readShort();
      }
   }
}
