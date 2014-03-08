package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
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
      
      public function initInteractiveMapUpdateMessage(param1:Vector.<InteractiveElement>=null) : InteractiveMapUpdateMessage {
         this.interactiveElements = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.interactiveElements = new Vector.<InteractiveElement>();
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
         this.serializeAs_InteractiveMapUpdateMessage(param1);
      }
      
      public function serializeAs_InteractiveMapUpdateMessage(param1:IDataOutput) : void {
         param1.writeShort(this.interactiveElements.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.interactiveElements.length)
         {
            param1.writeShort((this.interactiveElements[_loc2_] as InteractiveElement).getTypeId());
            (this.interactiveElements[_loc2_] as InteractiveElement).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_InteractiveMapUpdateMessage(param1);
      }
      
      public function deserializeAs_InteractiveMapUpdateMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:InteractiveElement = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(InteractiveElement,_loc4_);
            _loc5_.deserialize(param1);
            this.interactiveElements.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
