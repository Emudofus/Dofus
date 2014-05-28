package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShortcutBarSwapErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarSwapErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6226;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var error:uint = 0;
      
      override public function getMessageId() : uint {
         return 6226;
      }
      
      public function initShortcutBarSwapErrorMessage(error:uint = 0) : ShortcutBarSwapErrorMessage {
         this.error = error;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.error = 0;
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
         this.serializeAs_ShortcutBarSwapErrorMessage(output);
      }
      
      public function serializeAs_ShortcutBarSwapErrorMessage(output:IDataOutput) : void {
         output.writeByte(this.error);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutBarSwapErrorMessage(input);
      }
      
      public function deserializeAs_ShortcutBarSwapErrorMessage(input:IDataInput) : void {
         this.error = input.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of ShortcutBarSwapErrorMessage.error.");
         }
         else
         {
            return;
         }
      }
   }
}
