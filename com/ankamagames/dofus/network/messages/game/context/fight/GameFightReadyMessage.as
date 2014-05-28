package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightReadyMessage() {
         super();
      }
      
      public static const protocolId:uint = 708;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var isReady:Boolean = false;
      
      override public function getMessageId() : uint {
         return 708;
      }
      
      public function initGameFightReadyMessage(isReady:Boolean = false) : GameFightReadyMessage {
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
         this.serializeAs_GameFightReadyMessage(output);
      }
      
      public function serializeAs_GameFightReadyMessage(output:IDataOutput) : void {
         output.writeBoolean(this.isReady);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightReadyMessage(input);
      }
      
      public function deserializeAs_GameFightReadyMessage(input:IDataInput) : void {
         this.isReady = input.readBoolean();
      }
   }
}
