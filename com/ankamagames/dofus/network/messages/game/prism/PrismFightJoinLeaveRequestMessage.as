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

      public var join:Boolean = false;

      override public function getMessageId() : uint {
         return 5843;
      }

      public function initPrismFightJoinLeaveRequestMessage(join:Boolean=false) : PrismFightJoinLeaveRequestMessage {
         this.join=join;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.join=false;
         this._isInitialized=false;
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
         output.writeBoolean(this.join);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightJoinLeaveRequestMessage(input);
      }

      public function deserializeAs_PrismFightJoinLeaveRequestMessage(input:IDataInput) : void {
         this.join=input.readBoolean();
      }
   }

}