package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class BasicPongMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicPongMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 183;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var quiet:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 183;
      }
      
      public function initBasicPongMessage(param1:Boolean = false) : BasicPongMessage
      {
         this.quiet = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.quiet = false;
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
         this.serializeAs_BasicPongMessage(param1);
      }
      
      public function serializeAs_BasicPongMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.quiet);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_BasicPongMessage(param1);
      }
      
      public function deserializeAs_BasicPongMessage(param1:ICustomDataInput) : void
      {
         this.quiet = param1.readBoolean();
      }
   }
}
