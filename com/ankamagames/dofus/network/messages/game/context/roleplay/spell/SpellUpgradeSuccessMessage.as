package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SpellUpgradeSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpellUpgradeSuccessMessage() {
         super();
      }
      
      public static const protocolId:uint = 1201;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellId:int = 0;
      
      public var spellLevel:uint = 0;
      
      override public function getMessageId() : uint {
         return 1201;
      }
      
      public function initSpellUpgradeSuccessMessage(spellId:int=0, spellLevel:uint=0) : SpellUpgradeSuccessMessage {
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellId = 0;
         this.spellLevel = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_SpellUpgradeSuccessMessage(output);
      }
      
      public function serializeAs_SpellUpgradeSuccessMessage(output:IDataOutput) : void {
         output.writeInt(this.spellId);
         if((this.spellLevel < 1) || (this.spellLevel > 6))
         {
            throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
         }
         else
         {
            output.writeByte(this.spellLevel);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SpellUpgradeSuccessMessage(input);
      }
      
      public function deserializeAs_SpellUpgradeSuccessMessage(input:IDataInput) : void {
         this.spellId = input.readInt();
         this.spellLevel = input.readByte();
         if((this.spellLevel < 1) || (this.spellLevel > 6))
         {
            throw new Error("Forbidden value (" + this.spellLevel + ") on element of SpellUpgradeSuccessMessage.spellLevel.");
         }
         else
         {
            return;
         }
      }
   }
}
