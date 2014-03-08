package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayFightRequestCanceledMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayFightRequestCanceledMessage() {
         super();
      }
      
      public static const protocolId:uint = 5822;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:int = 0;
      
      public var sourceId:uint = 0;
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 5822;
      }
      
      public function initGameRolePlayFightRequestCanceledMessage(fightId:int=0, sourceId:uint=0, targetId:int=0) : GameRolePlayFightRequestCanceledMessage {
         this.fightId = fightId;
         this.sourceId = sourceId;
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.sourceId = 0;
         this.targetId = 0;
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
         this.serializeAs_GameRolePlayFightRequestCanceledMessage(output);
      }
      
      public function serializeAs_GameRolePlayFightRequestCanceledMessage(output:IDataOutput) : void {
         output.writeInt(this.fightId);
         if(this.sourceId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
         }
         else
         {
            output.writeInt(this.sourceId);
            output.writeInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayFightRequestCanceledMessage(input);
      }
      
      public function deserializeAs_GameRolePlayFightRequestCanceledMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
         this.sourceId = input.readInt();
         if(this.sourceId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayFightRequestCanceledMessage.sourceId.");
         }
         else
         {
            this.targetId = input.readInt();
            return;
         }
      }
   }
}
