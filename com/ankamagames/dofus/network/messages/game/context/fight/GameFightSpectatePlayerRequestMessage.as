package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightSpectatePlayerRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightSpectatePlayerRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6474;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playerId:int = 0;
      
      override public function getMessageId() : uint {
         return 6474;
      }
      
      public function initGameFightSpectatePlayerRequestMessage(playerId:int = 0) : GameFightSpectatePlayerRequestMessage {
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerId = 0;
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
         this.serializeAs_GameFightSpectatePlayerRequestMessage(output);
      }
      
      public function serializeAs_GameFightSpectatePlayerRequestMessage(output:IDataOutput) : void {
         output.writeInt(this.playerId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightSpectatePlayerRequestMessage(input);
      }
      
      public function deserializeAs_GameFightSpectatePlayerRequestMessage(input:IDataInput) : void {
         this.playerId = input.readInt();
      }
   }
}
