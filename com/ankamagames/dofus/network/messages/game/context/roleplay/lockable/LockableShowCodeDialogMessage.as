package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LockableShowCodeDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LockableShowCodeDialogMessage() {
         super();
      }
      
      public static const protocolId:uint = 5740;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var changeOrUse:Boolean = false;
      
      public var codeSize:uint = 0;
      
      override public function getMessageId() : uint {
         return 5740;
      }
      
      public function initLockableShowCodeDialogMessage(param1:Boolean=false, param2:uint=0) : LockableShowCodeDialogMessage {
         this.changeOrUse = param1;
         this.codeSize = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.changeOrUse = false;
         this.codeSize = 0;
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
         this.serializeAs_LockableShowCodeDialogMessage(param1);
      }
      
      public function serializeAs_LockableShowCodeDialogMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.changeOrUse);
         if(this.codeSize < 0)
         {
            throw new Error("Forbidden value (" + this.codeSize + ") on element codeSize.");
         }
         else
         {
            param1.writeByte(this.codeSize);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_LockableShowCodeDialogMessage(param1);
      }
      
      public function deserializeAs_LockableShowCodeDialogMessage(param1:IDataInput) : void {
         this.changeOrUse = param1.readBoolean();
         this.codeSize = param1.readByte();
         if(this.codeSize < 0)
         {
            throw new Error("Forbidden value (" + this.codeSize + ") on element of LockableShowCodeDialogMessage.codeSize.");
         }
         else
         {
            return;
         }
      }
   }
}
