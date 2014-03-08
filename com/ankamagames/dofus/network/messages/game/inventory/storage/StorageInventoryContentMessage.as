package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.dofus.network.messages.game.inventory.items.InventoryContentMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StorageInventoryContentMessage extends InventoryContentMessage implements INetworkMessage
   {
      
      public function StorageInventoryContentMessage() {
         super();
      }
      
      public static const protocolId:uint = 5646;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5646;
      }
      
      public function initStorageInventoryContentMessage(param1:Vector.<ObjectItem>=null, param2:uint=0) : StorageInventoryContentMessage {
         super.initInventoryContentMessage(param1,param2);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_StorageInventoryContentMessage(param1);
      }
      
      public function serializeAs_StorageInventoryContentMessage(param1:IDataOutput) : void {
         super.serializeAs_InventoryContentMessage(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_StorageInventoryContentMessage(param1);
      }
      
      public function deserializeAs_StorageInventoryContentMessage(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
