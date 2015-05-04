package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightResumeMessage extends GameFightSpectateMessage implements INetworkMessage
   {
      
      public function GameFightResumeMessage()
      {
         this.spellCooldowns = new Vector.<GameFightSpellCooldown>();
         super();
      }
      
      public static const protocolId:uint = 6067;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var spellCooldowns:Vector.<GameFightSpellCooldown>;
      
      public var summonCount:uint = 0;
      
      public var bombCount:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6067;
      }
      
      public function initGameFightResumeMessage(param1:Vector.<FightDispellableEffectExtendedInformations> = null, param2:Vector.<GameActionMark> = null, param3:uint = 0, param4:uint = 0, param5:Vector.<GameFightSpellCooldown> = null, param6:uint = 0, param7:uint = 0) : GameFightResumeMessage
      {
         super.initGameFightSpectateMessage(param1,param2,param3,param4);
         this.spellCooldowns = param5;
         this.summonCount = param6;
         this.bombCount = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.spellCooldowns = new Vector.<GameFightSpellCooldown>();
         this.summonCount = 0;
         this.bombCount = 0;
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
         this.serializeAs_GameFightResumeMessage(param1);
      }
      
      public function serializeAs_GameFightResumeMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightSpectateMessage(param1);
         param1.writeShort(this.spellCooldowns.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.spellCooldowns.length)
         {
            (this.spellCooldowns[_loc2_] as GameFightSpellCooldown).serializeAs_GameFightSpellCooldown(param1);
            _loc2_++;
         }
         if(this.summonCount < 0)
         {
            throw new Error("Forbidden value (" + this.summonCount + ") on element summonCount.");
         }
         else
         {
            param1.writeByte(this.summonCount);
            if(this.bombCount < 0)
            {
               throw new Error("Forbidden value (" + this.bombCount + ") on element bombCount.");
            }
            else
            {
               param1.writeByte(this.bombCount);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightResumeMessage(param1);
      }
      
      public function deserializeAs_GameFightResumeMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:GameFightSpellCooldown = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new GameFightSpellCooldown();
            _loc4_.deserialize(param1);
            this.spellCooldowns.push(_loc4_);
            _loc3_++;
         }
         this.summonCount = param1.readByte();
         if(this.summonCount < 0)
         {
            throw new Error("Forbidden value (" + this.summonCount + ") on element of GameFightResumeMessage.summonCount.");
         }
         else
         {
            this.bombCount = param1.readByte();
            if(this.bombCount < 0)
            {
               throw new Error("Forbidden value (" + this.bombCount + ") on element of GameFightResumeMessage.bombCount.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
