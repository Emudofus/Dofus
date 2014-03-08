package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextRemoveElementWithEventMessage extends GameContextRemoveElementMessage implements INetworkMessage
   {
      
      public function GameContextRemoveElementWithEventMessage() {
         super();
      }
      
      public static const protocolId:uint = 6412;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var elementEventId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6412;
      }
      
      public function initGameContextRemoveElementWithEventMessage(param1:int=0, param2:uint=0) : GameContextRemoveElementWithEventMessage {
         super.initGameContextRemoveElementMessage(param1);
         this.elementEventId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.elementEventId = 0;
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
         this.serializeAs_GameContextRemoveElementWithEventMessage(param1);
      }
      
      public function serializeAs_GameContextRemoveElementWithEventMessage(param1:IDataOutput) : void {
         super.serializeAs_GameContextRemoveElementMessage(param1);
         if(this.elementEventId < 0)
         {
            throw new Error("Forbidden value (" + this.elementEventId + ") on element elementEventId.");
         }
         else
         {
            param1.writeByte(this.elementEventId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameContextRemoveElementWithEventMessage(param1);
      }
      
      public function deserializeAs_GameContextRemoveElementWithEventMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.elementEventId = param1.readByte();
         if(this.elementEventId < 0)
         {
            throw new Error("Forbidden value (" + this.elementEventId + ") on element of GameContextRemoveElementWithEventMessage.elementEventId.");
         }
         else
         {
            return;
         }
      }
   }
}
