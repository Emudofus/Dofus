package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class GuildInvitationStateRecrutedMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function GuildInvitationStateRecrutedMessage() {
         super();
      }

      public static const protocolId:uint = 5548;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var invitationState:uint = 0;

      override public function getMessageId() : uint {
         return 5548;
      }

      public function initGuildInvitationStateRecrutedMessage(invitationState:uint=0) : GuildInvitationStateRecrutedMessage {
         this.invitationState=invitationState;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.invitationState=0;
         this._isInitialized=false;
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
         this.serializeAs_GuildInvitationStateRecrutedMessage(output);
      }

      public function serializeAs_GuildInvitationStateRecrutedMessage(output:IDataOutput) : void {
         output.writeByte(this.invitationState);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInvitationStateRecrutedMessage(input);
      }

      public function deserializeAs_GuildInvitationStateRecrutedMessage(input:IDataInput) : void {
         this.invitationState=input.readByte();
         if(this.invitationState<0)
         {
            throw new Error("Forbidden value ("+this.invitationState+") on element of GuildInvitationStateRecrutedMessage.invitationState.");
         }
         else
         {
            return;
         }
      }
   }

}