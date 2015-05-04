package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SpellUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpellUpgradeRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5608;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      public var spellLevel:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5608;
      }
      
      public function initSpellUpgradeRequestMessage(param1:uint = 0, param2:uint = 0) : SpellUpgradeRequestMessage
      {
         this.spellId = param1;
         this.spellLevel = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellId = 0;
         this.spellLevel = 0;
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
         this.serializeAs_SpellUpgradeRequestMessage(param1);
      }
      
      public function serializeAs_SpellUpgradeRequestMessage(param1:ICustomDataOutput) : void
      {
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
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SpellUpgradeRequestMessage(param1);
      }
      
      public function deserializeAs_SpellUpgradeRequestMessage(param1:ICustomDataInput) : void
      {
         this.spellId = param1.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of SpellUpgradeRequestMessage.spellId.");
         }
         else
         {
            this.spellLevel = param1.readByte();
            if(this.spellLevel < 1 || this.spellLevel > 6)
            {
               throw new Error("Forbidden value (" + this.spellLevel + ") on element of SpellUpgradeRequestMessage.spellLevel.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
