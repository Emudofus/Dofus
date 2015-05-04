package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class IgnoredAddRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredAddRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5673;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      public var session:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5673;
      }
      
      public function initIgnoredAddRequestMessage(param1:String = "", param2:Boolean = false) : IgnoredAddRequestMessage
      {
         this.name = param1;
         this.session = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.name = "";
         this.session = false;
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
         this.serializeAs_IgnoredAddRequestMessage(param1);
      }
      
      public function serializeAs_IgnoredAddRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.name);
         param1.writeBoolean(this.session);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_IgnoredAddRequestMessage(param1);
      }
      
      public function deserializeAs_IgnoredAddRequestMessage(param1:ICustomDataInput) : void
      {
         this.name = param1.readUTF();
         this.session = param1.readBoolean();
      }
   }
}
