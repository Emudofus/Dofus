package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeMultiCraftCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMultiCraftCrafterCanUseHisRessourcesMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6020;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var allowed:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 6020;
      }
      
      public function initExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1:Boolean = false) : ExchangeMultiCraftCrafterCanUseHisRessourcesMessage
      {
         this.allowed = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allowed = false;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1);
      }
      
      public function serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.allowed);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1);
      }
      
      public function deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1:ICustomDataInput) : void
      {
         this.allowed = param1.readBoolean();
      }
   }
}
