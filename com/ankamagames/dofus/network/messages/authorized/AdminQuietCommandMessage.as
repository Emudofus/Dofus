package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AdminQuietCommandMessage extends AdminCommandMessage implements INetworkMessage
   {
      
      public function AdminQuietCommandMessage() {
         super();
      }
      
      public static const protocolId:uint = 5662;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5662;
      }
      
      public function initAdminQuietCommandMessage(content:String="") : AdminQuietCommandMessage {
         super.initAdminCommandMessage(content);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
         this.serializeAs_AdminQuietCommandMessage(output);
      }
      
      public function serializeAs_AdminQuietCommandMessage(output:IDataOutput) : void {
         super.serializeAs_AdminCommandMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AdminQuietCommandMessage(input);
      }
      
      public function deserializeAs_AdminQuietCommandMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
