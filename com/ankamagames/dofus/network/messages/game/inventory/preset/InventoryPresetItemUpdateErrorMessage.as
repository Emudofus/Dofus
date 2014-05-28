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
      
      public function initInventoryPresetItemUpdateErrorMessage(code:uint = 1) : InventoryPresetItemUpdateErrorMessage {
         this.code = code;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.code = 1;
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
         this.serializeAs_InventoryPresetItemUpdateErrorMessage(output);
      }
      
      public function serializeAs_InventoryPresetItemUpdateErrorMessage(output:IDataOutput) : void {
         output.writeByte(this.code);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryPresetItemUpdateErrorMessage(input);
      }
      
      public function deserializeAs_InventoryPresetItemUpdateErrorMessage(input:IDataInput) : void {
         this.code = input.readByte();
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
