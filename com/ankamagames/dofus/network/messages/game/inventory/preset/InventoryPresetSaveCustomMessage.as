package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetSaveCustomMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetSaveCustomMessage() {
         this.itemsPositions = new Vector.<uint>();
         this.itemsUids = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6329;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var symbolId:uint = 0;
      
      public var itemsPositions:Vector.<uint>;
      
      public var itemsUids:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6329;
      }
      
      public function initInventoryPresetSaveCustomMessage(presetId:uint = 0, symbolId:uint = 0, itemsPositions:Vector.<uint> = null, itemsUids:Vector.<uint> = null) : InventoryPresetSaveCustomMessage {
         this.presetId = presetId;
         this.symbolId = symbolId;
         this.itemsPositions = itemsPositions;
         this.itemsUids = itemsUids;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
         this.symbolId = 0;
         this.itemsPositions = new Vector.<uint>();
         this.itemsUids = new Vector.<uint>();
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
         this.serializeAs_InventoryPresetSaveCustomMessage(output);
      }
      
      public function serializeAs_InventoryPresetSaveCustomMessage(output:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            output.writeByte(this.presetId);
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element symbolId.");
            }
            else
            {
               output.writeByte(this.symbolId);
               output.writeShort(this.itemsPositions.length);
               _i3 = 0;
               while(_i3 < this.itemsPositions.length)
               {
                  output.writeByte(this.itemsPositions[_i3]);
                  _i3++;
               }
               output.writeShort(this.itemsUids.length);
               _i4 = 0;
               while(_i4 < this.itemsUids.length)
               {
                  if(this.itemsUids[_i4] < 0)
                  {
                     throw new Error("Forbidden value (" + this.itemsUids[_i4] + ") on element 4 (starting at 1) of itemsUids.");
                  }
                  else
                  {
                     output.writeInt(this.itemsUids[_i4]);
                     _i4++;
                     continue;
                  }
               }
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryPresetSaveCustomMessage(input);
      }
      
      public function deserializeAs_InventoryPresetSaveCustomMessage(input:IDataInput) : void {
         var _val3:uint = 0;
         var _val4:uint = 0;
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetSaveCustomMessage.presetId.");
         }
         else
         {
            this.symbolId = input.readByte();
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element of InventoryPresetSaveCustomMessage.symbolId.");
            }
            else
            {
               _itemsPositionsLen = input.readUnsignedShort();
               _i3 = 0;
               while(_i3 < _itemsPositionsLen)
               {
                  _val3 = input.readUnsignedByte();
                  if((_val3 < 0) || (_val3 > 255))
                  {
                     throw new Error("Forbidden value (" + _val3 + ") on elements of itemsPositions.");
                  }
                  else
                  {
                     this.itemsPositions.push(_val3);
                     _i3++;
                     continue;
                  }
               }
               _itemsUidsLen = input.readUnsignedShort();
               _i4 = 0;
               while(_i4 < _itemsUidsLen)
               {
                  _val4 = input.readInt();
                  if(_val4 < 0)
                  {
                     throw new Error("Forbidden value (" + _val4 + ") on elements of itemsUids.");
                  }
                  else
                  {
                     this.itemsUids.push(_val4);
                     _i4++;
                     continue;
                  }
               }
               return;
            }
         }
      }
   }
}
