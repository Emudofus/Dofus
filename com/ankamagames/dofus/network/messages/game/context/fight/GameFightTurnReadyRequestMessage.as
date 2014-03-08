package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightTurnReadyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightTurnReadyRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 715;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      override public function getMessageId() : uint {
         return 715;
      }
      
      public function initGameFightTurnReadyRequestMessage(id:int=0) : GameFightTurnReadyRequestMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_GameFightTurnReadyRequestMessage(output);
      }
      
      public function serializeAs_GameFightTurnReadyRequestMessage(output:IDataOutput) : void {
         output.writeInt(this.id);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightTurnReadyRequestMessage(input);
      }
      
      public function deserializeAs_GameFightTurnReadyRequestMessage(input:IDataInput) : void {
         this.id = input.readInt();
      }
   }
}
