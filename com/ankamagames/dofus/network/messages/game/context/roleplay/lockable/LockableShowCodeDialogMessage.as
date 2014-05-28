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
      
      public function initLockableShowCodeDialogMessage(changeOrUse:Boolean = false, codeSize:uint = 0) : LockableShowCodeDialogMessage {
         this.changeOrUse = changeOrUse;
         this.codeSize = codeSize;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.changeOrUse = false;
         this.codeSize = 0;
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
         this.serializeAs_LockableShowCodeDialogMessage(output);
      }
      
      public function serializeAs_LockableShowCodeDialogMessage(output:IDataOutput) : void {
         output.writeBoolean(this.changeOrUse);
         if(this.codeSize < 0)
         {
            throw new Error("Forbidden value (" + this.codeSize + ") on element codeSize.");
         }
         else
         {
            output.writeByte(this.codeSize);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LockableShowCodeDialogMessage(input);
      }
      
      public function deserializeAs_LockableShowCodeDialogMessage(input:IDataInput) : void {
         this.changeOrUse = input.readBoolean();
         this.codeSize = input.readByte();
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
