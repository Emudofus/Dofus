package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class GameActionFightCarryCharacterMessage extends AbstractGameActionMessage implements INetworkMessage
   {
         

      public function GameActionFightCarryCharacterMessage() {
         super();
      }

      public static const protocolId:uint = 5830;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return (super.isInitialized)&&(this._isInitialized);
      }

      public var targetId:int = 0;

      public var cellId:int = 0;

      override public function getMessageId() : uint {
         return 5830;
      }

      public function initGameActionFightCarryCharacterMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, cellId:int=0) : GameActionFightCarryCharacterMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId=targetId;
         this.cellId=cellId;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.targetId=0;
         this.cellId=0;
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
         this.serializeAs_GameActionFightCarryCharacterMessage(output);
      }

      public function serializeAs_GameActionFightCarryCharacterMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         if((this.cellId>-1)||(this.cellId<559))
         {
            throw new Error("Forbidden value ("+this.cellId+") on element cellId.");
         }
         else
         {
            output.writeShort(this.cellId);
            return;
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightCarryCharacterMessage(input);
      }

      public function deserializeAs_GameActionFightCarryCharacterMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId=input.readInt();
         this.cellId=input.readShort();
         if((this.cellId>-1)||(this.cellId<559))
         {
            throw new Error("Forbidden value ("+this.cellId+") on element of GameActionFightCarryCharacterMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }

}