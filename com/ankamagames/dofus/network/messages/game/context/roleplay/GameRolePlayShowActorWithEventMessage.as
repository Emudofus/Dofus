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
      
      public function initGameRolePlayShowActorWithEventMessage(param1:GameRolePlayActorInformations=null, param2:uint=0) : GameRolePlayShowActorWithEventMessage {
         super.initGameRolePlayShowActorMessage(param1);
         this.actorEventId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.actorEventId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayShowActorWithEventMessage(param1);
      }
      
      public function serializeAs_GameRolePlayShowActorWithEventMessage(param1:IDataOutput) : void {
         super.serializeAs_GameRolePlayShowActorMessage(param1);
         if(this.actorEventId < 0)
         {
            throw new Error("Forbidden value (" + this.actorEventId + ") on element actorEventId.");
         }
         else
         {
            param1.writeByte(this.actorEventId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayShowActorWithEventMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayShowActorWithEventMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.actorEventId = param1.readByte();
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
