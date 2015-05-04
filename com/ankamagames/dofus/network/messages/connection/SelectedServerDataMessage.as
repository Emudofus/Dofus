package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class SelectedServerDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SelectedServerDataMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 42;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var serverId:uint = 0;
      
      public var address:String = "";
      
      public var port:uint = 0;
      
      public var ssl:Boolean = false;
      
      public var canCreateNewCharacter:Boolean = false;
      
      public var ticket:String = "";
      
      override public function getMessageId() : uint
      {
         return 42;
      }
      
      public function initSelectedServerDataMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:Boolean = false, param5:Boolean = false, param6:String = "") : SelectedServerDataMessage
      {
         this.serverId = param1;
         this.address = param2;
         this.port = param3;
         this.ssl = param4;
         this.canCreateNewCharacter = param5;
         this.ticket = param6;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.serverId = 0;
         this.address = "";
         this.port = 0;
         this.ssl = false;
         this.canCreateNewCharacter = false;
         this.ticket = "";
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
         this.serializeAs_SelectedServerDataMessage(param1);
      }
      
      public function serializeAs_SelectedServerDataMessage(param1:ICustomDataOutput) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.ssl);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.canCreateNewCharacter);
         param1.writeByte(_loc2_);
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element serverId.");
         }
         else
         {
            param1.writeVarShort(this.serverId);
            param1.writeUTF(this.address);
            if(this.port < 0 || this.port > 65535)
            {
               throw new Error("Forbidden value (" + this.port + ") on element port.");
            }
            else
            {
               param1.writeShort(this.port);
               param1.writeUTF(this.ticket);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SelectedServerDataMessage(param1);
      }
      
      public function deserializeAs_SelectedServerDataMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readByte();
         this.ssl = BooleanByteWrapper.getFlag(_loc2_,0);
         this.canCreateNewCharacter = BooleanByteWrapper.getFlag(_loc2_,1);
         this.serverId = param1.readVarUhShort();
         if(this.serverId < 0)
         {
            throw new Error("Forbidden value (" + this.serverId + ") on element of SelectedServerDataMessage.serverId.");
         }
         else
         {
            this.address = param1.readUTF();
            this.port = param1.readUnsignedShort();
            if(this.port < 0 || this.port > 65535)
            {
               throw new Error("Forbidden value (" + this.port + ") on element of SelectedServerDataMessage.port.");
            }
            else
            {
               this.ticket = param1.readUTF();
               return;
            }
         }
      }
   }
}
