package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightStealKamaMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightStealKamaMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5535;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var amount:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5535;
      }
      
      public function initGameActionFightStealKamaMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : GameActionFightStealKamaMessage
      {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.amount = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.amount = 0;
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
         this.serializeAs_GameActionFightStealKamaMessage(param1);
      }
      
      public function serializeAs_GameActionFightStealKamaMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         if(this.amount < 0)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         else
         {
            param1.writeVarInt(this.amount);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightStealKamaMessage(param1);
      }
      
      public function deserializeAs_GameActionFightStealKamaMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.amount = param1.readVarUhInt();
         if(this.amount < 0)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of GameActionFightStealKamaMessage.amount.");
         }
         else
         {
            return;
         }
      }
   }
}
