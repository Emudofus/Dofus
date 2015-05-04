package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightNoSpellCastMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameActionFightNoSpellCastMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6132;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var spellLevelId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6132;
      }
      
      public function initGameActionFightNoSpellCastMessage(param1:uint = 0) : GameActionFightNoSpellCastMessage
      {
         this.spellLevelId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellLevelId = 0;
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
         this.serializeAs_GameActionFightNoSpellCastMessage(param1);
      }
      
      public function serializeAs_GameActionFightNoSpellCastMessage(param1:ICustomDataOutput) : void
      {
         if(this.spellLevelId < 0)
         {
            throw new Error("Forbidden value (" + this.spellLevelId + ") on element spellLevelId.");
         }
         else
         {
            param1.writeVarInt(this.spellLevelId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightNoSpellCastMessage(param1);
      }
      
      public function deserializeAs_GameActionFightNoSpellCastMessage(param1:ICustomDataInput) : void
      {
         this.spellLevelId = param1.readVarUhInt();
         if(this.spellLevelId < 0)
         {
            throw new Error("Forbidden value (" + this.spellLevelId + ") on element of GameActionFightNoSpellCastMessage.spellLevelId.");
         }
         else
         {
            return;
         }
      }
   }
}
