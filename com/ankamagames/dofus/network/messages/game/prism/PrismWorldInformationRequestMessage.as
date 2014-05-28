package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismWorldInformationRequestMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismWorldInformationRequestMessage() {
         super();
      }

      public static const protocolId:uint = 5985;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var join:Boolean = false;

      override public function getMessageId() : uint {
         return 5985;
      }

      public function initPrismWorldInformationRequestMessage(join:Boolean=false) : PrismWorldInformationRequestMessage {
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
         this.serializeAs_PrismWorldInformationRequestMessage(output);
      }

      public function serializeAs_PrismWorldInformationRequestMessage(output:IDataOutput) : void {
         output.writeBoolean(this.join);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismWorldInformationRequestMessage(input);
      }

      public function deserializeAs_PrismWorldInformationRequestMessage(input:IDataInput) : void {
         this.join=input.readBoolean();
      }
   }

}