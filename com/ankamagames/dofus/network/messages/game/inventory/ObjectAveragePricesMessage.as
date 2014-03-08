package com.ankamagames.dofus.network.messages.game.inventory
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectAveragePricesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectAveragePricesMessage() {
         this.ids = new Vector.<uint>();
         this.avgPrices = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6335;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ids:Vector.<uint>;
      
      public var avgPrices:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6335;
      }
      
      public function initObjectAveragePricesMessage(ids:Vector.<uint>=null, avgPrices:Vector.<uint>=null) : ObjectAveragePricesMessage {
         this.ids = ids;
         this.avgPrices = avgPrices;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ids = new Vector.<uint>();
         this.avgPrices = new Vector.<uint>();
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
         this.serializeAs_ObjectAveragePricesMessage(output);
      }
      
      public function serializeAs_ObjectAveragePricesMessage(output:IDataOutput) : void {
         output.writeShort(this.ids.length);
         var _i1:uint = 0;
         while(_i1 < this.ids.length)
         {
            if(this.ids[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.ids[_i1] + ") on element 1 (starting at 1) of ids.");
            }
            else
            {
               output.writeShort(this.ids[_i1]);
               _i1++;
               continue;
            }
         }
         output.writeShort(this.avgPrices.length);
         var _i2:uint = 0;
         while(_i2 < this.avgPrices.length)
         {
            if(this.avgPrices[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.avgPrices[_i2] + ") on element 2 (starting at 1) of avgPrices.");
            }
            else
            {
               output.writeInt(this.avgPrices[_i2]);
               _i2++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectAveragePricesMessage(input);
      }
      
      public function deserializeAs_ObjectAveragePricesMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _idsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _idsLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of ids.");
            }
            else
            {
               this.ids.push(_val1);
               _i1++;
               continue;
            }
         }
         var _avgPricesLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _avgPricesLen)
         {
            _val2 = input.readInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of avgPrices.");
            }
            else
            {
               this.avgPrices.push(_val2);
               _i2++;
               continue;
            }
         }
      }
   }
}
