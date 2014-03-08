package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ContactLookRequestByIdMessage extends ContactLookRequestMessage implements INetworkMessage
   {
      
      public function ContactLookRequestByIdMessage() {
         super();
      }
      
      public static const protocolId:uint = 5935;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var playerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5935;
      }
      
      public function initContactLookRequestByIdMessage(param1:uint=0, param2:uint=0, param3:uint=0) : ContactLookRequestByIdMessage {
         super.initContactLookRequestMessage(param1,param2);
         this.playerId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ContactLookRequestByIdMessage(param1);
      }
      
      public function serializeAs_ContactLookRequestByIdMessage(param1:IDataOutput) : void {
         super.serializeAs_ContactLookRequestMessage(param1);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ContactLookRequestByIdMessage(param1);
      }
      
      public function deserializeAs_ContactLookRequestByIdMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of ContactLookRequestByIdMessage.playerId.");
         }
         else
         {
            return;
         }
      }
   }
}
