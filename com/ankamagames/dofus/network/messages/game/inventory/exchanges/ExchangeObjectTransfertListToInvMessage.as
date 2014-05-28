package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectTransfertListToInvMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeObjectTransfertListToInvMessage() {
         this.ids = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6039;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ids:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6039;
      }
      
      public function initExchangeObjectTransfertListToInvMessage(ids:Vector.<uint> = null) : ExchangeObjectTransfertListToInvMessage {
         this.ids = ids;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ids = new Vector.<uint>();
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
         this.serializeAs_ExchangeObjectTransfertListToInvMessage(output);
      }
      
      public function serializeAs_ExchangeObjectTransfertListToInvMessage(output:IDataOutput) : void {
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
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectTransfertListToInvMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectTransfertListToInvMessage(input:IDataInput) : void {
         var _val1:uint = 0;
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
      }
   }
}
