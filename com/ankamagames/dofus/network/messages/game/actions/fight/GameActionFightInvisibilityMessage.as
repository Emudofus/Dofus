package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightInvisibilityMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightInvisibilityMessage() {
         super();
      }
      
      public static const protocolId:uint = 5821;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var state:int = 0;
      
      override public function getMessageId() : uint {
         return 5821;
      }
      
      public function initGameActionFightInvisibilityMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, state:int=0) : GameActionFightInvisibilityMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.state = state;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.state = 0;
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
         this.serializeAs_GameActionFightInvisibilityMessage(output);
      }
      
      public function serializeAs_GameActionFightInvisibilityMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         output.writeByte(this.state);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightInvisibilityMessage(input);
      }
      
      public function deserializeAs_GameActionFightInvisibilityMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId = input.readInt();
         this.state = input.readByte();
      }
   }
}
