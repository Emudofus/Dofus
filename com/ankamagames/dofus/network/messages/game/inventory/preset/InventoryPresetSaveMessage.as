package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetSaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetSaveMessage() {
         super();
      }
      
      public static const protocolId:uint = 6165;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var symbolId:uint = 0;
      
      public var saveEquipment:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6165;
      }
      
      public function initInventoryPresetSaveMessage(presetId:uint=0, symbolId:uint=0, saveEquipment:Boolean=false) : InventoryPresetSaveMessage {
         this.presetId = presetId;
         this.symbolId = symbolId;
         this.saveEquipment = saveEquipment;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
         this.symbolId = 0;
         this.saveEquipment = false;
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
         this.serializeAs_InventoryPresetSaveMessage(output);
      }
      
      public function serializeAs_InventoryPresetSaveMessage(output:IDataOutput) : void {
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
               output.writeBoolean(this.saveEquipment);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryPresetSaveMessage(input);
      }
      
      public function deserializeAs_InventoryPresetSaveMessage(input:IDataInput) : void {
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetSaveMessage.presetId.");
         }
         else
         {
            this.symbolId = input.readByte();
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element of InventoryPresetSaveMessage.symbolId.");
            }
            else
            {
               this.saveEquipment = input.readBoolean();
               return;
            }
         }
      }
   }
}
