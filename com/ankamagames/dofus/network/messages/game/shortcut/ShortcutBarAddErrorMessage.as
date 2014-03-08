package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShortcutBarAddErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarAddErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6227;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var error:uint = 0;
      
      override public function getMessageId() : uint {
         return 6227;
      }
      
      public function initShortcutBarAddErrorMessage(param1:uint=0) : ShortcutBarAddErrorMessage {
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
         this.serializeAs_ShortcutBarAddErrorMessage(param1);
      }
      
      public function serializeAs_ShortcutBarAddErrorMessage(param1:IDataOutput) : void {
         param1.writeByte(this.error);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShortcutBarAddErrorMessage(param1);
      }
      
      public function deserializeAs_ShortcutBarAddErrorMessage(param1:IDataInput) : void {
         this.error = param1.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of ShortcutBarAddErrorMessage.error.");
         }
         else
         {
            return;
         }
      }
   }
}
