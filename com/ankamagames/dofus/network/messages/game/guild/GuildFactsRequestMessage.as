package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFactsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFactsRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6404;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6404;
      }
      
      public function initGuildFactsRequestMessage(guildId:uint = 0) : GuildFactsRequestMessage {
         this.guildId = guildId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildId = 0;
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
         this.serializeAs_GuildFactsRequestMessage(output);
      }
      
      public function serializeAs_GuildFactsRequestMessage(output:IDataOutput) : void {
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         else
         {
            output.writeInt(this.guildId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFactsRequestMessage(input);
      }
      
      public function deserializeAs_GuildFactsRequestMessage(input:IDataInput) : void {
         this.guildId = input.readInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of GuildFactsRequestMessage.guildId.");
         }
         else
         {
            return;
         }
      }
   }
}
