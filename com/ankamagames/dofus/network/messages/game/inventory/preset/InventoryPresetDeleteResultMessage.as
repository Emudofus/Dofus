package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetDeleteResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetDeleteResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 6173;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var presetId:uint = 0;
      
      public var code:uint = 2;
      
      override public function getMessageId() : uint {
         return 6173;
      }
      
      public function initInventoryPresetDeleteResultMessage(param1:uint=0, param2:uint=2) : InventoryPresetDeleteResultMessage {
         this.presetId = param1;
         this.code = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.presetId = 0;
         this.code = 2;
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
         this.serializeAs_InventoryPresetDeleteResultMessage(param1);
      }
      
      public function serializeAs_InventoryPresetDeleteResultMessage(param1:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            param1.writeByte(this.presetId);
            param1.writeByte(this.code);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_InventoryPresetDeleteResultMessage(param1);
      }
      
      public function deserializeAs_InventoryPresetDeleteResultMessage(param1:IDataInput) : void {
         this.presetId = param1.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetDeleteResultMessage.presetId.");
         }
         else
         {
            this.code = param1.readByte();
            if(this.code < 0)
            {
               throw new Error("Forbidden value (" + this.code + ") on element of InventoryPresetDeleteResultMessage.code.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
