package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextRemoveMultipleElementsWithEventsMessage extends GameContextRemoveMultipleElementsMessage implements INetworkMessage
   {
      
      public function GameContextRemoveMultipleElementsWithEventsMessage() {
         this.elementEventIds = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6416;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var elementEventIds:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6416;
      }
      
      public function initGameContextRemoveMultipleElementsWithEventsMessage(param1:Vector.<int>=null, param2:Vector.<uint>=null) : GameContextRemoveMultipleElementsWithEventsMessage {
         super.initGameContextRemoveMultipleElementsMessage(param1);
         this.elementEventIds = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.elementEventIds = new Vector.<uint>();
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
         this.serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(param1);
      }
      
      public function serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(param1:IDataOutput) : void {
         super.serializeAs_GameContextRemoveMultipleElementsMessage(param1);
         param1.writeShort(this.elementEventIds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.elementEventIds.length)
         {
            if(this.elementEventIds[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.elementEventIds[_loc2_] + ") on element 1 (starting at 1) of elementEventIds.");
            }
            else
            {
               param1.writeByte(this.elementEventIds[_loc2_]);
               _loc2_++;
               continue;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(param1);
      }
      
      public function deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readByte();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of elementEventIds.");
            }
            else
            {
               this.elementEventIds.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
      }
   }
}
