package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightTurnEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightTurnEndMessage() {
         super();
      }
      
      public static const protocolId:uint = 719;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      override public function getMessageId() : uint {
         return 719;
      }
      
      public function initGameFightTurnEndMessage(id:int = 0) : GameFightTurnEndMessage {
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
         this.serializeAs_GameFightTurnEndMessage(output);
      }
      
      public function serializeAs_GameFightTurnEndMessage(output:IDataOutput) : void {
         output.writeInt(this.id);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightTurnEndMessage(input);
      }
      
      public function deserializeAs_GameFightTurnEndMessage(input:IDataInput) : void {
         this.id = input.readInt();
      }
   }
}
