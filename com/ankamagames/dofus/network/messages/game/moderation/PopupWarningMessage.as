package com.ankamagames.dofus.network.messages.game.moderation
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PopupWarningMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PopupWarningMessage() {
         super();
      }
      
      public static const protocolId:uint = 6134;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var lockDuration:uint = 0;
      
      public var author:String = "";
      
      public var content:String = "";
      
      override public function getMessageId() : uint {
         return 6134;
      }
      
      public function initPopupWarningMessage(lockDuration:uint=0, author:String="", content:String="") : PopupWarningMessage {
         this.lockDuration = lockDuration;
         this.author = author;
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.lockDuration = 0;
         this.author = "";
         this.content = "";
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
         this.serializeAs_PopupWarningMessage(output);
      }
      
      public function serializeAs_PopupWarningMessage(output:IDataOutput) : void {
         if((this.lockDuration < 0) || (this.lockDuration > 255))
         {
            throw new Error("Forbidden value (" + this.lockDuration + ") on element lockDuration.");
         }
         else
         {
            output.writeByte(this.lockDuration);
            output.writeUTF(this.author);
            output.writeUTF(this.content);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PopupWarningMessage(input);
      }
      
      public function deserializeAs_PopupWarningMessage(input:IDataInput) : void {
         this.lockDuration = input.readUnsignedByte();
         if((this.lockDuration < 0) || (this.lockDuration > 255))
         {
            throw new Error("Forbidden value (" + this.lockDuration + ") on element of PopupWarningMessage.lockDuration.");
         }
         else
         {
            this.author = input.readUTF();
            this.content = input.readUTF();
            return;
         }
      }
   }
}
