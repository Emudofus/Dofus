package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class GameFightJoinMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightJoinMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 702;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var canBeCancelled:Boolean = false;
      
      public var canSayReady:Boolean = false;
      
      public var isFightStarted:Boolean = false;
      
      public var timeMaxBeforeFightStart:uint = 0;
      
      public var fightType:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 702;
      }
      
      public function initGameFightJoinMessage(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:uint = 0, param5:uint = 0) : GameFightJoinMessage
      {
         this.canBeCancelled = param1;
         this.canSayReady = param2;
         this.isFightStarted = param3;
         this.timeMaxBeforeFightStart = param4;
         this.fightType = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.canBeCancelled = false;
         this.canSayReady = false;
         this.isFightStarted = false;
         this.timeMaxBeforeFightStart = 0;
         this.fightType = 0;
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
         this.serializeAs_GameFightJoinMessage(param1);
      }
      
      public function serializeAs_GameFightJoinMessage(param1:ICustomDataOutput) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.canBeCancelled);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.canSayReady);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,2,this.isFightStarted);
         param1.writeByte(_loc2_);
         if(this.timeMaxBeforeFightStart < 0)
         {
            throw new Error("Forbidden value (" + this.timeMaxBeforeFightStart + ") on element timeMaxBeforeFightStart.");
         }
         else
         {
            param1.writeShort(this.timeMaxBeforeFightStart);
            param1.writeByte(this.fightType);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightJoinMessage(param1);
      }
      
      public function deserializeAs_GameFightJoinMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readByte();
         this.canBeCancelled = BooleanByteWrapper.getFlag(_loc2_,0);
         this.canSayReady = BooleanByteWrapper.getFlag(_loc2_,1);
         this.isFightStarted = BooleanByteWrapper.getFlag(_loc2_,2);
         this.timeMaxBeforeFightStart = param1.readShort();
         if(this.timeMaxBeforeFightStart < 0)
         {
            throw new Error("Forbidden value (" + this.timeMaxBeforeFightStart + ") on element of GameFightJoinMessage.timeMaxBeforeFightStart.");
         }
         else
         {
            this.fightType = param1.readByte();
            if(this.fightType < 0)
            {
               throw new Error("Forbidden value (" + this.fightType + ") on element of GameFightJoinMessage.fightType.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
