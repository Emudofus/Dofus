package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildModificationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildModificationValidMessage() {
         this.guildEmblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 6323;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildName:String = "";
      
      public var guildEmblem:GuildEmblem;
      
      override public function getMessageId() : uint {
         return 6323;
      }
      
      public function initGuildModificationValidMessage(guildName:String = "", guildEmblem:GuildEmblem = null) : GuildModificationValidMessage {
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
         this.serializeAs_GuildModificationValidMessage(output);
      }
      
      public function serializeAs_GuildModificationValidMessage(output:IDataOutput) : void {
         output.writeUTF(this.guildName);
         this.guildEmblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildModificationValidMessage(input);
      }
      
      public function deserializeAs_GuildModificationValidMessage(input:IDataInput) : void {
         this.guildName = input.readUTF();
         this.guildEmblem = new GuildEmblem();
         this.guildEmblem.deserialize(input);
      }
   }
}
