package com.ankamagames.dofus.network.messages.secure
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TrustStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TrustStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6267;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var trusted:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6267;
      }
      
      public function initTrustStatusMessage(trusted:Boolean=false) : TrustStatusMessage {
         this.trusted = trusted;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.trusted = false;
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
         this.serializeAs_TrustStatusMessage(output);
      }
      
      public function serializeAs_TrustStatusMessage(output:IDataOutput) : void {
         output.writeBoolean(this.trusted);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TrustStatusMessage(input);
      }
      
      public function deserializeAs_TrustStatusMessage(input:IDataInput) : void {
         this.trusted = input.readBoolean();
      }
   }
}
