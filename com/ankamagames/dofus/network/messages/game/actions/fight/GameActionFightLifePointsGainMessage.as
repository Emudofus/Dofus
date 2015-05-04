package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightLifePointsGainMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightLifePointsGainMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6311;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var delta:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6311;
      }
      
      public function initGameActionFightLifePointsGainMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : GameActionFightLifePointsGainMessage
      {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.delta = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.delta = 0;
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionFightLifePointsGainMessage(param1);
      }
      
      public function serializeAs_GameActionFightLifePointsGainMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         if(this.delta < 0)
         {
            throw new Error("Forbidden value (" + this.delta + ") on element delta.");
         }
         else
         {
            param1.writeVarInt(this.delta);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightLifePointsGainMessage(param1);
      }
      
      public function deserializeAs_GameActionFightLifePointsGainMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.delta = param1.readVarUhInt();
         if(this.delta < 0)
         {
            throw new Error("Forbidden value (" + this.delta + ") on element of GameActionFightLifePointsGainMessage.delta.");
         }
         else
         {
            return;
         }
      }
   }
}
