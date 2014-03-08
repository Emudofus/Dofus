package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class InteractiveMapUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InteractiveMapUpdateMessage() {
         this.interactiveElements = new Vector.<InteractiveElement>();
         super();
      }
      
      public static const protocolId:uint = 5002;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var interactiveElements:Vector.<InteractiveElement>;
      
      override public function getMessageId() : uint {
         return 5002;
      }
      
      public function initInteractiveMapUpdateMessage(interactiveElements:Vector.<InteractiveElement>=null) : InteractiveMapUpdateMessage {
         this.interactiveElements = interactiveElements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.interactiveElements = new Vector.<InteractiveElement>();
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
         this.serializeAs_InteractiveMapUpdateMessage(output);
      }
      
      public function serializeAs_InteractiveMapUpdateMessage(output:IDataOutput) : void {
         output.writeShort(this.interactiveElements.length);
         var _i1:uint = 0;
         while(_i1 < this.interactiveElements.length)
         {
            output.writeShort((this.interactiveElements[_i1] as InteractiveElement).getTypeId());
            (this.interactiveElements[_i1] as InteractiveElement).serialize(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveMapUpdateMessage(input);
      }
      
      public function deserializeAs_InteractiveMapUpdateMessage(input:IDataInput) : void {
         var _id1:uint = 0;
         var _item1:InteractiveElement = null;
         var _interactiveElementsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _interactiveElementsLen)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(InteractiveElement,_id1);
            _item1.deserialize(input);
            this.interactiveElements.push(_item1);
            _i1++;
         }
      }
   }
}
