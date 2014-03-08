package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class ShortcutBarContentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarContentMessage() {
         this.shortcuts = new Vector.<Shortcut>();
         super();
      }
      
      public static const protocolId:uint = 6231;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var barType:uint = 0;
      
      public var shortcuts:Vector.<Shortcut>;
      
      override public function getMessageId() : uint {
         return 6231;
      }
      
      public function initShortcutBarContentMessage(barType:uint=0, shortcuts:Vector.<Shortcut>=null) : ShortcutBarContentMessage {
         this.barType = barType;
         this.shortcuts = shortcuts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.barType = 0;
         this.shortcuts = new Vector.<Shortcut>();
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
         this.serializeAs_ShortcutBarContentMessage(output);
      }
      
      public function serializeAs_ShortcutBarContentMessage(output:IDataOutput) : void {
         output.writeByte(this.barType);
         output.writeShort(this.shortcuts.length);
         var _i2:uint = 0;
         while(_i2 < this.shortcuts.length)
         {
            output.writeShort((this.shortcuts[_i2] as Shortcut).getTypeId());
            (this.shortcuts[_i2] as Shortcut).serialize(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutBarContentMessage(input);
      }
      
      public function deserializeAs_ShortcutBarContentMessage(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:Shortcut = null;
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarContentMessage.barType.");
         }
         else
         {
            _shortcutsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _shortcutsLen)
            {
               _id2 = input.readUnsignedShort();
               _item2 = ProtocolTypeManager.getInstance(Shortcut,_id2);
               _item2.deserialize(input);
               this.shortcuts.push(_item2);
               _i2++;
            }
            return;
         }
      }
   }
}
