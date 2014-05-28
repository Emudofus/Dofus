package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountDataErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountDataErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6172;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 0;
      
      override public function getMessageId() : uint {
         return 6172;
      }
      
      public function initMountDataErrorMessage(reason:uint = 0) : MountDataErrorMessage {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 0;
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
         this.serializeAs_MountDataErrorMessage(output);
      }
      
      public function serializeAs_MountDataErrorMessage(output:IDataOutput) : void {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountDataErrorMessage(input);
      }
      
      public function deserializeAs_MountDataErrorMessage(input:IDataInput) : void {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of MountDataErrorMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
