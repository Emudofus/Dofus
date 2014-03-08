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
      
      public function initPrismFightJoinLeaveRequestMessage(subAreaId:uint=0, join:Boolean=false) : PrismFightJoinLeaveRequestMessage {
         this.subAreaId = subAreaId;
         this.join = join;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.join = false;
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
         this.serializeAs_PrismFightJoinLeaveRequestMessage(output);
      }
      
      public function serializeAs_PrismFightJoinLeaveRequestMessage(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            output.writeBoolean(this.join);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightJoinLeaveRequestMessage(input);
      }
      
      public function deserializeAs_PrismFightJoinLeaveRequestMessage(input:IDataInput) : void {
         this.subAreaId = input.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightJoinLeaveRequestMessage.subAreaId.");
         }
         else
         {
            this.join = input.readBoolean();
            return;
         }
      }
   }
}
