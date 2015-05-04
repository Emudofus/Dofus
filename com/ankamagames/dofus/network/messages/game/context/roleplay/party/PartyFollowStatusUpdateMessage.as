package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartyFollowStatusUpdateMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyFollowStatusUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5581;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var success:Boolean = false;
      
      public var followedId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5581;
      }
      
      public function initPartyFollowStatusUpdateMessage(param1:uint = 0, param2:Boolean = false, param3:uint = 0) : PartyFollowStatusUpdateMessage
      {
         super.initAbstractPartyMessage(param1);
         this.success = param2;
         this.followedId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.success = false;
         this.followedId = 0;
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
         this.serializeAs_PartyFollowStatusUpdateMessage(param1);
      }
      
      public function serializeAs_PartyFollowStatusUpdateMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(param1);
         param1.writeBoolean(this.success);
         if(this.followedId < 0)
         {
            throw new Error("Forbidden value (" + this.followedId + ") on element followedId.");
         }
         else
         {
            param1.writeVarInt(this.followedId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyFollowStatusUpdateMessage(param1);
      }
      
      public function deserializeAs_PartyFollowStatusUpdateMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.success = param1.readBoolean();
         this.followedId = param1.readVarUhInt();
         if(this.followedId < 0)
         {
            throw new Error("Forbidden value (" + this.followedId + ") on element of PartyFollowStatusUpdateMessage.followedId.");
         }
         else
         {
            return;
         }
      }
   }
}
