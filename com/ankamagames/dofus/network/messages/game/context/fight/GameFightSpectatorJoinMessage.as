package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightSpectatorJoinMessage extends GameFightJoinMessage implements INetworkMessage
   {
      
      public function GameFightSpectatorJoinMessage()
      {
         this.namedPartyTeams = new Vector.<NamedPartyTeam>();
         super();
      }
      
      public static const protocolId:uint = 6504;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var namedPartyTeams:Vector.<NamedPartyTeam>;
      
      override public function getMessageId() : uint
      {
         return 6504;
      }
      
      public function initGameFightSpectatorJoinMessage(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:uint = 0, param5:uint = 0, param6:Vector.<NamedPartyTeam> = null) : GameFightSpectatorJoinMessage
      {
         super.initGameFightJoinMessage(param1,param2,param3,param4,param5);
         this.namedPartyTeams = param6;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.namedPartyTeams = new Vector.<NamedPartyTeam>();
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
         this.serializeAs_GameFightSpectatorJoinMessage(param1);
      }
      
      public function serializeAs_GameFightSpectatorJoinMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightJoinMessage(param1);
         param1.writeShort(this.namedPartyTeams.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.namedPartyTeams.length)
         {
            (this.namedPartyTeams[_loc2_] as NamedPartyTeam).serializeAs_NamedPartyTeam(param1);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightSpectatorJoinMessage(param1);
      }
      
      public function deserializeAs_GameFightSpectatorJoinMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:NamedPartyTeam = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new NamedPartyTeam();
            _loc4_.deserialize(param1);
            this.namedPartyTeams.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
