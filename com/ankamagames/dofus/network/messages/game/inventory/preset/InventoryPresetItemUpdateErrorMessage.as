package com.ankamagames.dofus.network.messages.game.inventory.preset
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryPresetItemUpdateErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryPresetItemUpdateErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6211;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var code:uint = 1;
      
      override public function getMessageId() : uint {
         return 6211;
      }
      
      public function initInventoryPresetItemUpdateErrorMessage(param1:uint=1) : InventoryPresetItemUpdateErrorMessage {
         this.code = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.code = 1;
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
         this.serializeAs_InventoryPresetItemUpdateErrorMessage(param1);
      }
      
      public function serializeAs_InventoryPresetItemUpdateErrorMessage(param1:IDataOutput) : void {
         param1.writeByte(this.code);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_InventoryPresetItemUpdateErrorMessage(param1);
      }
      
      public function deserializeAs_InventoryPresetItemUpdateErrorMessage(param1:IDataInput) : void {
         this.code = param1.readByte();
         if(this.code < 0)
         {
            throw new Error("Forbidden value (" + this.code + ") on element of InventoryPresetItemUpdateErrorMessage.code.");
         }
         else
         {
            return;
         }
      }
   }
}
