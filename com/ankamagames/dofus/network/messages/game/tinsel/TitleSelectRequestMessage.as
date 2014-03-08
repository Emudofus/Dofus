package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TitleSelectRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TitleSelectRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6365;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var titleId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6365;
      }
      
      public function initTitleSelectRequestMessage(param1:uint=0) : TitleSelectRequestMessage {
         this.titleId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.titleId = 0;
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
         this.serializeAs_TitleSelectRequestMessage(param1);
      }
      
      public function serializeAs_TitleSelectRequestMessage(param1:IDataOutput) : void {
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
         }
         else
         {
            param1.writeShort(this.titleId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TitleSelectRequestMessage(param1);
      }
      
      public function deserializeAs_TitleSelectRequestMessage(param1:IDataInput) : void {
         this.titleId = param1.readShort();
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element of TitleSelectRequestMessage.titleId.");
         }
         else
         {
            return;
         }
      }
   }
}
