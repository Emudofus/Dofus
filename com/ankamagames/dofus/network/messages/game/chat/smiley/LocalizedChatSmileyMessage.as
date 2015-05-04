package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class LocalizedChatSmileyMessage extends ChatSmileyMessage implements INetworkMessage
   {
      
      public function LocalizedChatSmileyMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6185;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var cellId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6185;
      }
      
      public function initLocalizedChatSmileyMessage(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : LocalizedChatSmileyMessage
      {
         super.initChatSmileyMessage(param1,param2,param3);
         this.cellId = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.cellId = 0;
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_LocalizedChatSmileyMessage(param1);
      }
      
      public function serializeAs_LocalizedChatSmileyMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ChatSmileyMessage(param1);
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            param1.writeVarShort(this.cellId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_LocalizedChatSmileyMessage(param1);
      }
      
      public function deserializeAs_LocalizedChatSmileyMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.cellId = param1.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of LocalizedChatSmileyMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }
}
