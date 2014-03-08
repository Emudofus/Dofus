package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInvitationStateRecruterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInvitationStateRecruterMessage() {
         super();
      }
      
      public static const protocolId:uint = 5563;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var recrutedName:String = "";
      
      public var invitationState:uint = 0;
      
      override public function getMessageId() : uint {
         return 5563;
      }
      
      public function initGuildInvitationStateRecruterMessage(recrutedName:String="", invitationState:uint=0) : GuildInvitationStateRecruterMessage {
         this.recrutedName = recrutedName;
         this.invitationState = invitationState;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.recrutedName = "";
         this.invitationState = 0;
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
         this.serializeAs_GuildInvitationStateRecruterMessage(output);
      }
      
      public function serializeAs_GuildInvitationStateRecruterMessage(output:IDataOutput) : void {
         output.writeUTF(this.recrutedName);
         output.writeByte(this.invitationState);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInvitationStateRecruterMessage(input);
      }
      
      public function deserializeAs_GuildInvitationStateRecruterMessage(input:IDataInput) : void {
         this.recrutedName = input.readUTF();
         this.invitationState = input.readByte();
         if(this.invitationState < 0)
         {
            throw new Error("Forbidden value (" + this.invitationState + ") on element of GuildInvitationStateRecruterMessage.invitationState.");
         }
         else
         {
            return;
         }
      }
   }
}
