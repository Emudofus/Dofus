package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetSaveResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetSaveResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 6170;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var code:uint = 2;
      
      override public function getMessageId() : uint {
         return 6170;
      }
      
      public function initInventoryPresetSaveResultMessage(presetId:uint=0, code:uint=2) : InventoryPresetSaveResultMessage {
         this.presetId = presetId;
         this.code = code;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
         this.code = 2;
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
         this.serializeAs_InventoryPresetSaveResultMessage(output);
      }
      
      public function serializeAs_InventoryPresetSaveResultMessage(output:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            output.writeByte(this.presetId);
            output.writeByte(this.code);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryPresetSaveResultMessage(input);
      }
      
      public function deserializeAs_InventoryPresetSaveResultMessage(input:IDataInput) : void {
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetSaveResultMessage.presetId.");
         }
         else
         {
            this.code = input.readByte();
            if(this.code < 0)
            {
               throw new Error("Forbidden value (" + this.code + ") on element of InventoryPresetSaveResultMessage.code.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
