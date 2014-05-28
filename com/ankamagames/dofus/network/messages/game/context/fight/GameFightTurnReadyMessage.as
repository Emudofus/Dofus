package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightTurnReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightTurnReadyMessage() {
         super();
      }
      
      public static const protocolId:uint = 716;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var isReady:Boolean = false;
      
      override public function getMessageId() : uint {
         return 716;
      }
      
      public function initGameFightTurnReadyMessage(isReady:Boolean = false) : GameFightTurnReadyMessage {
         this.isReady = isReady;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.isReady = false;
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
         this.serializeAs_GameFightTurnReadyMessage(output);
      }
      
      public function serializeAs_GameFightTurnReadyMessage(output:IDataOutput) : void {
         output.writeBoolean(this.isReady);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightTurnReadyMessage(input);
      }
      
      public function deserializeAs_GameFightTurnReadyMessage(input:IDataInput) : void {
         this.isReady = input.readBoolean();
      }
   }
}
