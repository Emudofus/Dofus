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
      
      public function initGuildModificationValidMessage(param1:String="", param2:GuildEmblem=null) : GuildModificationValidMessage {
         this.guildName = param1;
         this.guildEmblem = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildName = "";
         this.guildEmblem = new GuildEmblem();
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
         this.serializeAs_GuildModificationValidMessage(param1);
      }
      
      public function serializeAs_GuildModificationValidMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.guildName);
         this.guildEmblem.serializeAs_GuildEmblem(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildModificationValidMessage(param1);
      }
      
      public function deserializeAs_GuildModificationValidMessage(param1:IDataInput) : void {
         this.guildName = param1.readUTF();
         this.guildEmblem = new GuildEmblem();
         this.guildEmblem.deserialize(param1);
      }
   }
}
