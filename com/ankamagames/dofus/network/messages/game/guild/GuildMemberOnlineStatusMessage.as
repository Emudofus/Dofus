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
      
      public function initGuildMemberOnlineStatusMessage(memberId:uint = 0, online:Boolean = false) : GuildMemberOnlineStatusMessage {
         this.memberId = memberId;
         this.online = online;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.memberId = 0;
         this.online = false;
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
         this.serializeAs_GuildMemberOnlineStatusMessage(output);
      }
      
      public function serializeAs_GuildMemberOnlineStatusMessage(output:IDataOutput) : void {
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         else
         {
            output.writeInt(this.memberId);
            output.writeBoolean(this.online);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildMemberOnlineStatusMessage(input);
      }
      
      public function deserializeAs_GuildMemberOnlineStatusMessage(input:IDataInput) : void {
         this.memberId = input.readInt();
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of GuildMemberOnlineStatusMessage.memberId.");
         }
         else
         {
            this.online = input.readBoolean();
            return;
         }
      }
   }
}
