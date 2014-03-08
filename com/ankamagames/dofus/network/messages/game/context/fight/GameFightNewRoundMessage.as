package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightNewRoundMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightNewRoundMessage() {
         super();
      }
      
      public static const protocolId:uint = 6239;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var roundNumber:uint = 0;
      
      override public function getMessageId() : uint {
         return 6239;
      }
      
      public function initGameFightNewRoundMessage(param1:uint=0) : GameFightNewRoundMessage {
         this.roundNumber = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.roundNumber = 0;
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
         this.serializeAs_GameFightNewRoundMessage(param1);
      }
      
      public function serializeAs_GameFightNewRoundMessage(param1:IDataOutput) : void {
         if(this.roundNumber < 0)
         {
            throw new Error("Forbidden value (" + this.roundNumber + ") on element roundNumber.");
         }
         else
         {
            param1.writeInt(this.roundNumber);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightNewRoundMessage(param1);
      }
      
      public function deserializeAs_GameFightNewRoundMessage(param1:IDataInput) : void {
         this.roundNumber = param1.readInt();
         if(this.roundNumber < 0)
         {
            throw new Error("Forbidden value (" + this.roundNumber + ") on element of GameFightNewRoundMessage.roundNumber.");
         }
         else
         {
            return;
         }
      }
   }
}
