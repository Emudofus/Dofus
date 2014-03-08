package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PartyUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyUpdateMessage() {
         this.memberInformations = new PartyMemberInformations();
         super();
      }
      
      public static const protocolId:uint = 5575;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var memberInformations:PartyMemberInformations;
      
      override public function getMessageId() : uint {
         return 5575;
      }
      
      public function initPartyUpdateMessage(param1:uint=0, param2:PartyMemberInformations=null) : PartyUpdateMessage {
         super.initAbstractPartyEventMessage(param1);
         this.memberInformations = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.memberInformations = new PartyMemberInformations();
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
         this.serializeAs_PartyUpdateMessage(param1);
      }
      
      public function serializeAs_PartyUpdateMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(param1);
         param1.writeShort(this.memberInformations.getTypeId());
         this.memberInformations.serialize(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyUpdateMessage(param1);
      }
      
      public function deserializeAs_PartyUpdateMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         this.memberInformations = ProtocolTypeManager.getInstance(PartyMemberInformations,_loc2_);
         this.memberInformations.deserialize(param1);
      }
   }
}
