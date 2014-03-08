package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInformationsMemberUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInformationsMemberUpdateMessage() {
         this.member = new GuildMember();
         super();
      }
      
      public static const protocolId:uint = 5597;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var member:GuildMember;
      
      override public function getMessageId() : uint {
         return 5597;
      }
      
      public function initGuildInformationsMemberUpdateMessage(member:GuildMember=null) : GuildInformationsMemberUpdateMessage {
         this.member = member;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.member = new GuildMember();
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
         this.serializeAs_GuildInformationsMemberUpdateMessage(output);
      }
      
      public function serializeAs_GuildInformationsMemberUpdateMessage(output:IDataOutput) : void {
         this.member.serializeAs_GuildMember(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInformationsMemberUpdateMessage(input);
      }
      
      public function deserializeAs_GuildInformationsMemberUpdateMessage(input:IDataInput) : void {
         this.member = new GuildMember();
         this.member.deserialize(input);
      }
   }
}
