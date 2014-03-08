package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeSetCraftRecipeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeSetCraftRecipeMessage() {
         super();
      }
      
      public static const protocolId:uint = 6389;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectGID:uint = 0;
      
      override public function getMessageId() : uint {
         return 6389;
      }
      
      public function initExchangeSetCraftRecipeMessage(param1:uint=0) : ExchangeSetCraftRecipeMessage {
         this.objectGID = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectGID = 0;
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
         this.serializeAs_ExchangeSetCraftRecipeMessage(param1);
      }
      
      public function serializeAs_ExchangeSetCraftRecipeMessage(param1:IDataOutput) : void {
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         else
         {
            param1.writeShort(this.objectGID);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeSetCraftRecipeMessage(param1);
      }
      
      public function deserializeAs_ExchangeSetCraftRecipeMessage(param1:IDataInput) : void {
         this.objectGID = param1.readShort();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ExchangeSetCraftRecipeMessage.objectGID.");
         }
         else
         {
            return;
         }
      }
   }
}
