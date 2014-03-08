package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
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
      
      public function initShortcutBarContentMessage(param1:uint=0, param2:Vector.<Shortcut>=null) : ShortcutBarContentMessage {
         this.barType = param1;
         this.shortcuts = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.barType = 0;
         this.shortcuts = new Vector.<Shortcut>();
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
         this.serializeAs_ShortcutBarContentMessage(param1);
      }
      
      public function serializeAs_ShortcutBarContentMessage(param1:IDataOutput) : void {
         param1.writeByte(this.barType);
         param1.writeShort(this.shortcuts.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.shortcuts.length)
         {
            param1.writeShort((this.shortcuts[_loc2_] as Shortcut).getTypeId());
            (this.shortcuts[_loc2_] as Shortcut).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShortcutBarContentMessage(param1);
      }
      
      public function deserializeAs_ShortcutBarContentMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:Shortcut = null;
         this.barType = param1.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarContentMessage.barType.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUnsignedShort();
               _loc5_ = ProtocolTypeManager.getInstance(Shortcut,_loc4_);
               _loc5_.deserialize(param1);
               this.shortcuts.push(_loc5_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
