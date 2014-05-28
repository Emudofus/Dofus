package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightJoinRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightJoinRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 701;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fighterId:int = 0;
      
      public var fightId:int = 0;
      
      override public function getMessageId() : uint {
         return 701;
      }
      
      public function initGameFightJoinRequestMessage(fighterId:int = 0, fightId:int = 0) : GameFightJoinRequestMessage {
         this.fighterId = fighterId;
         this.fightId = fightId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fighterId = 0;
         this.fightId = 0;
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
         this.serializeAs_GameFightJoinRequestMessage(output);
      }
      
      public function serializeAs_GameFightJoinRequestMessage(output:IDataOutput) : void {
         output.writeInt(this.fighterId);
         output.writeInt(this.fightId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightJoinRequestMessage(input);
      }
      
      public function deserializeAs_GameFightJoinRequestMessage(input:IDataInput) : void {
         this.fighterId = input.readInt();
         this.fightId = input.readInt();
      }
   }
}
