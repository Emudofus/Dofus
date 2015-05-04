package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StatsUpgradeResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StatsUpgradeResultMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5609;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var result:int = 0;
      
      public var nbCharacBoost:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5609;
      }
      
      public function initStatsUpgradeResultMessage(param1:int = 0, param2:uint = 0) : StatsUpgradeResultMessage
      {
         this.result = param1;
         this.nbCharacBoost = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.result = 0;
         this.nbCharacBoost = 0;
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
         this.serializeAs_StatsUpgradeResultMessage(param1);
      }
      
      public function serializeAs_StatsUpgradeResultMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.result);
         if(this.nbCharacBoost < 0)
         {
            throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element nbCharacBoost.");
         }
         else
         {
            param1.writeVarShort(this.nbCharacBoost);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StatsUpgradeResultMessage(param1);
      }
      
      public function deserializeAs_StatsUpgradeResultMessage(param1:ICustomDataInput) : void
      {
         this.result = param1.readByte();
         this.nbCharacBoost = param1.readVarUhShort();
         if(this.nbCharacBoost < 0)
         {
            throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element of StatsUpgradeResultMessage.nbCharacBoost.");
         }
         else
         {
            return;
         }
      }
   }
}
