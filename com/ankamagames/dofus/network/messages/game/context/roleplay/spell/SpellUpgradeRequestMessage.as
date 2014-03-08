package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SpellUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpellUpgradeRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5608;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      public var spellLevel:uint = 0;
      
      override public function getMessageId() : uint {
         return 5608;
      }
      
      public function initSpellUpgradeRequestMessage(param1:uint=0, param2:uint=0) : SpellUpgradeRequestMessage {
         this.spellId = param1;
         this.spellLevel = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellId = 0;
         this.spellLevel = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_SpellUpgradeRequestMessage(param1);
      }
      
      public function serializeAs_SpellUpgradeRequestMessage(param1:IDataOutput) : void {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            param1.writeShort(this.spellId);
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
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SpellUpgradeRequestMessage(param1);
      }
      
      public function deserializeAs_SpellUpgradeRequestMessage(param1:IDataInput) : void {
         this.spellId = param1.readShort();
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
