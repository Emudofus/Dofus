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
      
      public function initGameActionAcknowledgementMessage(param1:Boolean=false, param2:int=0) : GameActionAcknowledgementMessage {
         this.valid = param1;
         this.actionId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.valid = false;
         this.actionId = 0;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionAcknowledgementMessage(param1);
      }
      
      public function serializeAs_GameActionAcknowledgementMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.valid);
         param1.writeByte(this.actionId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionAcknowledgementMessage(param1);
      }
      
      public function deserializeAs_GameActionAcknowledgementMessage(param1:IDataInput) : void {
         this.valid = param1.readBoolean();
         this.actionId = param1.readByte();
      }
   }
}
