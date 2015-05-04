package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TaxCollectorStateUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorStateUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6455;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var uniqueId:int = 0;
      
      public var state:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6455;
      }
      
      public function initTaxCollectorStateUpdateMessage(param1:int = 0, param2:int = 0) : TaxCollectorStateUpdateMessage
      {
         this.uniqueId = param1;
         this.state = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.uniqueId = 0;
         this.state = 0;
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
         this.serializeAs_TaxCollectorStateUpdateMessage(param1);
      }
      
      public function serializeAs_TaxCollectorStateUpdateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.uniqueId);
         param1.writeByte(this.state);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorStateUpdateMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorStateUpdateMessage(param1:ICustomDataInput) : void
      {
         this.uniqueId = param1.readInt();
         this.state = param1.readByte();
      }
   }
}
