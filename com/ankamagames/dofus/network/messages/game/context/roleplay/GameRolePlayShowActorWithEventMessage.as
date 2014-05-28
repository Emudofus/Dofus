package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayShowActorWithEventMessage extends GameRolePlayShowActorMessage implements INetworkMessage
   {
      
      public function GameRolePlayShowActorWithEventMessage() {
         super();
      }
      
      public static const protocolId:uint = 6407;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var actorEventId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6407;
      }
      
      public function initGameRolePlayShowActorWithEventMessage(informations:GameRolePlayActorInformations = null, actorEventId:uint = 0) : GameRolePlayShowActorWithEventMessage {
         super.initGameRolePlayShowActorMessage(informations);
         this.actorEventId = actorEventId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.actorEventId = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayShowActorWithEventMessage(output);
      }
      
      public function serializeAs_GameRolePlayShowActorWithEventMessage(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayShowActorMessage(output);
         if(this.actorEventId < 0)
         {
            throw new Error("Forbidden value (" + this.actorEventId + ") on element actorEventId.");
         }
         else
         {
            output.writeByte(this.actorEventId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayShowActorWithEventMessage(input);
      }
      
      public function deserializeAs_GameRolePlayShowActorWithEventMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.actorEventId = input.readByte();
         if(this.actorEventId < 0)
         {
            throw new Error("Forbidden value (" + this.actorEventId + ") on element of GameRolePlayShowActorWithEventMessage.actorEventId.");
         }
         else
         {
            return;
         }
      }
   }
}
