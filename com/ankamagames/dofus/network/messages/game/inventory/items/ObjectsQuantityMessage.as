package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initObjectsQuantityMessage(objectsUIDAndQty:Vector.<ObjectItemQuantity> = null) : ObjectsQuantityMessage {
         this.objectsUIDAndQty = objectsUIDAndQty;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectsQuantityMessage(output);
      }
      
      public function serializeAs_ObjectsQuantityMessage(output:IDataOutput) : void {
         output.writeShort(this.objectsUIDAndQty.length);
         var _i1:uint = 0;
         while(_i1 < this.objectsUIDAndQty.length)
         {
            (this.objectsUIDAndQty[_i1] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectsQuantityMessage(input);
      }
      
      public function deserializeAs_ObjectsQuantityMessage(input:IDataInput) : void {
         var _item1:ObjectItemQuantity = null;
         var _objectsUIDAndQtyLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _objectsUIDAndQtyLen)
         {
            _item1 = new ObjectItemQuantity();
            _item1.deserialize(input);
            this.objectsUIDAndQty.push(_item1);
            _i1++;
         }
      }
   }
}
