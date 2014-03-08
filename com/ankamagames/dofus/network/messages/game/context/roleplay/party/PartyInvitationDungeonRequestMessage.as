package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationDungeonRequestMessage extends PartyInvitationRequestMessage implements INetworkMessage
   {
      
      public function PartyInvitationDungeonRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6245;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6245;
      }
      
      public function initPartyInvitationDungeonRequestMessage(param1:String="", param2:uint=0) : PartyInvitationDungeonRequestMessage {
         super.initPartyInvitationRequestMessage(param1);
         this.dungeonId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.dungeonId = 0;
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
         this.serializeAs_PartyInvitationDungeonRequestMessage(param1);
      }
      
      public function serializeAs_PartyInvitationDungeonRequestMessage(param1:IDataOutput) : void {
         super.serializeAs_PartyInvitationRequestMessage(param1);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeShort(this.dungeonId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyInvitationDungeonRequestMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationDungeonRequestMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.dungeonId = param1.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonRequestMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }
}
