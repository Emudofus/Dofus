package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeLeaveMessage extends LeaveDialogMessage implements INetworkMessage
   {
      
      public function ExchangeLeaveMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5628;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var success:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5628;
      }
      
      public function initExchangeLeaveMessage(param1:uint = 0, param2:Boolean = false) : ExchangeLeaveMessage
      {
         super.initLeaveDialogMessage(param1);
         this.success = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.success = false;
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeLeaveMessage(param1);
      }
      
      public function serializeAs_ExchangeLeaveMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_LeaveDialogMessage(param1);
         param1.writeBoolean(this.success);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeLeaveMessage(param1);
      }
      
      public function deserializeAs_ExchangeLeaveMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.success = param1.readBoolean();
      }
   }
}
