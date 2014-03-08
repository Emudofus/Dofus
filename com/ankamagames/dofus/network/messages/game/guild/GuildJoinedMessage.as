package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildJoinedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildJoinedMessage() {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      public static const protocolId:uint = 5564;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildInfo:GuildInformations;
      
      public var memberRights:uint = 0;
      
      public var enabled:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5564;
      }
      
      public function initGuildJoinedMessage(guildInfo:GuildInformations=null, memberRights:uint=0, enabled:Boolean=false) : GuildJoinedMessage {
         this.guildInfo = guildInfo;
         this.memberRights = memberRights;
         this.enabled = enabled;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildInfo = new GuildInformations();
         this.enabled = false;
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
         this.serializeAs_GuildJoinedMessage(output);
      }
      
      public function serializeAs_GuildJoinedMessage(output:IDataOutput) : void {
         this.guildInfo.serializeAs_GuildInformations(output);
         if((this.memberRights < 0) || (this.memberRights > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.memberRights + ") on element memberRights.");
         }
         else
         {
            output.writeUnsignedInt(this.memberRights);
            output.writeBoolean(this.enabled);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildJoinedMessage(input);
      }
      
      public function deserializeAs_GuildJoinedMessage(input:IDataInput) : void {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
         this.memberRights = input.readUnsignedInt();
         if((this.memberRights < 0) || (this.memberRights > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.memberRights + ") on element of GuildJoinedMessage.memberRights.");
         }
         else
         {
            this.enabled = input.readBoolean();
            return;
         }
      }
   }
}
