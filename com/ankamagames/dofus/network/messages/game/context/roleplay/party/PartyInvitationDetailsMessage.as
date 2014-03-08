package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationDetailsMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyInvitationDetailsMessage() {
         this.members = new Vector.<PartyInvitationMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
         super();
      }
      
      public static const protocolId:uint = 6263;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var partyType:uint = 0;
      
      public var fromId:uint = 0;
      
      public var fromName:String = "";
      
      public var leaderId:uint = 0;
      
      public var members:Vector.<PartyInvitationMemberInformations>;
      
      public var guests:Vector.<PartyGuestInformations>;
      
      override public function getMessageId() : uint {
         return 6263;
      }
      
      public function initPartyInvitationDetailsMessage(param1:uint=0, param2:uint=0, param3:uint=0, param4:String="", param5:uint=0, param6:Vector.<PartyInvitationMemberInformations>=null, param7:Vector.<PartyGuestInformations>=null) : PartyInvitationDetailsMessage {
         super.initAbstractPartyMessage(param1);
         this.partyType = param2;
         this.fromId = param3;
         this.fromName = param4;
         this.leaderId = param5;
         this.members = param6;
         this.guests = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.partyType = 0;
         this.fromId = 0;
         this.fromName = "";
         this.leaderId = 0;
         this.members = new Vector.<PartyInvitationMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
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
         this.serializeAs_PartyInvitationDetailsMessage(param1);
      }
      
      public function serializeAs_PartyInvitationDetailsMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
         param1.writeByte(this.partyType);
         if(this.fromId < 0)
         {
            throw new Error("Forbidden value (" + this.fromId + ") on element fromId.");
         }
         else
         {
            param1.writeInt(this.fromId);
            param1.writeUTF(this.fromName);
            if(this.leaderId < 0)
            {
               throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
            }
            else
            {
               param1.writeInt(this.leaderId);
               param1.writeShort(this.members.length);
               _loc2_ = 0;
               while(_loc2_ < this.members.length)
               {
                  (this.members[_loc2_] as PartyInvitationMemberInformations).serializeAs_PartyInvitationMemberInformations(param1);
                  _loc2_++;
               }
               param1.writeShort(this.guests.length);
               _loc3_ = 0;
               while(_loc3_ < this.guests.length)
               {
                  (this.guests[_loc3_] as PartyGuestInformations).serializeAs_PartyGuestInformations(param1);
                  _loc3_++;
               }
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyInvitationDetailsMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationDetailsMessage(param1:IDataInput) : void {
         var _loc6_:PartyInvitationMemberInformations = null;
         var _loc7_:PartyGuestInformations = null;
         super.deserialize(param1);
         this.partyType = param1.readByte();
         if(this.partyType < 0)
         {
            throw new Error("Forbidden value (" + this.partyType + ") on element of PartyInvitationDetailsMessage.partyType.");
         }
         else
         {
            this.fromId = param1.readInt();
            if(this.fromId < 0)
            {
               throw new Error("Forbidden value (" + this.fromId + ") on element of PartyInvitationDetailsMessage.fromId.");
            }
            else
            {
               this.fromName = param1.readUTF();
               this.leaderId = param1.readInt();
               if(this.leaderId < 0)
               {
                  throw new Error("Forbidden value (" + this.leaderId + ") on element of PartyInvitationDetailsMessage.leaderId.");
               }
               else
               {
                  _loc2_ = param1.readUnsignedShort();
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_)
                  {
                     _loc6_ = new PartyInvitationMemberInformations();
                     _loc6_.deserialize(param1);
                     this.members.push(_loc6_);
                     _loc3_++;
                  }
                  _loc4_ = param1.readUnsignedShort();
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_)
                  {
                     _loc7_ = new PartyGuestInformations();
                     _loc7_.deserialize(param1);
                     this.guests.push(_loc7_);
                     _loc5_++;
                  }
                  return;
               }
            }
         }
      }
   }
}
