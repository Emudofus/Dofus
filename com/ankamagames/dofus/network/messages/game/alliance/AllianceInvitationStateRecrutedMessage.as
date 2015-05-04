package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceInvitationStateRecrutedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInvitationStateRecrutedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6392;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var invitationState:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6392;
      }
      
      public function initAllianceInvitationStateRecrutedMessage(param1:uint = 0) : AllianceInvitationStateRecrutedMessage
      {
         this.invitationState = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.invitationState = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceInvitationStateRecrutedMessage(param1);
      }
      
      public function serializeAs_AllianceInvitationStateRecrutedMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.invitationState);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInvitationStateRecrutedMessage(param1);
      }
      
      public function deserializeAs_AllianceInvitationStateRecrutedMessage(param1:ICustomDataInput) : void
      {
         this.invitationState = param1.readByte();
         if(this.invitationState < 0)
         {
            throw new Error("Forbidden value (" + this.invitationState + ") on element of AllianceInvitationStateRecrutedMessage.invitationState.");
         }
         else
         {
            return;
         }
      }
   }
}
