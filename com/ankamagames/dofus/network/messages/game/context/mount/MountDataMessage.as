package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountDataMessage() {
         this.mountData = new MountClientData();
         super();
      }
      
      public static const protocolId:uint = 5973;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountData:MountClientData;
      
      override public function getMessageId() : uint {
         return 5973;
      }
      
      public function initMountDataMessage(param1:MountClientData=null) : MountDataMessage {
         this.mountData = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountData = new MountClientData();
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
         this.serializeAs_MountDataMessage(param1);
      }
      
      public function serializeAs_MountDataMessage(param1:IDataOutput) : void {
         this.mountData.serializeAs_MountClientData(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MountDataMessage(param1);
      }
      
      public function deserializeAs_MountDataMessage(param1:IDataInput) : void {
         this.mountData = new MountClientData();
         this.mountData.deserialize(param1);
      }
   }
}
