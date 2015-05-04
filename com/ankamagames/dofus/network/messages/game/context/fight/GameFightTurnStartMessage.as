package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightTurnStartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightTurnStartMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 714;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      public var waitTime:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 714;
      }
      
      public function initGameFightTurnStartMessage(param1:int = 0, param2:uint = 0) : GameFightTurnStartMessage
      {
         this.id = param1;
         this.waitTime = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.waitTime = 0;
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
         this.serializeAs_GameFightTurnStartMessage(param1);
      }
      
      public function serializeAs_GameFightTurnStartMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.id);
         if(this.waitTime < 0)
         {
            throw new Error("Forbidden value (" + this.waitTime + ") on element waitTime.");
         }
         else
         {
            param1.writeVarInt(this.waitTime);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTurnStartMessage(param1);
      }
      
      public function deserializeAs_GameFightTurnStartMessage(param1:ICustomDataInput) : void
      {
         this.id = param1.readInt();
         this.waitTime = param1.readVarUhInt();
         if(this.waitTime < 0)
         {
            throw new Error("Forbidden value (" + this.waitTime + ") on element of GameFightTurnStartMessage.waitTime.");
         }
         else
         {
            return;
         }
      }
   }
}
