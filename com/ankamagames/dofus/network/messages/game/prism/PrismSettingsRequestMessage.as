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
      
      public function initPrismSettingsRequestMessage(param1:uint=0, param2:uint=0) : PrismSettingsRequestMessage {
         this.subAreaId = param1;
         this.startDefenseTime = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.startDefenseTime = 0;
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
         this.serializeAs_PrismSettingsRequestMessage(param1);
      }
      
      public function serializeAs_PrismSettingsRequestMessage(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeShort(this.subAreaId);
            if(this.startDefenseTime < 0)
            {
               throw new Error("Forbidden value (" + this.startDefenseTime + ") on element startDefenseTime.");
            }
            else
            {
               param1.writeByte(this.startDefenseTime);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismSettingsRequestMessage(param1);
      }
      
      public function deserializeAs_PrismSettingsRequestMessage(param1:IDataInput) : void {
         this.subAreaId = param1.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSettingsRequestMessage.subAreaId.");
         }
         else
         {
            this.startDefenseTime = param1.readByte();
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
