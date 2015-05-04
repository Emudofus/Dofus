package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightSpellCastMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage
   {
      
      public function GameActionFightSpellCastMessage()
      {
         this.portalsIds = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 1010;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var spellId:uint = 0;
      
      public var spellLevel:uint = 0;
      
      public var portalsIds:Vector.<int>;
      
      override public function getMessageId() : uint
      {
         return 1010;
      }
      
      public function initGameActionFightSpellCastMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 1, param6:Boolean = false, param7:uint = 0, param8:uint = 0, param9:Vector.<int> = null) : GameActionFightSpellCastMessage
      {
         super.initAbstractGameActionFightTargetedAbilityMessage(param1,param2,param3,param4,param5,param6);
         this.spellId = param7;
         this.spellLevel = param8;
         this.portalsIds = param9;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.spellId = 0;
         this.spellLevel = 0;
         this.portalsIds = new Vector.<int>();
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
         this.serializeAs_GameActionFightSpellCastMessage(param1);
      }
      
      public function serializeAs_GameActionFightSpellCastMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            param1.writeVarShort(this.spellId);
            if(this.spellLevel < 1 || this.spellLevel > 6)
            {
               throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
            }
            else
            {
               param1.writeByte(this.spellLevel);
               param1.writeShort(this.portalsIds.length);
               var _loc2_:uint = 0;
               while(_loc2_ < this.portalsIds.length)
               {
                  param1.writeShort(this.portalsIds[_loc2_]);
                  _loc2_++;
               }
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightSpellCastMessage(param1);
      }
      
      public function deserializeAs_GameActionFightSpellCastMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:* = 0;
         super.deserialize(param1);
         this.spellId = param1.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightSpellCastMessage.spellId.");
         }
         else
         {
            this.spellLevel = param1.readByte();
            if(this.spellLevel < 1 || this.spellLevel > 6)
            {
               throw new Error("Forbidden value (" + this.spellLevel + ") on element of GameActionFightSpellCastMessage.spellLevel.");
            }
            else
            {
               var _loc2_:uint = param1.readUnsignedShort();
               var _loc3_:uint = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = param1.readShort();
                  this.portalsIds.push(_loc4_);
                  _loc3_++;
               }
               return;
            }
         }
      }
   }
}
