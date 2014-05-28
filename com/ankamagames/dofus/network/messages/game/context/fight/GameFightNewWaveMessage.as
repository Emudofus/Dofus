package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightNewWaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightNewWaveMessage() {
         super();
      }
      
      public static const protocolId:uint = 6490;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      public var teamId:int = 0;
      
      public var nbTurnBeforeNextWave:int = 0;
      
      override public function getMessageId() : uint {
         return 6490;
      }
      
      public function initGameFightNewWaveMessage(id:uint = 0, teamId:int = 0, nbTurnBeforeNextWave:int = 0) : GameFightNewWaveMessage {
         this.id = id;
         this.teamId = teamId;
         this.nbTurnBeforeNextWave = nbTurnBeforeNextWave;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
         this.teamId = 0;
         this.nbTurnBeforeNextWave = 0;
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
         this.serializeAs_GameFightNewWaveMessage(output);
      }
      
      public function serializeAs_GameFightNewWaveMessage(output:IDataOutput) : void {
         if((this.id < 0) || (this.id > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeUnsignedInt(this.id);
            output.writeInt(this.teamId);
            output.writeInt(this.nbTurnBeforeNextWave);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightNewWaveMessage(input);
      }
      
      public function deserializeAs_GameFightNewWaveMessage(input:IDataInput) : void {
         this.id = input.readUnsignedInt();
         if((this.id < 0) || (this.id > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameFightNewWaveMessage.id.");
         }
         else
         {
            this.teamId = input.readInt();
            this.nbTurnBeforeNextWave = input.readInt();
            return;
         }
      }
   }
}
