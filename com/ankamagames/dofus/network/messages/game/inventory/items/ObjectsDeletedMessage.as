package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectsDeletedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectsDeletedMessage() {
         this.objectUID = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6034;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectUID:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6034;
      }
      
      public function initObjectsDeletedMessage(objectUID:Vector.<uint> = null) : ObjectsDeletedMessage {
         this.objectUID = objectUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectUID = new Vector.<uint>();
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
         this.serializeAs_ObjectsDeletedMessage(output);
      }
      
      public function serializeAs_ObjectsDeletedMessage(output:IDataOutput) : void {
         output.writeShort(this.objectUID.length);
         var _i1:uint = 0;
         while(_i1 < this.objectUID.length)
         {
            if(this.objectUID[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID[_i1] + ") on element 1 (starting at 1) of objectUID.");
            }
            else
            {
               output.writeInt(this.objectUID[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectsDeletedMessage(input);
      }
      
      public function deserializeAs_ObjectsDeletedMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _objectUIDLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _objectUIDLen)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of objectUID.");
            }
            else
            {
               this.objectUID.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
