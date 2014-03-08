package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class IgnoredListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredListMessage() {
         this.ignoredList = new Vector.<IgnoredInformations>();
         super();
      }
      
      public static const protocolId:uint = 5674;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ignoredList:Vector.<IgnoredInformations>;
      
      override public function getMessageId() : uint {
         return 5674;
      }
      
      public function initIgnoredListMessage(param1:Vector.<IgnoredInformations>=null) : IgnoredListMessage {
         this.ignoredList = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ignoredList = new Vector.<IgnoredInformations>();
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
         this.serializeAs_IgnoredListMessage(param1);
      }
      
      public function serializeAs_IgnoredListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.ignoredList.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.ignoredList.length)
         {
            param1.writeShort((this.ignoredList[_loc2_] as IgnoredInformations).getTypeId());
            (this.ignoredList[_loc2_] as IgnoredInformations).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IgnoredListMessage(param1);
      }
      
      public function deserializeAs_IgnoredListMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:IgnoredInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(IgnoredInformations,_loc4_);
            _loc5_.deserialize(param1);
            this.ignoredList.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
