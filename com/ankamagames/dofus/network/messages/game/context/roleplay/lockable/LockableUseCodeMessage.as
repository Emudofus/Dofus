package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class LockableUseCodeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LockableUseCodeMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5667;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var code:String = "";
      
      override public function getMessageId() : uint
      {
         return 5667;
      }
      
      public function initLockableUseCodeMessage(param1:String = "") : LockableUseCodeMessage
      {
         this.code = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.code = "";
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
         this.serializeAs_LockableUseCodeMessage(param1);
      }
      
      public function serializeAs_LockableUseCodeMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.code);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_LockableUseCodeMessage(param1);
      }
      
      public function deserializeAs_LockableUseCodeMessage(param1:ICustomDataInput) : void
      {
         this.code = param1.readUTF();
      }
   }
}
