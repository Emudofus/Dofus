package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.inventory.preset.PresetItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetItemUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetItemUpdateMessage() {
         this.presetItem = new PresetItem();
         super();
      }
      
      public static const protocolId:uint = 6168;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var presetItem:PresetItem;
      
      override public function getMessageId() : uint {
         return 6168;
      }
      
      public function initInventoryPresetItemUpdateMessage(param1:uint=0, param2:PresetItem=null) : InventoryPresetItemUpdateMessage {
         this.presetId = param1;
         this.presetItem = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
         this.presetItem = new PresetItem();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_InventoryPresetItemUpdateMessage(param1);
      }
      
      public function serializeAs_InventoryPresetItemUpdateMessage(param1:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            param1.writeByte(this.presetId);
            this.presetItem.serializeAs_PresetItem(param1);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_InventoryPresetItemUpdateMessage(param1);
      }
      
      public function deserializeAs_InventoryPresetItemUpdateMessage(param1:IDataInput) : void {
         this.presetId = param1.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetItemUpdateMessage.presetId.");
         }
         else
         {
            this.presetItem = new PresetItem();
            this.presetItem.deserialize(param1);
            return;
         }
      }
   }
}
