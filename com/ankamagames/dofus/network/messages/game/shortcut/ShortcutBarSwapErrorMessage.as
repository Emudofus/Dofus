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
      
      public function initShortcutBarSwapErrorMessage(param1:uint=0) : ShortcutBarSwapErrorMessage {
         this.error = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.error = 0;
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
         this.serializeAs_ShortcutBarSwapErrorMessage(param1);
      }
      
      public function serializeAs_ShortcutBarSwapErrorMessage(param1:IDataOutput) : void {
         param1.writeByte(this.error);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShortcutBarSwapErrorMessage(param1);
      }
      
      public function deserializeAs_ShortcutBarSwapErrorMessage(param1:IDataInput) : void {
         this.error = param1.readByte();
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
