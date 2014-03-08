package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismFightJoinLeaveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightJoinLeaveRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5843;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var join:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5843;
      }
      
      public function initPrismFightJoinLeaveRequestMessage(param1:uint=0, param2:Boolean=false) : PrismFightJoinLeaveRequestMessage {
         this.subAreaId = param1;
         this.join = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
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
         this.serializeAs_PrismFightJoinLeaveRequestMessage(param1);
      }
      
      public function serializeAs_PrismFightJoinLeaveRequestMessage(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeShort(this.subAreaId);
            param1.writeBoolean(this.join);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismFightJoinLeaveRequestMessage(param1);
      }
      
      public function deserializeAs_PrismFightJoinLeaveRequestMessage(param1:IDataInput) : void {
         this.subAreaId = param1.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightJoinLeaveRequestMessage.subAreaId.");
         }
         else
         {
            this.join = param1.readBoolean();
            return;
         }
      }
   }
}
