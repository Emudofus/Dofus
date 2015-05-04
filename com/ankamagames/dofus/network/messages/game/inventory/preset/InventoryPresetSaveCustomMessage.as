package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class InventoryPresetSaveCustomMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetSaveCustomMessage()
      {
         this.itemsPositions = new Vector.<uint>();
         this.itemsUids = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6329;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var symbolId:uint = 0;
      
      public var itemsPositions:Vector.<uint>;
      
      public var itemsUids:Vector.<uint>;
      
      override public function getMessageId() : uint
      {
         return 6329;
      }
      
      public function initInventoryPresetSaveCustomMessage(param1:uint = 0, param2:uint = 0, param3:Vector.<uint> = null, param4:Vector.<uint> = null) : InventoryPresetSaveCustomMessage
      {
         this.presetId = param1;
         this.symbolId = param2;
         this.itemsPositions = param3;
         this.itemsUids = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = 0;
         this.symbolId = 0;
         this.itemsPositions = new Vector.<uint>();
         this.itemsUids = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_InventoryPresetSaveCustomMessage(param1);
      }
      
      public function serializeAs_InventoryPresetSaveCustomMessage(param1:ICustomDataOutput) : void
      {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            param1.writeByte(this.presetId);
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element symbolId.");
            }
            else
            {
               param1.writeByte(this.symbolId);
               param1.writeShort(this.itemsPositions.length);
               var _loc2_:uint = 0;
               while(_loc2_ < this.itemsPositions.length)
               {
                  param1.writeByte(this.itemsPositions[_loc2_]);
                  _loc2_++;
               }
               param1.writeShort(this.itemsUids.length);
               var _loc3_:uint = 0;
               while(_loc3_ < this.itemsUids.length)
               {
                  if(this.itemsUids[_loc3_] < 0)
                  {
                     throw new Error("Forbidden value (" + this.itemsUids[_loc3_] + ") on element 4 (starting at 1) of itemsUids.");
                  }
                  else
                  {
                     param1.writeVarInt(this.itemsUids[_loc3_]);
                     _loc3_++;
                     continue;
                  }
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_InventoryPresetSaveCustomMessage(param1);
      }
      
      public function deserializeAs_InventoryPresetSaveCustomMessage(param1:ICustomDataInput) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.presetId = param1.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetSaveCustomMessage.presetId.");
         }
         else
         {
            this.symbolId = param1.readByte();
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element of InventoryPresetSaveCustomMessage.symbolId.");
            }
            else
            {
               var _loc2_:uint = param1.readUnsignedShort();
               var _loc3_:uint = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc6_ = param1.readUnsignedByte();
                  if(_loc6_ < 0 || _loc6_ > 255)
                  {
                     throw new Error("Forbidden value (" + _loc6_ + ") on elements of itemsPositions.");
                  }
                  else
                  {
                     this.itemsPositions.push(_loc6_);
                     _loc3_++;
                     continue;
                  }
               }
               var _loc4_:uint = param1.readUnsignedShort();
               var _loc5_:uint = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc7_ = param1.readVarUhInt();
                  if(_loc7_ < 0)
                  {
                     throw new Error("Forbidden value (" + _loc7_ + ") on elements of itemsUids.");
                  }
                  else
                  {
                     this.itemsUids.push(_loc7_);
                     _loc5_++;
                     continue;
                  }
               }
               return;
            }
         }
      }
   }
}
