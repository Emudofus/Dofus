package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightTurnResumeMessage extends GameFightTurnStartMessage implements INetworkMessage
   {
      
      public function GameFightTurnResumeMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6307;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var remainingTime:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6307;
      }
      
      public function initGameFightTurnResumeMessage(param1:int = 0, param2:uint = 0, param3:uint = 0) : GameFightTurnResumeMessage
      {
         super.initGameFightTurnStartMessage(param1,param2);
         this.remainingTime = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.remainingTime = 0;
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
         this.serializeAs_GameFightTurnResumeMessage(param1);
      }
      
      public function serializeAs_GameFightTurnResumeMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightTurnStartMessage(param1);
         if(this.remainingTime < 0)
         {
            throw new Error("Forbidden value (" + this.remainingTime + ") on element remainingTime.");
         }
         else
         {
            param1.writeVarInt(this.remainingTime);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTurnResumeMessage(param1);
      }
      
      public function deserializeAs_GameFightTurnResumeMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.remainingTime = param1.readVarUhInt();
         if(this.remainingTime < 0)
         {
            throw new Error("Forbidden value (" + this.remainingTime + ") on element of GameFightTurnResumeMessage.remainingTime.");
         }
         else
         {
            return;
         }
      }
   }
}
