package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildMemberOnlineStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildMemberOnlineStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6061;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var memberId:uint = 0;
      
      public var online:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6061;
      }
      
      public function initGuildMemberOnlineStatusMessage(param1:uint=0, param2:Boolean=false) : GuildMemberOnlineStatusMessage {
         this.memberId = param1;
         this.online = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.memberId = 0;
         this.online = false;
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
         this.serializeAs_GuildMemberOnlineStatusMessage(param1);
      }
      
      public function serializeAs_GuildMemberOnlineStatusMessage(param1:IDataOutput) : void {
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         else
         {
            param1.writeInt(this.memberId);
            param1.writeBoolean(this.online);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildMemberOnlineStatusMessage(param1);
      }
      
      public function deserializeAs_GuildMemberOnlineStatusMessage(param1:IDataInput) : void {
         this.memberId = param1.readInt();
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of GuildMemberOnlineStatusMessage.memberId.");
         }
         else
         {
            this.online = param1.readBoolean();
            return;
         }
      }
   }
}
