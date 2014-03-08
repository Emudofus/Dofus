package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightHumanReadyStateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightHumanReadyStateMessage() {
         super();
      }
      
      public static const protocolId:uint = 740;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var characterId:uint = 0;
      
      public var isReady:Boolean = false;
      
      override public function getMessageId() : uint {
         return 740;
      }
      
      public function initGameFightHumanReadyStateMessage(characterId:uint=0, isReady:Boolean=false) : GameFightHumanReadyStateMessage {
         this.characterId = characterId;
         this.isReady = isReady;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.characterId = 0;
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
         this.serializeAs_GameFightHumanReadyStateMessage(output);
      }
      
      public function serializeAs_GameFightHumanReadyStateMessage(output:IDataOutput) : void {
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         else
         {
            output.writeInt(this.characterId);
            output.writeBoolean(this.isReady);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightHumanReadyStateMessage(input);
      }
      
      public function deserializeAs_GameFightHumanReadyStateMessage(input:IDataInput) : void {
         this.characterId = input.readInt();
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of GameFightHumanReadyStateMessage.characterId.");
         }
         else
         {
            this.isReady = input.readBoolean();
            return;
         }
      }
   }
}
