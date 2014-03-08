package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInvitationByNameMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInvitationByNameMessage() {
         super();
      }
      
      public static const protocolId:uint = 6115;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 6115;
      }
      
      public function initGuildInvitationByNameMessage(param1:String="") : GuildInvitationByNameMessage {
         this.name = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.name = "";
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
         this.serializeAs_GuildInvitationByNameMessage(param1);
      }
      
      public function serializeAs_GuildInvitationByNameMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.name);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInvitationByNameMessage(param1);
      }
      
      public function deserializeAs_GuildInvitationByNameMessage(param1:IDataInput) : void {
         this.name = param1.readUTF();
      }
   }
}
