package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildSpellUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildSpellUpgradeRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5699;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5699;
      }
      
      public function initGuildSpellUpgradeRequestMessage(spellId:uint=0) : GuildSpellUpgradeRequestMessage {
         this.spellId = spellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellId = 0;
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
         this.serializeAs_GuildSpellUpgradeRequestMessage(output);
      }
      
      public function serializeAs_GuildSpellUpgradeRequestMessage(output:IDataOutput) : void {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            output.writeInt(this.spellId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildSpellUpgradeRequestMessage(input);
      }
      
      public function deserializeAs_GuildSpellUpgradeRequestMessage(input:IDataInput) : void {
         this.spellId = input.readInt();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GuildSpellUpgradeRequestMessage.spellId.");
         }
         else
         {
            return;
         }
      }
   }
}
