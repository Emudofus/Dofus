package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightTurnStartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightTurnStartMessage() {
         super();
      }
      
      public static const protocolId:uint = 714;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      public var waitTime:uint = 0;
      
      override public function getMessageId() : uint {
         return 714;
      }
      
      public function initGameFightTurnStartMessage(id:int=0, waitTime:uint=0) : GameFightTurnStartMessage {
         this.id = id;
         this.waitTime = waitTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
         this.waitTime = 0;
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
         this.serializeAs_GameFightTurnStartMessage(output);
      }
      
      public function serializeAs_GameFightTurnStartMessage(output:IDataOutput) : void {
         output.writeInt(this.id);
         if(this.waitTime < 0)
         {
            throw new Error("Forbidden value (" + this.waitTime + ") on element waitTime.");
         }
         else
         {
            output.writeInt(this.waitTime);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightTurnStartMessage(input);
      }
      
      public function deserializeAs_GameFightTurnStartMessage(input:IDataInput) : void {
         this.id = input.readInt();
         this.waitTime = input.readInt();
         if(this.waitTime < 0)
         {
            throw new Error("Forbidden value (" + this.waitTime + ") on element of GameFightTurnStartMessage.waitTime.");
         }
         else
         {
            return;
         }
      }
   }
}
