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
      
      public function initAbstractGameActionWithAckMessage(param1:uint=0, param2:int=0, param3:int=0) : AbstractGameActionWithAckMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.waitAckId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.waitAckId = 0;
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
         this.serializeAs_AbstractGameActionWithAckMessage(param1);
      }
      
      public function serializeAs_AbstractGameActionWithAckMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeShort(this.waitAckId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AbstractGameActionWithAckMessage(param1);
      }
      
      public function deserializeAs_AbstractGameActionWithAckMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.waitAckId = param1.readShort();
      }
   }
}
