package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightSpectatorJoinMessage extends GameFightJoinMessage implements INetworkMessage
   {
      
      public function GameFightSpectatorJoinMessage() {
         this.namedPartyTeams = new Vector.<NamedPartyTeam>();
         super();
      }
      
      public static const protocolId:uint = 6504;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var namedPartyTeams:Vector.<NamedPartyTeam>;
      
      override public function getMessageId() : uint {
         return 6504;
      }
      
      public function initGameFightSpectatorJoinMessage(canBeCancelled:Boolean = false, canSayReady:Boolean = false, isFightStarted:Boolean = false, timeMaxBeforeFightStart:uint = 0, fightType:uint = 0, namedPartyTeams:Vector.<NamedPartyTeam> = null) : GameFightSpectatorJoinMessage {
         super.initGameFightJoinMessage(canBeCancelled,canSayReady,isFightStarted,timeMaxBeforeFightStart,fightType);
         this.namedPartyTeams = namedPartyTeams;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.namedPartyTeams = new Vector.<NamedPartyTeam>();
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
         this.serializeAs_GameFightSpectatorJoinMessage(output);
      }
      
      public function serializeAs_GameFightSpectatorJoinMessage(output:IDataOutput) : void {
         super.serializeAs_GameFightJoinMessage(output);
         output.writeShort(this.namedPartyTeams.length);
         var _i1:uint = 0;
         while(_i1 < this.namedPartyTeams.length)
         {
            (this.namedPartyTeams[_i1] as NamedPartyTeam).serializeAs_NamedPartyTeam(output);
            _i1++;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightSpectatorJoinMessage(input);
      }
      
      public function deserializeAs_GameFightSpectatorJoinMessage(input:IDataInput) : void {
         var _item1:NamedPartyTeam = null;
         super.deserialize(input);
         var _namedPartyTeamsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _namedPartyTeamsLen)
         {
            _item1 = new NamedPartyTeam();
            _item1.deserialize(input);
            this.namedPartyTeams.push(_item1);
            _i1++;
         }
      }
   }
}
