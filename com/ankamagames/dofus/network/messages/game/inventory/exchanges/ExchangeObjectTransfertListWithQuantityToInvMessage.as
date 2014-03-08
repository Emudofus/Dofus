package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectTransfertListWithQuantityToInvMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeObjectTransfertListWithQuantityToInvMessage() {
         this.ids = new Vector.<uint>();
         this.qtys = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6470;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ids:Vector.<uint>;
      
      public var qtys:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6470;
      }
      
      public function initExchangeObjectTransfertListWithQuantityToInvMessage(ids:Vector.<uint>=null, qtys:Vector.<uint>=null) : ExchangeObjectTransfertListWithQuantityToInvMessage {
         this.ids = ids;
         this.qtys = qtys;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ids = new Vector.<uint>();
         this.qtys = new Vector.<uint>();
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
         this.serializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(output);
      }
      
      public function serializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(output:IDataOutput) : void {
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
               output.writeInt(this.ids[_i1]);
               _i1++;
               continue;
            }
         }
         output.writeShort(this.qtys.length);
         var _i2:uint = 0;
         while(_i2 < this.qtys.length)
         {
            if(this.qtys[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.qtys[_i2] + ") on element 2 (starting at 1) of qtys.");
            }
            else
            {
               output.writeInt(this.qtys[_i2]);
               _i2++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _idsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _idsLen)
         {
            _val1 = input.readInt();
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
         var _qtysLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _qtysLen)
         {
            _val2 = input.readInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of qtys.");
            }
            else
            {
               this.qtys.push(_val2);
               _i2++;
               continue;
            }
         }
      }
   }
}
