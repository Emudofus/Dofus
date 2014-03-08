package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StorageObjectsUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StorageObjectsUpdateMessage() {
         this.objectList = new Vector.<ObjectItem>();
         super();
      }
      
      public static const protocolId:uint = 6036;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectList:Vector.<ObjectItem>;
      
      override public function getMessageId() : uint {
         return 6036;
      }
      
      public function initStorageObjectsUpdateMessage(param1:Vector.<ObjectItem>=null) : StorageObjectsUpdateMessage {
         this.objectList = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectList = new Vector.<ObjectItem>();
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
         this.serializeAs_StorageObjectsUpdateMessage(param1);
      }
      
      public function serializeAs_StorageObjectsUpdateMessage(param1:IDataOutput) : void {
         param1.writeShort(this.objectList.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.objectList.length)
         {
            (this.objectList[_loc2_] as ObjectItem).serializeAs_ObjectItem(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_StorageObjectsUpdateMessage(param1);
      }
      
      public function deserializeAs_StorageObjectsUpdateMessage(param1:IDataInput) : void {
         var _loc4_:ObjectItem = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ObjectItem();
            _loc4_.deserialize(param1);
            this.objectList.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
