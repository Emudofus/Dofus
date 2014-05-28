package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountSetXpRatioRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountSetXpRatioRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5989;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var xpRatio:uint = 0;
      
      override public function getMessageId() : uint {
         return 5989;
      }
      
      public function initMountSetXpRatioRequestMessage(xpRatio:uint = 0) : MountSetXpRatioRequestMessage {
         this.xpRatio = xpRatio;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.xpRatio = 0;
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
         this.serializeAs_MountSetXpRatioRequestMessage(output);
      }
      
      public function serializeAs_MountSetXpRatioRequestMessage(output:IDataOutput) : void {
         if(this.xpRatio < 0)
         {
            throw new Error("Forbidden value (" + this.xpRatio + ") on element xpRatio.");
         }
         else
         {
            output.writeByte(this.xpRatio);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountSetXpRatioRequestMessage(input);
      }
      
      public function deserializeAs_MountSetXpRatioRequestMessage(input:IDataInput) : void {
         this.xpRatio = input.readByte();
         if(this.xpRatio < 0)
         {
            throw new Error("Forbidden value (" + this.xpRatio + ") on element of MountSetXpRatioRequestMessage.xpRatio.");
         }
         else
         {
            return;
         }
      }
   }
}
