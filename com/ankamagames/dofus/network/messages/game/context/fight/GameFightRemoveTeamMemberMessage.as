package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightRemoveTeamMemberMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightRemoveTeamMemberMessage() {
         super();
      }
      
      public static const protocolId:uint = 711;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var teamId:uint = 2;
      
      public var charId:int = 0;
      
      override public function getMessageId() : uint {
         return 711;
      }
      
      public function initGameFightRemoveTeamMemberMessage(param1:uint=0, param2:uint=2, param3:int=0) : GameFightRemoveTeamMemberMessage {
         this.fightId = param1;
         this.teamId = param2;
         this.charId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.teamId = 2;
         this.charId = 0;
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
         this.serializeAs_GameFightRemoveTeamMemberMessage(param1);
      }
      
      public function serializeAs_GameFightRemoveTeamMemberMessage(param1:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            param1.writeShort(this.fightId);
            param1.writeByte(this.teamId);
            param1.writeInt(this.charId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightRemoveTeamMemberMessage(param1);
      }
      
      public function deserializeAs_GameFightRemoveTeamMemberMessage(param1:IDataInput) : void {
         this.fightId = param1.readShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightRemoveTeamMemberMessage.fightId.");
         }
         else
         {
            this.teamId = param1.readByte();
            if(this.teamId < 0)
            {
               throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightRemoveTeamMemberMessage.teamId.");
            }
            else
            {
               this.charId = param1.readInt();
               return;
            }
         }
      }
   }
}
