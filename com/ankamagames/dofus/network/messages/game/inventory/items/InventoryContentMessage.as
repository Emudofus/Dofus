package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryContentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryContentMessage() {
         this.objects = new Vector.<ObjectItem>();
         super();
      }
      
      public static const protocolId:uint = 3016;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objects:Vector.<ObjectItem>;
      
      public var kamas:uint = 0;
      
      override public function getMessageId() : uint {
         return 3016;
      }
      
      public function initInventoryContentMessage(objects:Vector.<ObjectItem>=null, kamas:uint=0) : InventoryContentMessage {
         this.objects = objects;
         this.kamas = kamas;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objects = new Vector.<ObjectItem>();
         this.kamas = 0;
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
         this.serializeAs_InventoryContentMessage(output);
      }
      
      public function serializeAs_InventoryContentMessage(output:IDataOutput) : void {
         output.writeShort(this.objects.length);
         var _i1:uint = 0;
         while(_i1 < this.objects.length)
         {
            (this.objects[_i1] as ObjectItem).serializeAs_ObjectItem(output);
            _i1++;
         }
         if(this.kamas < 0)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         else
         {
            output.writeInt(this.kamas);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryContentMessage(input);
      }
      
      public function deserializeAs_InventoryContentMessage(input:IDataInput) : void {
         var _item1:ObjectItem = null;
         var _objectsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _objectsLen)
         {
            _item1 = new ObjectItem();
            _item1.deserialize(input);
            this.objects.push(_item1);
            _i1++;
         }
         this.kamas = input.readInt();
         if(this.kamas < 0)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of InventoryContentMessage.kamas.");
         }
         else
         {
            return;
         }
      }
   }
}
