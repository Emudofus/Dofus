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
      
      public function initGameContextRemoveElementWithEventMessage(id:int = 0, elementEventId:uint = 0) : GameContextRemoveElementWithEventMessage {
         super.initGameContextRemoveElementMessage(id);
         this.elementEventId = elementEventId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.elementEventId = 0;
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
         this.serializeAs_GameContextRemoveElementWithEventMessage(output);
      }
      
      public function serializeAs_GameContextRemoveElementWithEventMessage(output:IDataOutput) : void {
         super.serializeAs_GameContextRemoveElementMessage(output);
         if(this.elementEventId < 0)
         {
            throw new Error("Forbidden value (" + this.elementEventId + ") on element elementEventId.");
         }
         else
         {
            output.writeByte(this.elementEventId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextRemoveElementWithEventMessage(input);
      }
      
      public function deserializeAs_GameContextRemoveElementWithEventMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.elementEventId = input.readByte();
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
