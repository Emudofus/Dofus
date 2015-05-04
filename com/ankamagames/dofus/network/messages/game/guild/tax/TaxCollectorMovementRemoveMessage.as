package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TaxCollectorMovementRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorMovementRemoveMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5915;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var collectorId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5915;
      }
      
      public function initTaxCollectorMovementRemoveMessage(param1:int = 0) : TaxCollectorMovementRemoveMessage
      {
         this.collectorId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.collectorId = 0;
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
         this.serializeAs_TaxCollectorMovementRemoveMessage(param1);
      }
      
      public function serializeAs_TaxCollectorMovementRemoveMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.collectorId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorMovementRemoveMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorMovementRemoveMessage(param1:ICustomDataInput) : void
      {
         this.collectorId = param1.readInt();
      }
   }
}
