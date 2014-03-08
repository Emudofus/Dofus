package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInformationsMembersMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInformationsMembersMessage() {
         this.members = new Vector.<GuildMember>();
         super();
      }
      
      public static const protocolId:uint = 5558;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var members:Vector.<GuildMember>;
      
      override public function getMessageId() : uint {
         return 5558;
      }
      
      public function initGuildInformationsMembersMessage(members:Vector.<GuildMember>=null) : GuildInformationsMembersMessage {
         this.members = members;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.members = new Vector.<GuildMember>();
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
         this.serializeAs_GuildInformationsMembersMessage(output);
      }
      
      public function serializeAs_GuildInformationsMembersMessage(output:IDataOutput) : void {
         output.writeShort(this.members.length);
         var _i1:uint = 0;
         while(_i1 < this.members.length)
         {
            (this.members[_i1] as GuildMember).serializeAs_GuildMember(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInformationsMembersMessage(input);
      }
      
      public function deserializeAs_GuildInformationsMembersMessage(input:IDataInput) : void {
         var _item1:GuildMember = null;
         var _membersLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _membersLen)
         {
            _item1 = new GuildMember();
            _item1.deserialize(input);
            this.members.push(_item1);
            _i1++;
         }
      }
   }
}
