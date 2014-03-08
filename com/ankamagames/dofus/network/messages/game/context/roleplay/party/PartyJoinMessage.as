package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PartyJoinMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyJoinMessage() {
         this.members = new Vector.<PartyMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
         super();
      }
      
      public static const protocolId:uint = 5576;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var partyType:uint = 0;
      
      public var partyLeaderId:uint = 0;
      
      public var maxParticipants:uint = 0;
      
      public var members:Vector.<PartyMemberInformations>;
      
      public var guests:Vector.<PartyGuestInformations>;
      
      public var restricted:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5576;
      }
      
      public function initPartyJoinMessage(partyId:uint=0, partyType:uint=0, partyLeaderId:uint=0, maxParticipants:uint=0, members:Vector.<PartyMemberInformations>=null, guests:Vector.<PartyGuestInformations>=null, restricted:Boolean=false) : PartyJoinMessage {
         super.initAbstractPartyMessage(partyId);
         this.partyType = partyType;
         this.partyLeaderId = partyLeaderId;
         this.maxParticipants = maxParticipants;
         this.members = members;
         this.guests = guests;
         this.restricted = restricted;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.partyType = 0;
         this.partyLeaderId = 0;
         this.maxParticipants = 0;
         this.members = new Vector.<PartyMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
         this.restricted = false;
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
         this.serializeAs_PartyJoinMessage(output);
      }
      
      public function serializeAs_PartyJoinMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.partyType);
         if(this.partyLeaderId < 0)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element partyLeaderId.");
         }
         else
         {
            output.writeInt(this.partyLeaderId);
            if(this.maxParticipants < 0)
            {
               throw new Error("Forbidden value (" + this.maxParticipants + ") on element maxParticipants.");
            }
            else
            {
               output.writeByte(this.maxParticipants);
               output.writeShort(this.members.length);
               _i4 = 0;
               while(_i4 < this.members.length)
               {
                  output.writeShort((this.members[_i4] as PartyMemberInformations).getTypeId());
                  (this.members[_i4] as PartyMemberInformations).serialize(output);
                  _i4++;
               }
               output.writeShort(this.guests.length);
               _i5 = 0;
               while(_i5 < this.guests.length)
               {
                  (this.guests[_i5] as PartyGuestInformations).serializeAs_PartyGuestInformations(output);
                  _i5++;
               }
               output.writeBoolean(this.restricted);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyJoinMessage(input);
      }
      
      public function deserializeAs_PartyJoinMessage(input:IDataInput) : void {
         var _id4:uint = 0;
         var _item4:PartyMemberInformations = null;
         var _item5:PartyGuestInformations = null;
         super.deserialize(input);
         this.partyType = input.readByte();
         if(this.partyType < 0)
         {
            throw new Error("Forbidden value (" + this.partyType + ") on element of PartyJoinMessage.partyType.");
         }
         else
         {
            this.partyLeaderId = input.readInt();
            if(this.partyLeaderId < 0)
            {
               throw new Error("Forbidden value (" + this.partyLeaderId + ") on element of PartyJoinMessage.partyLeaderId.");
            }
            else
            {
               this.maxParticipants = input.readByte();
               if(this.maxParticipants < 0)
               {
                  throw new Error("Forbidden value (" + this.maxParticipants + ") on element of PartyJoinMessage.maxParticipants.");
               }
               else
               {
                  _membersLen = input.readUnsignedShort();
                  _i4 = 0;
                  while(_i4 < _membersLen)
                  {
                     _id4 = input.readUnsignedShort();
                     _item4 = ProtocolTypeManager.getInstance(PartyMemberInformations,_id4);
                     _item4.deserialize(input);
                     this.members.push(_item4);
                     _i4++;
                  }
                  _guestsLen = input.readUnsignedShort();
                  _i5 = 0;
                  while(_i5 < _guestsLen)
                  {
                     _item5 = new PartyGuestInformations();
                     _item5.deserialize(input);
                     this.guests.push(_item5);
                     _i5++;
                  }
                  this.restricted = input.readBoolean();
                  return;
               }
            }
         }
      }
   }
}
