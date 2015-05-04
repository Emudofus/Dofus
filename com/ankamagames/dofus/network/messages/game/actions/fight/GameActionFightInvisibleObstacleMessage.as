package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightInvisibleObstacleMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightInvisibleObstacleMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5820;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var sourceSpellId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5820;
      }
      
      public function initGameActionFightInvisibleObstacleMessage(param1:uint = 0, param2:int = 0, param3:uint = 0) : GameActionFightInvisibleObstacleMessage
      {
         super.initAbstractGameActionMessage(param1,param2);
         this.sourceSpellId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.sourceSpellId = 0;
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
         this.serializeAs_GameActionFightInvisibleObstacleMessage(param1);
      }
      
      public function serializeAs_GameActionFightInvisibleObstacleMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(param1);
         if(this.sourceSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceSpellId + ") on element sourceSpellId.");
         }
         else
         {
            param1.writeVarInt(this.sourceSpellId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightInvisibleObstacleMessage(param1);
      }
      
      public function deserializeAs_GameActionFightInvisibleObstacleMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.sourceSpellId = param1.readVarUhInt();
         if(this.sourceSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceSpellId + ") on element of GameActionFightInvisibleObstacleMessage.sourceSpellId.");
         }
         else
         {
            return;
         }
      }
   }
}
