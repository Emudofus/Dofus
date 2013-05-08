package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class GameActionFightModifyEffectsDurationMessage extends AbstractGameActionMessage implements INetworkMessage
   {
         

      public function GameActionFightModifyEffectsDurationMessage() {
         super();
      }

      public static const protocolId:uint = 6304;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return (super.isInitialized)&&(this._isInitialized);
      }

      public var targetId:int = 0;

      public var delta:int = 0;

      override public function getMessageId() : uint {
         return 6304;
      }

      public function initGameActionFightModifyEffectsDurationMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, delta:int=0) : GameActionFightModifyEffectsDurationMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId=targetId;
         this.delta=delta;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.targetId=0;
         this.delta=0;
         this._isInitialized=false;
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
         this.serializeAs_GameActionFightModifyEffectsDurationMessage(output);
      }

      public function serializeAs_GameActionFightModifyEffectsDurationMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         output.writeShort(this.delta);
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightModifyEffectsDurationMessage(input);
      }

      public function deserializeAs_GameActionFightModifyEffectsDurationMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId=input.readInt();
         this.delta=input.readShort();
      }
   }

}