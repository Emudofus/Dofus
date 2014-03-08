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
      
      public function initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1:Boolean=false) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage {
         this.allow = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allow = false;
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
         this.serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1);
      }
      
      public function serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.allow);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1);
      }
      
      public function deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1:IDataInput) : void {
         this.allow = param1.readBoolean();
      }
   }
}
