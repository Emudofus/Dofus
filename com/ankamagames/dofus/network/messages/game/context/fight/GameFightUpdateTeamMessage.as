package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightUpdateTeamMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightUpdateTeamMessage() {
         this.team = new FightTeamInformations();
         super();
      }
      
      public static const protocolId:uint = 5572;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var team:FightTeamInformations;
      
      override public function getMessageId() : uint {
         return 5572;
      }
      
      public function initGameFightUpdateTeamMessage(param1:uint=0, param2:FightTeamInformations=null) : GameFightUpdateTeamMessage {
         this.fightId = param1;
         this.team = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.team = new FightTeamInformations();
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightUpdateTeamMessage(param1);
      }
      
      public function serializeAs_GameFightUpdateTeamMessage(param1:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            param1.writeShort(this.fightId);
            this.team.serializeAs_FightTeamInformations(param1);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightUpdateTeamMessage(param1);
      }
      
      public function deserializeAs_GameFightUpdateTeamMessage(param1:IDataInput) : void {
         this.fightId = param1.readShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightUpdateTeamMessage.fightId.");
         }
         else
         {
            this.team = new FightTeamInformations();
            this.team.deserialize(param1);
            return;
         }
      }
   }
}
