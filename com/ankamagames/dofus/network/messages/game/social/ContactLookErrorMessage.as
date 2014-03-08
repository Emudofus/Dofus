package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ContactLookErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ContactLookErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6045;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var requestId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6045;
      }
      
      public function initContactLookErrorMessage(param1:uint=0) : ContactLookErrorMessage {
         this.requestId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.requestId = 0;
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
         this.serializeAs_ContactLookErrorMessage(param1);
      }
      
      public function serializeAs_ContactLookErrorMessage(param1:IDataOutput) : void {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            param1.writeInt(this.requestId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ContactLookErrorMessage(param1);
      }
      
      public function deserializeAs_ContactLookErrorMessage(param1:IDataInput) : void {
         this.requestId = param1.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookErrorMessage.requestId.");
         }
         else
         {
            return;
         }
      }
   }
}
