package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightDispellSpellMessage extends GameActionFightDispellMessage implements INetworkMessage
   {
      
      public function GameActionFightDispellSpellMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6176;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var spellId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6176;
      }
      
      public function initGameActionFightDispellSpellMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : GameActionFightDispellSpellMessage
      {
         super.initGameActionFightDispellMessage(param1,param2,param3);
         this.spellId = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.spellId = 0;
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
         this.serializeAs_GameActionFightDispellSpellMessage(param1);
      }
      
      public function serializeAs_GameActionFightDispellSpellMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameActionFightDispellMessage(param1);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            param1.writeVarShort(this.spellId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightDispellSpellMessage(param1);
      }
      
      public function deserializeAs_GameActionFightDispellSpellMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.spellId = param1.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightDispellSpellMessage.spellId.");
         }
         else
         {
            return;
         }
      }
   }
}
