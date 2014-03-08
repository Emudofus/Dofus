package com.ankamagames.dofus.network.messages.game.packs
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PackRestrictedSubAreaMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PackRestrictedSubAreaMessage() {
         super();
      }
      
      public static const protocolId:uint = 6186;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6186;
      }
      
      public function initPackRestrictedSubAreaMessage(param1:uint=0) : PackRestrictedSubAreaMessage {
         this.subAreaId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
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
         this.serializeAs_PackRestrictedSubAreaMessage(param1);
      }
      
      public function serializeAs_PackRestrictedSubAreaMessage(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeInt(this.subAreaId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PackRestrictedSubAreaMessage(param1);
      }
      
      public function deserializeAs_PackRestrictedSubAreaMessage(param1:IDataInput) : void {
         this.subAreaId = param1.readInt();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PackRestrictedSubAreaMessage.subAreaId.");
         }
         else
         {
            return;
         }
      }
   }
}
