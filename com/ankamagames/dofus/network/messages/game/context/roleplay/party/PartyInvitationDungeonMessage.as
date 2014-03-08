package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationDungeonMessage extends PartyInvitationMessage implements INetworkMessage
   {
      
      public function PartyInvitationDungeonMessage() {
         super();
      }
      
      public static const protocolId:uint = 6244;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6244;
      }
      
      public function initPartyInvitationDungeonMessage(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:String="", param6:uint=0, param7:uint=0) : PartyInvitationDungeonMessage {
         super.initPartyInvitationMessage(param1,param2,param3,param4,param5,param6);
         this.dungeonId = param7;
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
         this.serializeAs_PartyInvitationDungeonMessage(param1);
      }
      
      public function serializeAs_PartyInvitationDungeonMessage(param1:IDataOutput) : void {
         super.serializeAs_PartyInvitationMessage(param1);
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
         this.deserializeAs_PartyInvitationDungeonMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationDungeonMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.dungeonId = param1.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }
}
