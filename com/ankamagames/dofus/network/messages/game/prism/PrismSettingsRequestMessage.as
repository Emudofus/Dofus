package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismSettingsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismSettingsRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6437;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var startDefenseTime:uint = 0;
      
      override public function getMessageId() : uint {
         return 6437;
      }
      
      public function initPrismSettingsRequestMessage(subAreaId:uint = 0, startDefenseTime:uint = 0) : PrismSettingsRequestMessage {
         this.subAreaId = subAreaId;
         this.startDefenseTime = startDefenseTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.startDefenseTime = 0;
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
         this.serializeAs_PrismSettingsRequestMessage(output);
      }
      
      public function serializeAs_PrismSettingsRequestMessage(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            if(this.startDefenseTime < 0)
            {
               throw new Error("Forbidden value (" + this.startDefenseTime + ") on element startDefenseTime.");
            }
            else
            {
               output.writeByte(this.startDefenseTime);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismSettingsRequestMessage(input);
      }
      
      public function deserializeAs_PrismSettingsRequestMessage(input:IDataInput) : void {
         this.subAreaId = input.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSettingsRequestMessage.subAreaId.");
         }
         else
         {
            this.startDefenseTime = input.readByte();
            if(this.startDefenseTime < 0)
            {
               throw new Error("Forbidden value (" + this.startDefenseTime + ") on element of PrismSettingsRequestMessage.startDefenseTime.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
