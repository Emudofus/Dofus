package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TitleSelectedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TitleSelectedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6366;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var titleId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6366;
      }
      
      public function initTitleSelectedMessage(param1:uint=0) : TitleSelectedMessage {
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
         this.serializeAs_TitleSelectedMessage(param1);
      }
      
      public function serializeAs_TitleSelectedMessage(param1:IDataOutput) : void {
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
         this.deserializeAs_TitleSelectedMessage(param1);
      }
      
      public function deserializeAs_TitleSelectedMessage(param1:IDataInput) : void {
         this.titleId = param1.readShort();
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element of TitleSelectedMessage.titleId.");
         }
         else
         {
            return;
         }
      }
   }
}
