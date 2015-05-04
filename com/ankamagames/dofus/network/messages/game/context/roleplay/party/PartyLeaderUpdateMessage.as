package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartyLeaderUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyLeaderUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5578;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var partyLeaderId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5578;
      }
      
      public function initPartyLeaderUpdateMessage(param1:uint = 0, param2:uint = 0) : PartyLeaderUpdateMessage
      {
         super.initAbstractPartyEventMessage(param1);
         this.partyLeaderId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.partyLeaderId = 0;
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
         this.serializeAs_PartyLeaderUpdateMessage(param1);
      }
      
      public function serializeAs_PartyLeaderUpdateMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyEventMessage(param1);
         if(this.partyLeaderId < 0)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element partyLeaderId.");
         }
         else
         {
            param1.writeVarInt(this.partyLeaderId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyLeaderUpdateMessage(param1);
      }
      
      public function deserializeAs_PartyLeaderUpdateMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.partyLeaderId = param1.readVarUhInt();
         if(this.partyLeaderId < 0)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element of PartyLeaderUpdateMessage.partyLeaderId.");
         }
         else
         {
            return;
         }
      }
   }
}
