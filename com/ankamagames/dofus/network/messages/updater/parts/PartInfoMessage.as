package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PartInfoMessage() {
         this.part = new ContentPart();
         super();
      }
      
      public static const protocolId:uint = 1508;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var part:ContentPart;
      
      public var installationPercent:Number = 0;
      
      override public function getMessageId() : uint {
         return 1508;
      }
      
      public function initPartInfoMessage(part:ContentPart = null, installationPercent:Number = 0) : PartInfoMessage {
         this.part = part;
         this.installationPercent = installationPercent;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.part = new ContentPart();
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
         this.serializeAs_PartInfoMessage(output);
      }
      
      public function serializeAs_PartInfoMessage(output:IDataOutput) : void {
         this.part.serializeAs_ContentPart(output);
         output.writeFloat(this.installationPercent);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartInfoMessage(input);
      }
      
      public function deserializeAs_PartInfoMessage(input:IDataInput) : void {
         this.part = new ContentPart();
         this.part.deserialize(input);
         this.installationPercent = input.readFloat();
      }
   }
}
