package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildCreationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildCreationValidMessage() {
         this.guildEmblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 5546;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildName:String = "";
      
      public var guildEmblem:GuildEmblem;
      
      override public function getMessageId() : uint {
         return 5546;
      }
      
      public function initGuildCreationValidMessage(guildName:String = "", guildEmblem:GuildEmblem = null) : GuildCreationValidMessage {
         this.guildName = guildName;
         this.guildEmblem = guildEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildName = "";
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
         this.serializeAs_GuildCreationValidMessage(output);
      }
      
      public function serializeAs_GuildCreationValidMessage(output:IDataOutput) : void {
         output.writeUTF(this.guildName);
         this.guildEmblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildCreationValidMessage(input);
      }
      
      public function deserializeAs_GuildCreationValidMessage(input:IDataInput) : void {
         this.guildName = input.readUTF();
         this.guildEmblem = new GuildEmblem();
         this.guildEmblem.deserialize(input);
      }
   }
}
