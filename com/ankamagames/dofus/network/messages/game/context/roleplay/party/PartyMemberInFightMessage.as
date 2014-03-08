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
      
      public function initPartyMemberInFightMessage(param1:uint=0, param2:uint=0, param3:int=0, param4:uint=0, param5:String="", param6:int=0, param7:MapCoordinatesExtended=null, param8:int=0) : PartyMemberInFightMessage {
         super.initAbstractPartyMessage(param1);
         this.reason = param2;
         this.memberId = param3;
         this.memberAccountId = param4;
         this.memberName = param5;
         this.fightId = param6;
         this.fightMap = param7;
         this.secondsBeforeFightStart = param8;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyMemberInFightMessage(param1);
      }
      
      public function serializeAs_PartyMemberInFightMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
         param1.writeByte(this.reason);
         param1.writeInt(this.memberId);
         if(this.memberAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.memberAccountId + ") on element memberAccountId.");
         }
         else
         {
            param1.writeInt(this.memberAccountId);
            param1.writeUTF(this.memberName);
            param1.writeInt(this.fightId);
            this.fightMap.serializeAs_MapCoordinatesExtended(param1);
            param1.writeInt(this.secondsBeforeFightStart);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyMemberInFightMessage(param1);
      }
      
      public function deserializeAs_PartyMemberInFightMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.reason = param1.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of PartyMemberInFightMessage.reason.");
         }
         else
         {
            this.memberId = param1.readInt();
            this.memberAccountId = param1.readInt();
            if(this.memberAccountId < 0)
            {
               throw new Error("Forbidden value (" + this.memberAccountId + ") on element of PartyMemberInFightMessage.memberAccountId.");
            }
            else
            {
               this.memberName = param1.readUTF();
               this.fightId = param1.readInt();
               this.fightMap = new MapCoordinatesExtended();
               this.fightMap.deserialize(param1);
               this.secondsBeforeFightStart = param1.readInt();
               return;
            }
         }
      }
   }
}
