package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberGeoPosition;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyLocateMembersMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyLocateMembersMessage() {
         this.geopositions = new Vector.<PartyMemberGeoPosition>();
         super();
      }
      
      public static const protocolId:uint = 5595;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var geopositions:Vector.<PartyMemberGeoPosition>;
      
      override public function getMessageId() : uint {
         return 5595;
      }
      
      public function initPartyLocateMembersMessage(partyId:uint = 0, geopositions:Vector.<PartyMemberGeoPosition> = null) : PartyLocateMembersMessage {
         super.initAbstractPartyMessage(partyId);
         this.geopositions = geopositions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.geopositions = new Vector.<PartyMemberGeoPosition>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyLocateMembersMessage(output);
      }
      
      public function serializeAs_PartyLocateMembersMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeShort(this.geopositions.length);
         var _i1:uint = 0;
         while(_i1 < this.geopositions.length)
         {
            (this.geopositions[_i1] as PartyMemberGeoPosition).serializeAs_PartyMemberGeoPosition(output);
            _i1++;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyLocateMembersMessage(input);
      }
      
      public function deserializeAs_PartyLocateMembersMessage(input:IDataInput) : void {
         var _item1:PartyMemberGeoPosition = null;
         super.deserialize(input);
         var _geopositionsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _geopositionsLen)
         {
            _item1 = new PartyMemberGeoPosition();
            _item1.deserialize(input);
            this.geopositions.push(_item1);
            _i1++;
         }
      }
   }
}
