package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectGroundRemovedMultipleMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectGroundRemovedMultipleMessage() {
         this.cells = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5944;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var cells:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 5944;
      }
      
      public function initObjectGroundRemovedMultipleMessage(param1:Vector.<uint>=null) : ObjectGroundRemovedMultipleMessage {
         this.cells = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.cells = new Vector.<uint>();
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
         this.serializeAs_ObjectGroundRemovedMultipleMessage(param1);
      }
      
      public function serializeAs_ObjectGroundRemovedMultipleMessage(param1:IDataOutput) : void {
         param1.writeShort(this.cells.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.cells.length)
         {
            if(this.cells[_loc2_] < 0 || this.cells[_loc2_] > 559)
            {
               throw new Error("Forbidden value (" + this.cells[_loc2_] + ") on element 1 (starting at 1) of cells.");
            }
            else
            {
               param1.writeShort(this.cells[_loc2_]);
               _loc2_++;
               continue;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectGroundRemovedMultipleMessage(param1);
      }
      
      public function deserializeAs_ObjectGroundRemovedMultipleMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readShort();
            if(_loc4_ < 0 || _loc4_ > 559)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of cells.");
            }
            else
            {
               this.cells.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
      }
   }
}
