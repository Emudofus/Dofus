package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShortcutBarRemoveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarRemoveRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6228;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var barType:uint = 0;
      
      public var slot:uint = 0;
      
      override public function getMessageId() : uint {
         return 6228;
      }
      
      public function initShortcutBarRemoveRequestMessage(param1:uint=0, param2:uint=0) : ShortcutBarRemoveRequestMessage {
         this.barType = param1;
         this.slot = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.barType = 0;
         this.slot = 0;
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
         this.serializeAs_ShortcutBarRemoveRequestMessage(param1);
      }
      
      public function serializeAs_ShortcutBarRemoveRequestMessage(param1:IDataOutput) : void {
         param1.writeByte(this.barType);
         if(this.slot < 0 || this.slot > 99)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         else
         {
            param1.writeInt(this.slot);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShortcutBarRemoveRequestMessage(param1);
      }
      
      public function deserializeAs_ShortcutBarRemoveRequestMessage(param1:IDataInput) : void {
         this.barType = param1.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarRemoveRequestMessage.barType.");
         }
         else
         {
            this.slot = param1.readInt();
            if(this.slot < 0 || this.slot > 99)
            {
               throw new Error("Forbidden value (" + this.slot + ") on element of ShortcutBarRemoveRequestMessage.slot.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
