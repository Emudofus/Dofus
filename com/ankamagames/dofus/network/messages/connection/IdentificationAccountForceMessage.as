package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.version.VersionExtended;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IdentificationAccountForceMessage extends IdentificationMessage implements INetworkMessage
   {
      
      public function IdentificationAccountForceMessage() {
         super();
      }
      
      public static const protocolId:uint = 6119;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var forcedAccountLogin:String = "";
      
      override public function getMessageId() : uint {
         return 6119;
      }
      
      public function initIdentificationAccountForceMessage(version:VersionExtended = null, lang:String = "", credentials:Vector.<int> = null, serverId:int = 0, autoconnect:Boolean = false, useCertificate:Boolean = false, useLoginToken:Boolean = false, sessionOptionalSalt:Number = 0, forcedAccountLogin:String = "") : IdentificationAccountForceMessage {
         super.initIdentificationMessage(version,lang,credentials,serverId,autoconnect,useCertificate,useLoginToken,sessionOptionalSalt);
         this.forcedAccountLogin = forcedAccountLogin;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.forcedAccountLogin = "";
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
         this.serializeAs_IdentificationAccountForceMessage(output);
      }
      
      public function serializeAs_IdentificationAccountForceMessage(output:IDataOutput) : void {
         super.serializeAs_IdentificationMessage(output);
         output.writeUTF(this.forcedAccountLogin);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IdentificationAccountForceMessage(input);
      }
      
      public function deserializeAs_IdentificationAccountForceMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.forcedAccountLogin = input.readUTF();
      }
   }
}
