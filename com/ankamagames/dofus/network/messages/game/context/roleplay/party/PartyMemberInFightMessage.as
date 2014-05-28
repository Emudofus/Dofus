package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyMemberInFightMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyMemberInFightMessage() {
         this.fightMap = new MapCoordinatesExtended();
         super();
      }
      
      public static const protocolId:uint = 6342;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var reason:uint = 0;
      
      public var memberId:int = 0;
      
      public var memberAccountId:uint = 0;
      
      public var memberName:String = "";
      
      public var fightId:int = 0;
      
      public var fightMap:MapCoordinatesExtended;
      
      public var secondsBeforeFightStart:int = 0;
      
      override public function getMessageId() : uint {
         return 6342;
      }
      
      public function initPartyMemberInFightMessage(partyId:uint = 0, reason:uint = 0, memberId:int = 0, memberAccountId:uint = 0, memberName:String = "", fightId:int = 0, fightMap:MapCoordinatesExtended = null, secondsBeforeFightStart:int = 0) : PartyMemberInFightMessage {
         super.initAbstractPartyMessage(partyId);
         this.reason = reason;
         this.memberId = memberId;
         this.memberAccountId = memberAccountId;
         this.memberName = memberName;
         this.fightId = fightId;
         this.fightMap = fightMap;
         this.secondsBeforeFightStart = secondsBeforeFightStart;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.reason = 0;
         this.memberId = 0;
         this.memberAccountId = 0;
         this.memberName = "";
         this.fightId = 0;
         this.fightMap = new MapCoordinatesExtended();
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
         this.serializeAs_PartyMemberInFightMessage(output);
      }
      
      public function serializeAs_PartyMemberInFightMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.reason);
         output.writeInt(this.memberId);
         if(this.memberAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.memberAccountId + ") on element memberAccountId.");
         }
         else
         {
            output.writeInt(this.memberAccountId);
            output.writeUTF(this.memberName);
            output.writeInt(this.fightId);
            this.fightMap.serializeAs_MapCoordinatesExtended(output);
            output.writeInt(this.secondsBeforeFightStart);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyMemberInFightMessage(input);
      }
      
      public function deserializeAs_PartyMemberInFightMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of PartyMemberInFightMessage.reason.");
         }
         else
         {
            this.memberId = input.readInt();
            this.memberAccountId = input.readInt();
            if(this.memberAccountId < 0)
            {
               throw new Error("Forbidden value (" + this.memberAccountId + ") on element of PartyMemberInFightMessage.memberAccountId.");
            }
            else
            {
               this.memberName = input.readUTF();
               this.fightId = input.readInt();
               this.fightMap = new MapCoordinatesExtended();
               this.fightMap.deserialize(input);
               this.secondsBeforeFightStart = input.readInt();
               return;
            }
         }
      }
   }
}
