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
      
      public function initPrismInfoJoinLeaveRequestMessage(join:Boolean = false) : PrismInfoJoinLeaveRequestMessage {
         this.join = join;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
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
         this.serializeAs_PrismInfoJoinLeaveRequestMessage(output);
      }
      
      public function serializeAs_PrismInfoJoinLeaveRequestMessage(output:IDataOutput) : void {
         output.writeBoolean(this.join);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismInfoJoinLeaveRequestMessage(input);
      }
      
      public function deserializeAs_PrismInfoJoinLeaveRequestMessage(input:IDataInput) : void {
         this.join = input.readBoolean();
      }
   }
}
