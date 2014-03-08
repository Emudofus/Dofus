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
      
      public function initGuildInvitationStateRecruterMessage(param1:String="", param2:uint=0) : GuildInvitationStateRecruterMessage {
         this.recrutedName = param1;
         this.invitationState = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.recrutedName = "";
         this.invitationState = 0;
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
         this.serializeAs_GuildInvitationStateRecruterMessage(param1);
      }
      
      public function serializeAs_GuildInvitationStateRecruterMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.recrutedName);
         param1.writeByte(this.invitationState);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInvitationStateRecruterMessage(param1);
      }
      
      public function deserializeAs_GuildInvitationStateRecruterMessage(param1:IDataInput) : void {
         this.recrutedName = param1.readUTF();
         this.invitationState = param1.readByte();
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
