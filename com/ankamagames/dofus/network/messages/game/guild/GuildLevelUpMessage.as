package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildLevelUpMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildLevelUpMessage() {
         super();
      }
      
      public static const protocolId:uint = 6062;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var newLevel:uint = 0;
      
      override public function getMessageId() : uint {
         return 6062;
      }
      
      public function initGuildLevelUpMessage(newLevel:uint=0) : GuildLevelUpMessage {
         this.newLevel = newLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.newLevel = 0;
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
         this.serializeAs_GuildLevelUpMessage(output);
      }
      
      public function serializeAs_GuildLevelUpMessage(output:IDataOutput) : void {
         if((this.newLevel < 2) || (this.newLevel > 200))
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
         }
         else
         {
            output.writeByte(this.newLevel);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildLevelUpMessage(input);
      }
      
      public function deserializeAs_GuildLevelUpMessage(input:IDataInput) : void {
         this.newLevel = input.readUnsignedByte();
         if((this.newLevel < 2) || (this.newLevel > 200))
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element of GuildLevelUpMessage.newLevel.");
         }
         else
         {
            return;
         }
      }
   }
}
