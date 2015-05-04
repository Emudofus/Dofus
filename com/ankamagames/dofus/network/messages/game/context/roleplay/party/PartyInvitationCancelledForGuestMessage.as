package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartyInvitationCancelledForGuestMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyInvitationCancelledForGuestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6256;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var cancelerId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6256;
      }
      
      public function initPartyInvitationCancelledForGuestMessage(param1:uint = 0, param2:uint = 0) : PartyInvitationCancelledForGuestMessage
      {
         super.initAbstractPartyMessage(param1);
         this.cancelerId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.cancelerId = 0;
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PartyInvitationCancelledForGuestMessage(param1);
      }
      
      public function serializeAs_PartyInvitationCancelledForGuestMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(param1);
         if(this.cancelerId < 0)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element cancelerId.");
         }
         else
         {
            param1.writeVarInt(this.cancelerId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationCancelledForGuestMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationCancelledForGuestMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.cancelerId = param1.readVarUhInt();
         if(this.cancelerId < 0)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element of PartyInvitationCancelledForGuestMessage.cancelerId.");
         }
         else
         {
            return;
         }
      }
   }
}
