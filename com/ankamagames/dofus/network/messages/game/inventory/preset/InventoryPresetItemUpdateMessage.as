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
      
      public function initInventoryPresetItemUpdateMessage(presetId:uint = 0, presetItem:PresetItem = null) : InventoryPresetItemUpdateMessage {
         this.presetId = presetId;
         this.presetItem = presetItem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
         this.presetItem = new PresetItem();
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
         this.serializeAs_InventoryPresetItemUpdateMessage(output);
      }
      
      public function serializeAs_InventoryPresetItemUpdateMessage(output:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            output.writeByte(this.presetId);
            this.presetItem.serializeAs_PresetItem(output);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryPresetItemUpdateMessage(input);
      }
      
      public function deserializeAs_InventoryPresetItemUpdateMessage(input:IDataInput) : void {
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetItemUpdateMessage.presetId.");
         }
         else
         {
            this.presetItem = new PresetItem();
            this.presetItem.deserialize(input);
            return;
         }
      }
   }
}
