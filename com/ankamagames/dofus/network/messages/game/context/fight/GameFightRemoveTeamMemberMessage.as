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
      
      public function initGameFightRemoveTeamMemberMessage(fightId:uint = 0, teamId:uint = 2, charId:int = 0) : GameFightRemoveTeamMemberMessage {
         this.fightId = fightId;
         this.teamId = teamId;
         this.charId = charId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.teamId = 2;
         this.charId = 0;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightRemoveTeamMemberMessage(output);
      }
      
      public function serializeAs_GameFightRemoveTeamMemberMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeShort(this.fightId);
            output.writeByte(this.teamId);
            output.writeInt(this.charId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightRemoveTeamMemberMessage(input);
      }
      
      public function deserializeAs_GameFightRemoveTeamMemberMessage(input:IDataInput) : void {
         this.fightId = input.readShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightRemoveTeamMemberMessage.fightId.");
         }
         else
         {
            this.teamId = input.readByte();
            if(this.teamId < 0)
            {
               throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightRemoveTeamMemberMessage.teamId.");
            }
            else
            {
               this.charId = input.readInt();
               return;
            }
         }
      }
   }
}
