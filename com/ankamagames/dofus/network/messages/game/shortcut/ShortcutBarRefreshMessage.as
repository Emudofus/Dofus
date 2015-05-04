package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class ShortcutBarRefreshMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShortcutBarRefreshMessage()
      {
         this.shortcut = new Shortcut();
         super();
      }
      
      public static const protocolId:uint = 6229;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var barType:uint = 0;
      
      public var shortcut:Shortcut;
      
      override public function getMessageId() : uint
      {
         return 6229;
      }
      
      public function initShortcutBarRefreshMessage(param1:uint = 0, param2:Shortcut = null) : ShortcutBarRefreshMessage
      {
         this.barType = param1;
         this.shortcut = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.barType = 0;
         this.shortcut = new Shortcut();
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
         this.serializeAs_ShortcutBarRefreshMessage(param1);
      }
      
      public function serializeAs_ShortcutBarRefreshMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.barType);
         param1.writeShort(this.shortcut.getTypeId());
         this.shortcut.serialize(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarRefreshMessage(param1);
      }
      
      public function deserializeAs_ShortcutBarRefreshMessage(param1:ICustomDataInput) : void
      {
         this.barType = param1.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarRefreshMessage.barType.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            this.shortcut = ProtocolTypeManager.getInstance(Shortcut,_loc2_);
            this.shortcut.deserialize(param1);
            return;
         }
      }
   }
}
