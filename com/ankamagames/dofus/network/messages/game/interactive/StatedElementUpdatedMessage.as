package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StatedElementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StatedElementUpdatedMessage() {
         this.statedElement = new StatedElement();
         super();
      }
      
      public static const protocolId:uint = 5709;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var statedElement:StatedElement;
      
      override public function getMessageId() : uint {
         return 5709;
      }
      
      public function initStatedElementUpdatedMessage(statedElement:StatedElement = null) : StatedElementUpdatedMessage {
         this.statedElement = statedElement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.statedElement = new StatedElement();
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
         this.serializeAs_StatedElementUpdatedMessage(output);
      }
      
      public function serializeAs_StatedElementUpdatedMessage(output:IDataOutput) : void {
         this.statedElement.serializeAs_StatedElement(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StatedElementUpdatedMessage(input);
      }
      
      public function deserializeAs_StatedElementUpdatedMessage(input:IDataInput) : void {
         this.statedElement = new StatedElement();
         this.statedElement.deserialize(input);
      }
   }
}
