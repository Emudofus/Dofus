package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PartsListMessage() {
         this.parts = new Vector.<ContentPart>();
         super();
      }
      
      public static const protocolId:uint = 1502;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var parts:Vector.<ContentPart>;
      
      override public function getMessageId() : uint {
         return 1502;
      }
      
      public function initPartsListMessage(param1:Vector.<ContentPart>=null) : PartsListMessage {
         this.parts = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.parts = new Vector.<ContentPart>();
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
         this.serializeAs_PartsListMessage(param1);
      }
      
      public function serializeAs_PartsListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.parts.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.parts.length)
         {
            (this.parts[_loc2_] as ContentPart).serializeAs_ContentPart(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartsListMessage(param1);
      }
      
      public function deserializeAs_PartsListMessage(param1:IDataInput) : void {
         var _loc4_:ContentPart = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ContentPart();
            _loc4_.deserialize(param1);
            this.parts.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
