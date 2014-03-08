package com.ankamagames.dofus.network.messages.game.actions
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AbstractGameActionWithAckMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function AbstractGameActionWithAckMessage() {
         super();
      }
      
      public static const protocolId:uint = 1001;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var waitAckId:int = 0;
      
      override public function getMessageId() : uint {
         return 1001;
      }
      
      public function initAbstractGameActionWithAckMessage(actionId:uint=0, sourceId:int=0, waitAckId:int=0) : AbstractGameActionWithAckMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.waitAckId = waitAckId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.waitAckId = 0;
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
         this.serializeAs_AbstractGameActionWithAckMessage(output);
      }
      
      public function serializeAs_AbstractGameActionWithAckMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.waitAckId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AbstractGameActionWithAckMessage(input);
      }
      
      public function deserializeAs_AbstractGameActionWithAckMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.waitAckId = input.readShort();
      }
   }
}
