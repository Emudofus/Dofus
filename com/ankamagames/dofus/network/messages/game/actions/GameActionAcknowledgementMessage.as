package com.ankamagames.dofus.network.messages.game.actions
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionAcknowledgementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameActionAcknowledgementMessage() {
         super();
      }
      
      public static const protocolId:uint = 957;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var valid:Boolean = false;
      
      public var actionId:int = 0;
      
      override public function getMessageId() : uint {
         return 957;
      }
      
      public function initGameActionAcknowledgementMessage(valid:Boolean=false, actionId:int=0) : GameActionAcknowledgementMessage {
         this.valid = valid;
         this.actionId = actionId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.valid = false;
         this.actionId = 0;
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
         this.serializeAs_GameActionAcknowledgementMessage(output);
      }
      
      public function serializeAs_GameActionAcknowledgementMessage(output:IDataOutput) : void {
         output.writeBoolean(this.valid);
         output.writeByte(this.actionId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionAcknowledgementMessage(input);
      }
      
      public function deserializeAs_GameActionAcknowledgementMessage(input:IDataInput) : void {
         this.valid = input.readBoolean();
         this.actionId = input.readByte();
      }
   }
}
