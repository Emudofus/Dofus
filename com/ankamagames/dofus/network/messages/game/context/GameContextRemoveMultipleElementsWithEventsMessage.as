package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
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
      
      public function initGameContextRemoveMultipleElementsWithEventsMessage(id:Vector.<int>=null, elementEventIds:Vector.<uint>=null) : GameContextRemoveMultipleElementsWithEventsMessage {
         super.initGameContextRemoveMultipleElementsMessage(id);
         this.elementEventIds = elementEventIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.elementEventIds = new Vector.<uint>();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(output);
      }
      
      public function serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(output:IDataOutput) : void {
         super.serializeAs_GameContextRemoveMultipleElementsMessage(output);
         output.writeShort(this.elementEventIds.length);
         var _i1:uint = 0;
         while(_i1 < this.elementEventIds.length)
         {
            if(this.elementEventIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.elementEventIds[_i1] + ") on element 1 (starting at 1) of elementEventIds.");
            }
            else
            {
               output.writeByte(this.elementEventIds[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(input);
      }
      
      public function deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         super.deserialize(input);
         var _elementEventIdsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _elementEventIdsLen)
         {
            _val1 = input.readByte();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of elementEventIds.");
            }
            else
            {
               this.elementEventIds.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
