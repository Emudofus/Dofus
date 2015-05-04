package com.ankamagames.dofus.network.messages.web.ankabox
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MailStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MailStatusMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6275;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var unread:uint = 0;
      
      public var total:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6275;
      }
      
      public function initMailStatusMessage(param1:uint = 0, param2:uint = 0) : MailStatusMessage
      {
         this.unread = param1;
         this.total = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.unread = 0;
         this.total = 0;
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
         this.serializeAs_MailStatusMessage(param1);
      }
      
      public function serializeAs_MailStatusMessage(param1:ICustomDataOutput) : void
      {
         if(this.unread < 0)
         {
            throw new Error("Forbidden value (" + this.unread + ") on element unread.");
         }
         else
         {
            param1.writeVarShort(this.unread);
            if(this.total < 0)
            {
               throw new Error("Forbidden value (" + this.total + ") on element total.");
            }
            else
            {
               param1.writeVarShort(this.total);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MailStatusMessage(param1);
      }
      
      public function deserializeAs_MailStatusMessage(param1:ICustomDataInput) : void
      {
         this.unread = param1.readVarUhShort();
         if(this.unread < 0)
         {
            throw new Error("Forbidden value (" + this.unread + ") on element of MailStatusMessage.unread.");
         }
         else
         {
            this.total = param1.readVarUhShort();
            if(this.total < 0)
            {
               throw new Error("Forbidden value (" + this.total + ") on element of MailStatusMessage.total.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
