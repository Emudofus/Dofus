package com.ankamagames.dofus.network.messages.game.dialog
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LeaveDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LeaveDialogMessage() {
         super();
      }
      
      public static const protocolId:uint = 5502;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dialogType:uint = 0;
      
      override public function getMessageId() : uint {
         return 5502;
      }
      
      public function initLeaveDialogMessage(dialogType:uint=0) : LeaveDialogMessage {
         this.dialogType = dialogType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dialogType = 0;
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
         this.serializeAs_LeaveDialogMessage(output);
      }
      
      public function serializeAs_LeaveDialogMessage(output:IDataOutput) : void {
         output.writeByte(this.dialogType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LeaveDialogMessage(input);
      }
      
      public function deserializeAs_LeaveDialogMessage(input:IDataInput) : void {
         this.dialogType = input.readByte();
         if(this.dialogType < 0)
         {
            throw new Error("Forbidden value (" + this.dialogType + ") on element of LeaveDialogMessage.dialogType.");
         }
         else
         {
            return;
         }
      }
   }
}
