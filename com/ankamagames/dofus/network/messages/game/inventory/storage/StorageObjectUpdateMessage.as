package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StorageObjectUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StorageObjectUpdateMessage() {
         this.object = new ObjectItem();
         super();
      }
      
      public static const protocolId:uint = 5647;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var object:ObjectItem;
      
      override public function getMessageId() : uint {
         return 5647;
      }
      
      public function initStorageObjectUpdateMessage(param1:ObjectItem=null) : StorageObjectUpdateMessage {
         this.object = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.object = new ObjectItem();
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
         this.serializeAs_StorageObjectUpdateMessage(param1);
      }
      
      public function serializeAs_StorageObjectUpdateMessage(param1:IDataOutput) : void {
         this.object.serializeAs_ObjectItem(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_StorageObjectUpdateMessage(param1);
      }
      
      public function deserializeAs_StorageObjectUpdateMessage(param1:IDataInput) : void {
         this.object = new ObjectItem();
         this.object.deserialize(param1);
      }
   }
}
