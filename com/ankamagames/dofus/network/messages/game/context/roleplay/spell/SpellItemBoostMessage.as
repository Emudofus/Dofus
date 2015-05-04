package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SpellItemBoostMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpellItemBoostMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6011;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var statId:uint = 0;
      
      public var spellId:uint = 0;
      
      public var value:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6011;
      }
      
      public function initSpellItemBoostMessage(param1:uint = 0, param2:uint = 0, param3:int = 0) : SpellItemBoostMessage
      {
         this.statId = param1;
         this.spellId = param2;
         this.value = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.statId = 0;
         this.spellId = 0;
         this.value = 0;
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
         this.serializeAs_SpellItemBoostMessage(param1);
      }
      
      public function serializeAs_SpellItemBoostMessage(param1:ICustomDataOutput) : void
      {
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element statId.");
         }
         else
         {
            param1.writeVarInt(this.statId);
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            else
            {
               param1.writeVarShort(this.spellId);
               param1.writeVarShort(this.value);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SpellItemBoostMessage(param1);
      }
      
      public function deserializeAs_SpellItemBoostMessage(param1:ICustomDataInput) : void
      {
         this.statId = param1.readVarUhInt();
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of SpellItemBoostMessage.statId.");
         }
         else
         {
            this.spellId = param1.readVarUhShort();
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element of SpellItemBoostMessage.spellId.");
            }
            else
            {
               this.value = param1.readVarShort();
               return;
            }
         }
      }
   }
}
