package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PartsListMessage() {
         this.parts = new Vector.<ContentPart>();
         super();
      }
      
      public static const protocolId:uint = 1502;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var parts:Vector.<ContentPart>;
      
      override public function getMessageId() : uint {
         return 1502;
      }
      
      public function initPartsListMessage(parts:Vector.<ContentPart>=null) : PartsListMessage {
         this.parts = parts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.parts = new Vector.<ContentPart>();
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
         this.serializeAs_PartsListMessage(output);
      }
      
      public function serializeAs_PartsListMessage(output:IDataOutput) : void {
         output.writeShort(this.parts.length);
         var _i1:uint = 0;
         while(_i1 < this.parts.length)
         {
            (this.parts[_i1] as ContentPart).serializeAs_ContentPart(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartsListMessage(input);
      }
      
      public function deserializeAs_PartsListMessage(input:IDataInput) : void {
         var _item1:ContentPart = null;
         var _partsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _partsLen)
         {
            _item1 = new ContentPart();
            _item1.deserialize(input);
            this.parts.push(_item1);
            _i1++;
         }
      }
   }
}
