package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildModificationEmblemValidMessage() {
         this.guildEmblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 6328;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildEmblem:GuildEmblem;
      
      override public function getMessageId() : uint {
         return 6328;
      }
      
      public function initGuildModificationEmblemValidMessage(guildEmblem:GuildEmblem=null) : GuildModificationEmblemValidMessage {
         this.guildEmblem = guildEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildEmblem = new GuildEmblem();
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
         this.serializeAs_GuildModificationEmblemValidMessage(output);
      }
      
      public function serializeAs_GuildModificationEmblemValidMessage(output:IDataOutput) : void {
         this.guildEmblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildModificationEmblemValidMessage(input);
      }
      
      public function deserializeAs_GuildModificationEmblemValidMessage(input:IDataInput) : void {
         this.guildEmblem = new GuildEmblem();
         this.guildEmblem.deserialize(input);
      }
   }
}
