package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartyCancelInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyCancelInvitationMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6254;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var guestId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6254;
      }
      
      public function initPartyCancelInvitationMessage(param1:uint = 0, param2:uint = 0) : PartyCancelInvitationMessage
      {
         super.initAbstractPartyMessage(param1);
         this.guestId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guestId = 0;
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
         this.serializeAs_PartyCancelInvitationMessage(param1);
      }
      
      public function serializeAs_PartyCancelInvitationMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(param1);
         if(this.guestId < 0)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         else
         {
            param1.writeVarInt(this.guestId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyCancelInvitationMessage(param1);
      }
      
      public function deserializeAs_PartyCancelInvitationMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.guestId = param1.readVarUhInt();
         if(this.guestId < 0)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of PartyCancelInvitationMessage.guestId.");
         }
         else
         {
            return;
         }
      }
   }
}
