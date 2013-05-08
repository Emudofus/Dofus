package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class GameFightTurnStartSlaveMessage extends GameFightTurnStartMessage implements INetworkMessage
   {
         

      public function GameFightTurnStartSlaveMessage() {
         super();
      }

      public static const protocolId:uint = 6213;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return (super.isInitialized)&&(this._isInitialized);
      }

      public var idSummoner:int = 0;

      override public function getMessageId() : uint {
         return 6213;
      }

      public function initGameFightTurnStartSlaveMessage(id:int=0, waitTime:uint=0, idSummoner:int=0) : GameFightTurnStartSlaveMessage {
         super.initGameFightTurnStartMessage(id,waitTime);
         this.idSummoner=idSummoner;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.idSummoner=0;
         this._isInitialized=false;
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
         this.serializeAs_GameFightTurnStartSlaveMessage(output);
      }

      public function serializeAs_GameFightTurnStartSlaveMessage(output:IDataOutput) : void {
         super.serializeAs_GameFightTurnStartMessage(output);
         output.writeInt(this.idSummoner);
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightTurnStartSlaveMessage(input);
      }

      public function deserializeAs_GameFightTurnStartSlaveMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.idSummoner=input.readInt();
      }
   }

}