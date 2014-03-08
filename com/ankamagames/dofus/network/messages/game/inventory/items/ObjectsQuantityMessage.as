package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectsQuantityMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectsQuantityMessage() {
         this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
         super();
      }
      
      public static const protocolId:uint = 6206;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectsUIDAndQty:Vector.<ObjectItemQuantity>;
      
      override public function getMessageId() : uint {
         return 6206;
      }
      
      public function initObjectsQuantityMessage(param1:Vector.<ObjectItemQuantity>=null) : ObjectsQuantityMessage {
         this.objectsUIDAndQty = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
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
         this.serializeAs_ObjectsQuantityMessage(param1);
      }
      
      public function serializeAs_ObjectsQuantityMessage(param1:IDataOutput) : void {
         param1.writeShort(this.objectsUIDAndQty.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.objectsUIDAndQty.length)
         {
            (this.objectsUIDAndQty[_loc2_] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectsQuantityMessage(param1);
      }
      
      public function deserializeAs_ObjectsQuantityMessage(param1:IDataInput) : void {
         var _loc4_:ObjectItemQuantity = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ObjectItemQuantity();
            _loc4_.deserialize(param1);
            this.objectsUIDAndQty.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
