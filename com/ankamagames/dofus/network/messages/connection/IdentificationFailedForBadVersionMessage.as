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
      
      public function initIdentificationFailedForBadVersionMessage(param1:uint=99, param2:Version=null) : IdentificationFailedForBadVersionMessage {
         super.initIdentificationFailedMessage(param1);
         this.requiredVersion = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.requiredVersion = new Version();
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_IdentificationFailedForBadVersionMessage(param1);
      }
      
      public function serializeAs_IdentificationFailedForBadVersionMessage(param1:IDataOutput) : void {
         super.serializeAs_IdentificationFailedMessage(param1);
         this.requiredVersion.serializeAs_Version(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IdentificationFailedForBadVersionMessage(param1);
      }
      
      public function deserializeAs_IdentificationFailedForBadVersionMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.requiredVersion = new Version();
         this.requiredVersion.deserialize(param1);
      }
   }
}
