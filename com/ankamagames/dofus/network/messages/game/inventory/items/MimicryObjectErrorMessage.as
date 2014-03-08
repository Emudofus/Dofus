package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MimicryObjectErrorMessage extends ObjectErrorMessage implements INetworkMessage
   {
      
      public function MimicryObjectErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6461;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var preview:Boolean = false;
      
      public var errorCode:int = 0;
      
      override public function getMessageId() : uint {
         return 6461;
      }
      
      public function initMimicryObjectErrorMessage(reason:int=0, preview:Boolean=false, errorCode:int=0) : MimicryObjectErrorMessage {
         super.initObjectErrorMessage(reason);
         this.preview = preview;
         this.errorCode = errorCode;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.preview = false;
         this.errorCode = 0;
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
         this.serializeAs_MimicryObjectErrorMessage(output);
      }
      
      public function serializeAs_MimicryObjectErrorMessage(output:IDataOutput) : void {
         super.serializeAs_ObjectErrorMessage(output);
         output.writeBoolean(this.preview);
         output.writeByte(this.errorCode);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MimicryObjectErrorMessage(input);
      }
      
      public function deserializeAs_MimicryObjectErrorMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.preview = input.readBoolean();
         this.errorCode = input.readByte();
      }
   }
}
