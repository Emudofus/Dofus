package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class GameActionFightStateChangeMessage extends AbstractGameActionMessage implements INetworkMessage
   {
         

      public function GameActionFightStateChangeMessage() {
         super();
      }

      public static const protocolId:uint = 5569;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return (super.isInitialized)&&(this._isInitialized);
      }

      public var targetId:int = 0;

      public var stateId:int = 0;

      public var active:Boolean = false;

      override public function getMessageId() : uint {
         return 5569;
      }

      public function initGameActionFightStateChangeMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, stateId:int=0, active:Boolean=false) : GameActionFightStateChangeMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId=targetId;
         this.stateId=stateId;
         this.active=active;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.targetId=0;
         this.stateId=0;
         this.active=false;
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
         this.serializeAs_GameActionFightStateChangeMessage(output);
      }

      public function serializeAs_GameActionFightStateChangeMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         output.writeShort(this.stateId);
         output.writeBoolean(this.active);
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightStateChangeMessage(input);
      }

      public function deserializeAs_GameActionFightStateChangeMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId=input.readInt();
         this.stateId=input.readShort();
         this.active=input.readBoolean();
      }
   }

}