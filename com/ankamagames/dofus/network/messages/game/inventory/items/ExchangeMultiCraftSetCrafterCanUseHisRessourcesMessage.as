package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage() {
         super();
      }
      
      public static const protocolId:uint = 6021;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allow:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6021;
      }
      
      public function initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(allow:Boolean = false) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage {
         this.allow = allow;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allow = false;
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
         this.serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(output);
      }
      
      public function serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(output:IDataOutput) : void {
         output.writeBoolean(this.allow);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(input);
      }
      
      public function deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(input:IDataInput) : void {
         this.allow = input.readBoolean();
      }
   }
}
