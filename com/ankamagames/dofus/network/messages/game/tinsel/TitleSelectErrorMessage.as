package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TitleSelectErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TitleSelectErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6373;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 0;
      
      override public function getMessageId() : uint {
         return 6373;
      }
      
      public function initTitleSelectErrorMessage(param1:uint=0) : TitleSelectErrorMessage {
         this.reason = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 0;
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
         this.serializeAs_TitleSelectErrorMessage(param1);
      }
      
      public function serializeAs_TitleSelectErrorMessage(param1:IDataOutput) : void {
         param1.writeByte(this.reason);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TitleSelectErrorMessage(param1);
      }
      
      public function deserializeAs_TitleSelectErrorMessage(param1:IDataInput) : void {
         this.reason = param1.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of TitleSelectErrorMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
