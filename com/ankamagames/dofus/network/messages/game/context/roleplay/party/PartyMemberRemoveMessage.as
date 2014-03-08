package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyMemberRemoveMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyMemberRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5579;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var leavingPlayerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5579;
      }
      
      public function initPartyMemberRemoveMessage(param1:uint=0, param2:uint=0) : PartyMemberRemoveMessage {
         super.initAbstractPartyEventMessage(param1);
         this.leavingPlayerId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.leavingPlayerId = 0;
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
         this.serializeAs_PartyMemberRemoveMessage(param1);
      }
      
      public function serializeAs_PartyMemberRemoveMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(param1);
         if(this.leavingPlayerId < 0)
         {
            throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element leavingPlayerId.");
         }
         else
         {
            param1.writeInt(this.leavingPlayerId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyMemberRemoveMessage(param1);
      }
      
      public function deserializeAs_PartyMemberRemoveMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.leavingPlayerId = param1.readInt();
         if(this.leavingPlayerId < 0)
         {
            throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element of PartyMemberRemoveMessage.leavingPlayerId.");
         }
         else
         {
            return;
         }
      }
   }
}
