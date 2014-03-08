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
      
      public function initGuildInformationsMemberUpdateMessage(param1:GuildMember=null) : GuildInformationsMemberUpdateMessage {
         this.member = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.member = new GuildMember();
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
         this.serializeAs_GuildInformationsMemberUpdateMessage(param1);
      }
      
      public function serializeAs_GuildInformationsMemberUpdateMessage(param1:IDataOutput) : void {
         this.member.serializeAs_GuildMember(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInformationsMemberUpdateMessage(param1);
      }
      
      public function deserializeAs_GuildInformationsMemberUpdateMessage(param1:IDataInput) : void {
         this.member = new GuildMember();
         this.member.deserialize(param1);
      }
   }
}
