package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetUseResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetUseResultMessage() {
         this.unlinkedPosition = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6163;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var code:uint = 3;
      
      public var unlinkedPosition:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6163;
      }
      
      public function initInventoryPresetUseResultMessage(presetId:uint = 0, code:uint = 3, unlinkedPosition:Vector.<uint> = null) : InventoryPresetUseResultMessage {
         this.presetId = presetId;
         this.code = code;
         this.unlinkedPosition = unlinkedPosition;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
         this.code = 3;
         this.unlinkedPosition = new Vector.<uint>();
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
         this.serializeAs_InventoryPresetUseResultMessage(output);
      }
      
      public function serializeAs_InventoryPresetUseResultMessage(output:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            output.writeByte(this.presetId);
            output.writeByte(this.code);
            output.writeShort(this.unlinkedPosition.length);
            _i3 = 0;
            while(_i3 < this.unlinkedPosition.length)
            {
               output.writeByte(this.unlinkedPosition[_i3]);
               _i3++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryPresetUseResultMessage(input);
      }
      
      public function deserializeAs_InventoryPresetUseResultMessage(input:IDataInput) : void {
         var _val3:uint = 0;
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetUseResultMessage.presetId.");
         }
         else
         {
            this.code = input.readByte();
            if(this.code < 0)
            {
               throw new Error("Forbidden value (" + this.code + ") on element of InventoryPresetUseResultMessage.code.");
            }
            else
            {
               _unlinkedPositionLen = input.readUnsignedShort();
               _i3 = 0;
               while(_i3 < _unlinkedPositionLen)
               {
                  _val3 = input.readUnsignedByte();
                  if((_val3 < 0) || (_val3 > 255))
                  {
                     throw new Error("Forbidden value (" + _val3 + ") on elements of unlinkedPosition.");
                  }
                  else
                  {
                     this.unlinkedPosition.push(_val3);
                     _i3++;
                     continue;
                  }
               }
               return;
            }
         }
      }
   }
}
