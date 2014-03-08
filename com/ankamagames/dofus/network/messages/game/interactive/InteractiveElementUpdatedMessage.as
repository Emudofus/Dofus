package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InteractiveElementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InteractiveElementUpdatedMessage() {
         this.interactiveElement = new InteractiveElement();
         super();
      }
      
      public static const protocolId:uint = 5708;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var interactiveElement:InteractiveElement;
      
      override public function getMessageId() : uint {
         return 5708;
      }
      
      public function initInteractiveElementUpdatedMessage(interactiveElement:InteractiveElement=null) : InteractiveElementUpdatedMessage {
         this.interactiveElement = interactiveElement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.interactiveElement = new InteractiveElement();
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
         this.serializeAs_InteractiveElementUpdatedMessage(output);
      }
      
      public function serializeAs_InteractiveElementUpdatedMessage(output:IDataOutput) : void {
         this.interactiveElement.serializeAs_InteractiveElement(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveElementUpdatedMessage(input);
      }
      
      public function deserializeAs_InteractiveElementUpdatedMessage(input:IDataInput) : void {
         this.interactiveElement = new InteractiveElement();
         this.interactiveElement.deserialize(input);
      }
   }
}
