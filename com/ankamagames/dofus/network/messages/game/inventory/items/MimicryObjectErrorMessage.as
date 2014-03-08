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
      
      public function initMimicryObjectErrorMessage(param1:int=0, param2:Boolean=false, param3:int=0) : MimicryObjectErrorMessage {
         super.initObjectErrorMessage(param1);
         this.preview = param2;
         this.errorCode = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.preview = false;
         this.errorCode = 0;
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
         this.serializeAs_MimicryObjectErrorMessage(param1);
      }
      
      public function serializeAs_MimicryObjectErrorMessage(param1:IDataOutput) : void {
         super.serializeAs_ObjectErrorMessage(param1);
         param1.writeBoolean(this.preview);
         param1.writeByte(this.errorCode);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MimicryObjectErrorMessage(param1);
      }
      
      public function deserializeAs_MimicryObjectErrorMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.preview = param1.readBoolean();
         this.errorCode = param1.readByte();
      }
   }
}
