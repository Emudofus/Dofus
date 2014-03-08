package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableChangeCodeMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseLockFromInsideRequestMessage extends LockableChangeCodeMessage implements INetworkMessage
   {
      
      public function HouseLockFromInsideRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5885;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5885;
      }
      
      public function initHouseLockFromInsideRequestMessage(code:String="") : HouseLockFromInsideRequestMessage {
         super.initLockableChangeCodeMessage(code);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_HouseLockFromInsideRequestMessage(output);
      }
      
      public function serializeAs_HouseLockFromInsideRequestMessage(output:IDataOutput) : void {
         super.serializeAs_LockableChangeCodeMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseLockFromInsideRequestMessage(input);
      }
      
      public function deserializeAs_HouseLockFromInsideRequestMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
