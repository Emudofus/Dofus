package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.version.Version;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IdentificationFailedForBadVersionMessage extends IdentificationFailedMessage implements INetworkMessage
   {
      
      public function IdentificationFailedForBadVersionMessage() {
         this.requiredVersion = new Version();
         super();
      }
      
      public static const protocolId:uint = 21;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var requiredVersion:Version;
      
      override public function getMessageId() : uint {
         return 21;
      }
      
      public function initIdentificationFailedForBadVersionMessage(reason:uint=99, requiredVersion:Version=null) : IdentificationFailedForBadVersionMessage {
         super.initIdentificationFailedMessage(reason);
         this.requiredVersion = requiredVersion;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.requiredVersion = new Version();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_IdentificationFailedForBadVersionMessage(output);
      }
      
      public function serializeAs_IdentificationFailedForBadVersionMessage(output:IDataOutput) : void {
         super.serializeAs_IdentificationFailedMessage(output);
         this.requiredVersion.serializeAs_Version(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IdentificationFailedForBadVersionMessage(input);
      }
      
      public function deserializeAs_IdentificationFailedForBadVersionMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.requiredVersion = new Version();
         this.requiredVersion.deserialize(input);
      }
   }
}
