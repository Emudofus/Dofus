package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class InventoryPresetSaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetSaveMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6165;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var symbolId:uint = 0;
      
      public var saveEquipment:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 6165;
      }
      
      public function initInventoryPresetSaveMessage(param1:uint = 0, param2:uint = 0, param3:Boolean = false) : InventoryPresetSaveMessage
      {
         this.presetId = param1;
         this.symbolId = param2;
         this.saveEquipment = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = 0;
         this.symbolId = 0;
         this.saveEquipment = false;
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
         this.serializeAs_InventoryPresetSaveMessage(param1);
      }
      
      public function serializeAs_InventoryPresetSaveMessage(param1:ICustomDataOutput) : void
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
               param1.writeBoolean(this.saveEquipment);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_InventoryPresetSaveMessage(param1);
      }
      
      public function deserializeAs_InventoryPresetSaveMessage(param1:ICustomDataInput) : void
      {
         this.presetId = param1.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetSaveMessage.presetId.");
         }
         else
         {
            this.symbolId = param1.readByte();
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element of InventoryPresetSaveMessage.symbolId.");
            }
            else
            {
               this.saveEquipment = param1.readBoolean();
               return;
            }
         }
      }
   }
}
