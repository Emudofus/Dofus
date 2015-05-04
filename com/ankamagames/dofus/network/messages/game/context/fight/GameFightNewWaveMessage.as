package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightNewWaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightNewWaveMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6490;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      public var teamId:uint = 2;
      
      public var nbTurnBeforeNextWave:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6490;
      }
      
      public function initGameFightNewWaveMessage(param1:uint = 0, param2:uint = 2, param3:int = 0) : GameFightNewWaveMessage
      {
         this.id = param1;
         this.teamId = param2;
         this.nbTurnBeforeNextWave = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.teamId = 2;
         this.nbTurnBeforeNextWave = 0;
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
         this.serializeAs_GameFightNewWaveMessage(param1);
      }
      
      public function serializeAs_GameFightNewWaveMessage(param1:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeByte(this.id);
            param1.writeByte(this.teamId);
            param1.writeShort(this.nbTurnBeforeNextWave);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightNewWaveMessage(param1);
      }
      
      public function deserializeAs_GameFightNewWaveMessage(param1:ICustomDataInput) : void
      {
         this.id = param1.readByte();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameFightNewWaveMessage.id.");
         }
         else
         {
            this.teamId = param1.readByte();
            if(this.teamId < 0)
            {
               throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightNewWaveMessage.teamId.");
            }
            else
            {
               this.nbTurnBeforeNextWave = param1.readShort();
               return;
            }
         }
      }
   }
}
