package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartyInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyInvitationMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5586;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var partyType:uint = 0;
      
      public var partyName:String = "";
      
      public var maxParticipants:uint = 0;
      
      public var fromId:uint = 0;
      
      public var fromName:String = "";
      
      public var toId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5586;
      }
      
      public function initPartyInvitationMessage(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0, param5:uint = 0, param6:String = "", param7:uint = 0) : PartyInvitationMessage
      {
         super.initAbstractPartyMessage(param1);
         this.partyType = param2;
         this.partyName = param3;
         this.maxParticipants = param4;
         this.fromId = param5;
         this.fromName = param6;
         this.toId = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.partyType = 0;
         this.partyName = "";
         this.maxParticipants = 0;
         this.fromId = 0;
         this.fromName = "";
         this.toId = 0;
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
         this.serializeAs_PartyInvitationMessage(param1);
      }
      
      public function serializeAs_PartyInvitationMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(param1);
         param1.writeByte(this.partyType);
         param1.writeUTF(this.partyName);
         if(this.maxParticipants < 0)
         {
            throw new Error("Forbidden value (" + this.maxParticipants + ") on element maxParticipants.");
         }
         else
         {
            param1.writeByte(this.maxParticipants);
            if(this.fromId < 0)
            {
               throw new Error("Forbidden value (" + this.fromId + ") on element fromId.");
            }
            else
            {
               param1.writeVarInt(this.fromId);
               param1.writeUTF(this.fromName);
               if(this.toId < 0)
               {
                  throw new Error("Forbidden value (" + this.toId + ") on element toId.");
               }
               else
               {
                  param1.writeVarInt(this.toId);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.partyType = param1.readByte();
         if(this.partyType < 0)
         {
            throw new Error("Forbidden value (" + this.partyType + ") on element of PartyInvitationMessage.partyType.");
         }
         else
         {
            this.partyName = param1.readUTF();
            this.maxParticipants = param1.readByte();
            if(this.maxParticipants < 0)
            {
               throw new Error("Forbidden value (" + this.maxParticipants + ") on element of PartyInvitationMessage.maxParticipants.");
            }
            else
            {
               this.fromId = param1.readVarUhInt();
               if(this.fromId < 0)
               {
                  throw new Error("Forbidden value (" + this.fromId + ") on element of PartyInvitationMessage.fromId.");
               }
               else
               {
                  this.fromName = param1.readUTF();
                  this.toId = param1.readVarUhInt();
                  if(this.toId < 0)
                  {
                     throw new Error("Forbidden value (" + this.toId + ") on element of PartyInvitationMessage.toId.");
                  }
                  else
                  {
                     return;
                  }
               }
            }
         }
      }
   }
}
