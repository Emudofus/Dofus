package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyCancelInvitationNotificationMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyCancelInvitationNotificationMessage() {
         super();
      }
      
      public static const protocolId:uint = 6251;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var cancelerId:uint = 0;
      
      public var guestId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6251;
      }
      
      public function initPartyCancelInvitationNotificationMessage(param1:uint=0, param2:uint=0, param3:uint=0) : PartyCancelInvitationNotificationMessage {
         super.initAbstractPartyEventMessage(param1);
         this.cancelerId = param2;
         this.guestId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.cancelerId = 0;
         this.guestId = 0;
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
         this.serializeAs_PartyCancelInvitationNotificationMessage(param1);
      }
      
      public function serializeAs_PartyCancelInvitationNotificationMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(param1);
         if(this.cancelerId < 0)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element cancelerId.");
         }
         else
         {
            param1.writeInt(this.cancelerId);
            if(this.guestId < 0)
            {
               throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
            }
            else
            {
               param1.writeInt(this.guestId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyCancelInvitationNotificationMessage(param1);
      }
      
      public function deserializeAs_PartyCancelInvitationNotificationMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.cancelerId = param1.readInt();
         if(this.cancelerId < 0)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element of PartyCancelInvitationNotificationMessage.cancelerId.");
         }
         else
         {
            this.guestId = param1.readInt();
            if(this.guestId < 0)
            {
               throw new Error("Forbidden value (" + this.guestId + ") on element of PartyCancelInvitationNotificationMessage.guestId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
