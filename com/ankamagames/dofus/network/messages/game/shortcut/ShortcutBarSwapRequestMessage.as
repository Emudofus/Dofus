package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShortcutBarSwapRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarSwapRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6230;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var barType:uint = 0;
      
      public var firstSlot:uint = 0;
      
      public var secondSlot:uint = 0;
      
      override public function getMessageId() : uint {
         return 6230;
      }
      
      public function initShortcutBarSwapRequestMessage(param1:uint=0, param2:uint=0, param3:uint=0) : ShortcutBarSwapRequestMessage {
         this.barType = param1;
         this.firstSlot = param2;
         this.secondSlot = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.barType = 0;
         this.firstSlot = 0;
         this.secondSlot = 0;
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
         this.serializeAs_ShortcutBarSwapRequestMessage(param1);
      }
      
      public function serializeAs_ShortcutBarSwapRequestMessage(param1:IDataOutput) : void {
         param1.writeByte(this.barType);
         if(this.firstSlot < 0 || this.firstSlot > 99)
         {
            throw new Error("Forbidden value (" + this.firstSlot + ") on element firstSlot.");
         }
         else
         {
            param1.writeInt(this.firstSlot);
            if(this.secondSlot < 0 || this.secondSlot > 99)
            {
               throw new Error("Forbidden value (" + this.secondSlot + ") on element secondSlot.");
            }
            else
            {
               param1.writeInt(this.secondSlot);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShortcutBarSwapRequestMessage(param1);
      }
      
      public function deserializeAs_ShortcutBarSwapRequestMessage(param1:IDataInput) : void {
         this.barType = param1.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarSwapRequestMessage.barType.");
         }
         else
         {
            this.firstSlot = param1.readInt();
            if(this.firstSlot < 0 || this.firstSlot > 99)
            {
               throw new Error("Forbidden value (" + this.firstSlot + ") on element of ShortcutBarSwapRequestMessage.firstSlot.");
            }
            else
            {
               this.secondSlot = param1.readInt();
               if(this.secondSlot < 0 || this.secondSlot > 99)
               {
                  throw new Error("Forbidden value (" + this.secondSlot + ") on element of ShortcutBarSwapRequestMessage.secondSlot.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
