package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMountPaddockAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMountPaddockAddMessage() {
         this.mountDescription = new MountClientData();
         super();
      }
      
      public static const protocolId:uint = 6049;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountDescription:MountClientData;
      
      override public function getMessageId() : uint {
         return 6049;
      }
      
      public function initExchangeMountPaddockAddMessage(param1:MountClientData=null) : ExchangeMountPaddockAddMessage {
         this.mountDescription = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountDescription = new MountClientData();
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
         this.serializeAs_ExchangeMountPaddockAddMessage(param1);
      }
      
      public function serializeAs_ExchangeMountPaddockAddMessage(param1:IDataOutput) : void {
         this.mountDescription.serializeAs_MountClientData(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeMountPaddockAddMessage(param1);
      }
      
      public function deserializeAs_ExchangeMountPaddockAddMessage(param1:IDataInput) : void {
         this.mountDescription = new MountClientData();
         this.mountDescription.deserialize(param1);
      }
   }
}
