package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildMembershipMessage extends GuildJoinedMessage implements INetworkMessage
   {
      
      public function GuildMembershipMessage() {
         super();
      }
      
      public static const protocolId:uint = 5835;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5835;
      }
      
      public function initGuildMembershipMessage(param1:GuildInformations=null, param2:uint=0, param3:Boolean=false) : GuildMembershipMessage {
         super.initGuildJoinedMessage(param1,param2,param3);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildMembershipMessage(param1);
      }
      
      public function serializeAs_GuildMembershipMessage(param1:IDataOutput) : void {
         super.serializeAs_GuildJoinedMessage(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildMembershipMessage(param1);
      }
      
      public function deserializeAs_GuildMembershipMessage(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
