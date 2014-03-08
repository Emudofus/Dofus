package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismInfoJoinLeaveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismInfoJoinLeaveRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5844;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var join:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5844;
      }
      
      public function initPrismInfoJoinLeaveRequestMessage(param1:Boolean=false) : PrismInfoJoinLeaveRequestMessage {
         this.join = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.join = false;
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
         this.serializeAs_PrismInfoJoinLeaveRequestMessage(param1);
      }
      
      public function serializeAs_PrismInfoJoinLeaveRequestMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.join);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismInfoJoinLeaveRequestMessage(param1);
      }
      
      public function deserializeAs_PrismInfoJoinLeaveRequestMessage(param1:IDataInput) : void {
         this.join = param1.readBoolean();
      }
   }
}
