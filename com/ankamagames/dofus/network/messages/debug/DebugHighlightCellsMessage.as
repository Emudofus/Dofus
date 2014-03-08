package com.ankamagames.dofus.network.messages.debug
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DebugHighlightCellsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DebugHighlightCellsMessage() {
         this.cells = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 2001;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var color:int = 0;
      
      public var cells:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 2001;
      }
      
      public function initDebugHighlightCellsMessage(color:int=0, cells:Vector.<uint>=null) : DebugHighlightCellsMessage {
         this.color = color;
         this.cells = cells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.color = 0;
         this.cells = new Vector.<uint>();
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
         this.serializeAs_DebugHighlightCellsMessage(output);
      }
      
      public function serializeAs_DebugHighlightCellsMessage(output:IDataOutput) : void {
         output.writeInt(this.color);
         output.writeShort(this.cells.length);
         var _i2:uint = 0;
         while(_i2 < this.cells.length)
         {
            if((this.cells[_i2] < 0) || (this.cells[_i2] > 559))
            {
               throw new Error("Forbidden value (" + this.cells[_i2] + ") on element 2 (starting at 1) of cells.");
            }
            else
            {
               output.writeShort(this.cells[_i2]);
               _i2++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DebugHighlightCellsMessage(input);
      }
      
      public function deserializeAs_DebugHighlightCellsMessage(input:IDataInput) : void {
         var _val2:uint = 0;
         this.color = input.readInt();
         var _cellsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _cellsLen)
         {
            _val2 = input.readShort();
            if((_val2 < 0) || (_val2 > 559))
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of cells.");
            }
            else
            {
               this.cells.push(_val2);
               _i2++;
               continue;
            }
         }
      }
   }
}
