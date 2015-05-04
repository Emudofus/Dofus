package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ShortcutBarRemoveErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarRemoveErrorMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6222;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var error:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6222;
      }
      
      public function initShortcutBarRemoveErrorMessage(param1:uint = 0) : ShortcutBarRemoveErrorMessage
      {
         this.error = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.error = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ShortcutBarRemoveErrorMessage(param1);
      }
      
      public function serializeAs_ShortcutBarRemoveErrorMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.error);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarRemoveErrorMessage(param1);
      }
      
      public function deserializeAs_ShortcutBarRemoveErrorMessage(param1:ICustomDataInput) : void
      {
         this.error = param1.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of ShortcutBarRemoveErrorMessage.error.");
         }
         else
         {
            return;
         }
      }
   }
}
