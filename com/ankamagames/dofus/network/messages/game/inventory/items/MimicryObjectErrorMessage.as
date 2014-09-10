package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MimicryObjectErrorMessage extends SymbioticObjectErrorMessage implements INetworkMessage
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
      
      override public function getMessageId() : uint {
         return 6461;
      }
      
      public function initMimicryObjectErrorMessage(reason:int = 0, errorCode:int = 0, preview:Boolean = false) : MimicryObjectErrorMessage {
         super.initSymbioticObjectErrorMessage(reason,errorCode);
         this.preview = preview;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.preview = false;
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
         super.serializeAs_SymbioticObjectErrorMessage(output);
         output.writeBoolean(this.preview);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MimicryObjectErrorMessage(input);
      }
      
      public function deserializeAs_MimicryObjectErrorMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.preview = input.readBoolean();
      }
   }
}
