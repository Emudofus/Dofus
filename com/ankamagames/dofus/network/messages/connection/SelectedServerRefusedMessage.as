package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SelectedServerRefusedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SelectedServerRefusedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 41;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var serverId:uint = 0;
      
      public var error:uint = 1;
      
      public var serverStatus:uint = 1;
      
      override public function getMessageId() : uint
      {
         return 41;
      }
      
      public function initSelectedServerRefusedMessage(param1:uint = 0, param2:uint = 1, param3:uint = 1) : SelectedServerRefusedMessage
      {
         this.serverId = param1;
         this.error = param2;
         this.serverStatus = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.serverId = 0;
         this.error = 1;
         this.serverStatus = 1;
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
         this.serializeAs_SelectedServerRefusedMessage(param1);
      }
      
      public function serializeAs_SelectedServerRefusedMessage(param1:ICustomDataOutput) : void
      {
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element serverId.");
         }
         else
         {
            param1.writeVarShort(this.serverId);
            param1.writeByte(this.error);
            param1.writeByte(this.serverStatus);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SelectedServerRefusedMessage(param1);
      }
      
      public function deserializeAs_SelectedServerRefusedMessage(param1:ICustomDataInput) : void
      {
         this.serverId = param1.readVarUhShort();
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element of SelectedServerRefusedMessage.serverId.");
         }
         else
         {
            this.error = param1.readByte();
            if(this.error < 0)
            {
               throw new Error("Forbidden value (" + this.error + ") on element of SelectedServerRefusedMessage.error.");
            }
            else
            {
               this.serverStatus = param1.readByte();
               if(this.serverStatus < 0)
               {
                  throw new Error("Forbidden value (" + this.serverStatus + ") on element of SelectedServerRefusedMessage.serverStatus.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
