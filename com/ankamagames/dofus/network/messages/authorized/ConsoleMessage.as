package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ConsoleMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ConsoleMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 75;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      public var content:String = "";
      
      override public function getMessageId() : uint
      {
         return 75;
      }
      
      public function initConsoleMessage(param1:uint = 0, param2:String = "") : ConsoleMessage
      {
         this.type = param1;
         this.content = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
         this.content = "";
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
         this.serializeAs_ConsoleMessage(param1);
      }
      
      public function serializeAs_ConsoleMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.type);
         param1.writeUTF(this.content);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ConsoleMessage(param1);
      }
      
      public function deserializeAs_ConsoleMessage(param1:ICustomDataInput) : void
      {
         this.type = param1.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ConsoleMessage.type.");
         }
         else
         {
            this.content = param1.readUTF();
            return;
         }
      }
   }
}
