package com.ankamagames.dofus.network.messages.game.modificator
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AreaFightModificatorUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AreaFightModificatorUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6493;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var spellPairId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6493;
      }
      
      public function initAreaFightModificatorUpdateMessage(param1:int = 0) : AreaFightModificatorUpdateMessage
      {
         this.spellPairId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellPairId = 0;
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
         this.serializeAs_AreaFightModificatorUpdateMessage(param1);
      }
      
      public function serializeAs_AreaFightModificatorUpdateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.spellPairId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AreaFightModificatorUpdateMessage(param1);
      }
      
      public function deserializeAs_AreaFightModificatorUpdateMessage(param1:ICustomDataInput) : void
      {
         this.spellPairId = param1.readInt();
      }
   }
}
