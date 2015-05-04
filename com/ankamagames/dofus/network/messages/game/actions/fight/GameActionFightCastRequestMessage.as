package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightCastRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameActionFightCastRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 1005;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      public var cellId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 1005;
      }
      
      public function initGameActionFightCastRequestMessage(param1:uint = 0, param2:int = 0) : GameActionFightCastRequestMessage
      {
         this.spellId = param1;
         this.cellId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellId = 0;
         this.cellId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(_loc2_);
         }
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionFightCastRequestMessage(param1);
      }
      
      public function serializeAs_GameActionFightCastRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            param1.writeVarShort(this.spellId);
            if(this.cellId < -1 || this.cellId > 559)
            {
               throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
            }
            else
            {
               param1.writeShort(this.cellId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightCastRequestMessage(param1);
      }
      
      public function deserializeAs_GameActionFightCastRequestMessage(param1:ICustomDataInput) : void
      {
         this.spellId = param1.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastRequestMessage.spellId.");
         }
         else
         {
            this.cellId = param1.readShort();
            if(this.cellId < -1 || this.cellId > 559)
            {
               throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionFightCastRequestMessage.cellId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
