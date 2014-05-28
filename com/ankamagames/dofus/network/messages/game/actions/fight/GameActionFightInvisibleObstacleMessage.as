package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightInvisibleObstacleMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightInvisibleObstacleMessage() {
         super();
      }
      
      public static const protocolId:uint = 5820;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var sourceSpellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5820;
      }
      
      public function initGameActionFightInvisibleObstacleMessage(actionId:uint = 0, sourceId:int = 0, sourceSpellId:uint = 0) : GameActionFightInvisibleObstacleMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.sourceSpellId = sourceSpellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.sourceSpellId = 0;
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
         this.serializeAs_GameActionFightInvisibleObstacleMessage(output);
      }
      
      public function serializeAs_GameActionFightInvisibleObstacleMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.sourceSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceSpellId + ") on element sourceSpellId.");
         }
         else
         {
            output.writeInt(this.sourceSpellId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightInvisibleObstacleMessage(input);
      }
      
      public function deserializeAs_GameActionFightInvisibleObstacleMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.sourceSpellId = input.readInt();
         if(this.sourceSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceSpellId + ") on element of GameActionFightInvisibleObstacleMessage.sourceSpellId.");
         }
         else
         {
            return;
         }
      }
   }
}
