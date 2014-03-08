package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeTypesExchangerDescriptionForUserMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeTypesExchangerDescriptionForUserMessage() {
         this.typeDescription = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5765;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var typeDescription:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 5765;
      }
      
      public function initExchangeTypesExchangerDescriptionForUserMessage(typeDescription:Vector.<uint>=null) : ExchangeTypesExchangerDescriptionForUserMessage {
         this.typeDescription = typeDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.typeDescription = new Vector.<uint>();
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
         this.serializeAs_ExchangeTypesExchangerDescriptionForUserMessage(output);
      }
      
      public function serializeAs_ExchangeTypesExchangerDescriptionForUserMessage(output:IDataOutput) : void {
         output.writeShort(this.typeDescription.length);
         var _i1:uint = 0;
         while(_i1 < this.typeDescription.length)
         {
            if(this.typeDescription[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.typeDescription[_i1] + ") on element 1 (starting at 1) of typeDescription.");
            }
            else
            {
               output.writeInt(this.typeDescription[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeTypesExchangerDescriptionForUserMessage(input);
      }
      
      public function deserializeAs_ExchangeTypesExchangerDescriptionForUserMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _typeDescriptionLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _typeDescriptionLen)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of typeDescription.");
            }
            else
            {
               this.typeDescription.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
