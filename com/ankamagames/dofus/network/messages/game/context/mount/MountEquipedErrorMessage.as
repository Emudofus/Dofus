package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountEquipedErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountEquipedErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5963;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var errorType:uint = 0;
      
      override public function getMessageId() : uint {
         return 5963;
      }
      
      public function initMountEquipedErrorMessage(param1:uint=0) : MountEquipedErrorMessage {
         this.errorType = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.errorType = 0;
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
         this.serializeAs_MountEquipedErrorMessage(param1);
      }
      
      public function serializeAs_MountEquipedErrorMessage(param1:IDataOutput) : void {
         param1.writeByte(this.errorType);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MountEquipedErrorMessage(param1);
      }
      
      public function deserializeAs_MountEquipedErrorMessage(param1:IDataInput) : void {
         this.errorType = param1.readByte();
         if(this.errorType < 0)
         {
            throw new Error("Forbidden value (" + this.errorType + ") on element of MountEquipedErrorMessage.errorType.");
         }
         else
         {
            return;
         }
      }
   }
}
