package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetUseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetUseMessage() {
         super();
      }
      
      public static const protocolId:uint = 6167;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6167;
      }
      
      public function initInventoryPresetUseMessage(presetId:uint = 0) : InventoryPresetUseMessage {
         this.presetId = presetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
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
         this.serializeAs_InventoryPresetUseMessage(output);
      }
      
      public function serializeAs_InventoryPresetUseMessage(output:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            output.writeByte(this.presetId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryPresetUseMessage(input);
      }
      
      public function deserializeAs_InventoryPresetUseMessage(input:IDataInput) : void {
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetUseMessage.presetId.");
         }
         else
         {
            return;
         }
      }
   }
}
