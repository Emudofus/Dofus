package com.ankamagames.dofus.network.messages.game.script
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class URLOpenMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function URLOpenMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6266;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var urlId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6266;
      }
      
      public function initURLOpenMessage(param1:uint = 0) : URLOpenMessage
      {
         this.urlId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.urlId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_URLOpenMessage(param1);
      }
      
      public function serializeAs_URLOpenMessage(param1:ICustomDataOutput) : void
      {
         if(this.urlId < 0)
         {
            throw new Error("Forbidden value (" + this.urlId + ") on element urlId.");
         }
         else
         {
            param1.writeByte(this.urlId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_URLOpenMessage(param1);
      }
      
      public function deserializeAs_URLOpenMessage(param1:ICustomDataInput) : void
      {
         this.urlId = param1.readByte();
         if(this.urlId < 0)
         {
            throw new Error("Forbidden value (" + this.urlId + ") on element of URLOpenMessage.urlId.");
         }
         else
         {
            return;
         }
      }
   }
}
