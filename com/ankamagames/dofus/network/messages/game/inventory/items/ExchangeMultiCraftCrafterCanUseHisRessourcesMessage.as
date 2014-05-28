package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMultiCraftCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMultiCraftCrafterCanUseHisRessourcesMessage() {
         super();
      }
      
      public static const protocolId:uint = 6020;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allowed:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6020;
      }
      
      public function initExchangeMultiCraftCrafterCanUseHisRessourcesMessage(allowed:Boolean = false) : ExchangeMultiCraftCrafterCanUseHisRessourcesMessage {
         this.allowed = allowed;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allowed = false;
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
         this.serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(output);
      }
      
      public function serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(output:IDataOutput) : void {
         output.writeBoolean(this.allowed);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(input);
      }
      
      public function deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(input:IDataInput) : void {
         this.allowed = input.readBoolean();
      }
   }
}
