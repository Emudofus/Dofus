package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TitleSelectedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TitleSelectedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6366;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var titleId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6366;
      }
      
      public function initTitleSelectedMessage(param1:uint = 0) : TitleSelectedMessage
      {
         this.titleId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.titleId = 0;
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
         this.serializeAs_TitleSelectedMessage(param1);
      }
      
      public function serializeAs_TitleSelectedMessage(param1:ICustomDataOutput) : void
      {
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
         }
         else
         {
            param1.writeVarShort(this.titleId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TitleSelectedMessage(param1);
      }
      
      public function deserializeAs_TitleSelectedMessage(param1:ICustomDataInput) : void
      {
         this.titleId = param1.readVarUhShort();
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
