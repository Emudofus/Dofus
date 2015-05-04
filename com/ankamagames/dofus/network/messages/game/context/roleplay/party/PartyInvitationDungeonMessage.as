package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartyInvitationDungeonMessage extends PartyInvitationMessage implements INetworkMessage
   {
      
      public function PartyInvitationDungeonMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6244;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6244;
      }
      
      public function initPartyInvitationDungeonMessage(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0, param5:uint = 0, param6:String = "", param7:uint = 0, param8:uint = 0) : PartyInvitationDungeonMessage
      {
         super.initPartyInvitationMessage(param1,param2,param3,param4,param5,param6,param7);
         this.dungeonId = param8;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.dungeonId = 0;
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
         this.serializeAs_PartyInvitationDungeonMessage(param1);
      }
      
      public function serializeAs_PartyInvitationDungeonMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_PartyInvitationMessage(param1);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeVarShort(this.dungeonId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationDungeonMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationDungeonMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.dungeonId = param1.readVarUhShort();
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
