package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LockableStateUpdateAbstractMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LockableStateUpdateAbstractMessage() {
         super();
      }
      
      public static const protocolId:uint = 5671;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var locked:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5671;
      }
      
      public function initLockableStateUpdateAbstractMessage(locked:Boolean = false) : LockableStateUpdateAbstractMessage {
         this.locked = locked;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.locked = false;
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
         this.serializeAs_LockableStateUpdateAbstractMessage(output);
      }
      
      public function serializeAs_LockableStateUpdateAbstractMessage(output:IDataOutput) : void {
         output.writeBoolean(this.locked);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LockableStateUpdateAbstractMessage(input);
      }
      
      public function deserializeAs_LockableStateUpdateAbstractMessage(input:IDataInput) : void {
         this.locked = input.readBoolean();
      }
   }
}
