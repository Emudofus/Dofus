package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetDeleteMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetDeleteMessage() {
         super();
      }
      
      public static const protocolId:uint = 6169;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6169;
      }
      
      public function initInventoryPresetDeleteMessage(presetId:uint=0) : InventoryPresetDeleteMessage {
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
         this.serializeAs_InventoryPresetDeleteMessage(output);
      }
      
      public function serializeAs_InventoryPresetDeleteMessage(output:IDataOutput) : void {
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
         this.deserializeAs_InventoryPresetDeleteMessage(input);
      }
      
      public function deserializeAs_InventoryPresetDeleteMessage(input:IDataInput) : void {
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetDeleteMessage.presetId.");
         }
         else
         {
            return;
         }
      }
   }
}
