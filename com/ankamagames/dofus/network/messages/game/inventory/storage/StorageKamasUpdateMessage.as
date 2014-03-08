package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StorageKamasUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StorageKamasUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 5645;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var kamasTotal:int = 0;
      
      override public function getMessageId() : uint {
         return 5645;
      }
      
      public function initStorageKamasUpdateMessage(param1:int=0) : StorageKamasUpdateMessage {
         this.kamasTotal = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.kamasTotal = 0;
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
         this.serializeAs_StorageKamasUpdateMessage(param1);
      }
      
      public function serializeAs_StorageKamasUpdateMessage(param1:IDataOutput) : void {
         param1.writeInt(this.kamasTotal);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_StorageKamasUpdateMessage(param1);
      }
      
      public function deserializeAs_StorageKamasUpdateMessage(param1:IDataInput) : void {
         this.kamasTotal = param1.readInt();
      }
   }
}
