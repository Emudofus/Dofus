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
      
      public function initPopupWarningMessage(param1:uint=0, param2:String="", param3:String="") : PopupWarningMessage {
         this.lockDuration = param1;
         this.author = param2;
         this.content = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.lockDuration = 0;
         this.author = "";
         this.content = "";
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PopupWarningMessage(param1);
      }
      
      public function serializeAs_PopupWarningMessage(param1:IDataOutput) : void {
         if(this.lockDuration < 0 || this.lockDuration > 255)
         {
            throw new Error("Forbidden value (" + this.lockDuration + ") on element lockDuration.");
         }
         else
         {
            param1.writeByte(this.lockDuration);
            param1.writeUTF(this.author);
            param1.writeUTF(this.content);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PopupWarningMessage(param1);
      }
      
      public function deserializeAs_PopupWarningMessage(param1:IDataInput) : void {
         this.lockDuration = param1.readUnsignedByte();
         if(this.lockDuration < 0 || this.lockDuration > 255)
         {
            throw new Error("Forbidden value (" + this.lockDuration + ") on element of PopupWarningMessage.lockDuration.");
         }
         else
         {
            this.author = param1.readUTF();
            this.content = param1.readUTF();
            return;
         }
      }
   }
}
