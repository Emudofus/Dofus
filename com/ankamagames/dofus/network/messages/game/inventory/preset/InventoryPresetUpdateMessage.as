package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.inventory.preset.Preset;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetUpdateMessage() {
         this.preset = new Preset();
         super();
      }
      
      public static const protocolId:uint = 6171;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var preset:Preset;
      
      override public function getMessageId() : uint {
         return 6171;
      }
      
      public function initInventoryPresetUpdateMessage(param1:Preset=null) : InventoryPresetUpdateMessage {
         this.preset = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.preset = new Preset();
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
         this.serializeAs_InventoryPresetUpdateMessage(param1);
      }
      
      public function serializeAs_InventoryPresetUpdateMessage(param1:IDataOutput) : void {
         this.preset.serializeAs_Preset(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_InventoryPresetUpdateMessage(param1);
      }
      
      public function deserializeAs_InventoryPresetUpdateMessage(param1:IDataInput) : void {
         this.preset = new Preset();
         this.preset.deserialize(param1);
      }
   }
}
