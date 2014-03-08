package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SpellItemBoostMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpellItemBoostMessage() {
         super();
      }
      
      public static const protocolId:uint = 6011;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var statId:uint = 0;
      
      public var spellId:uint = 0;
      
      public var value:int = 0;
      
      override public function getMessageId() : uint {
         return 6011;
      }
      
      public function initSpellItemBoostMessage(statId:uint=0, spellId:uint=0, value:int=0) : SpellItemBoostMessage {
         this.statId = statId;
         this.spellId = spellId;
         this.value = value;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.statId = 0;
         this.spellId = 0;
         this.value = 0;
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
         this.serializeAs_SpellItemBoostMessage(output);
      }
      
      public function serializeAs_SpellItemBoostMessage(output:IDataOutput) : void {
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element statId.");
         }
         else
         {
            output.writeInt(this.statId);
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            else
            {
               output.writeShort(this.spellId);
               output.writeShort(this.value);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SpellItemBoostMessage(input);
      }
      
      public function deserializeAs_SpellItemBoostMessage(input:IDataInput) : void {
         this.statId = input.readInt();
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of SpellItemBoostMessage.statId.");
         }
         else
         {
            this.spellId = input.readShort();
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element of SpellItemBoostMessage.spellId.");
            }
            else
            {
               this.value = input.readShort();
               return;
            }
         }
      }
   }
}
