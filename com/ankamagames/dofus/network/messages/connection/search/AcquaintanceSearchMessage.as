package com.ankamagames.dofus.network.messages.connection.search
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AcquaintanceSearchMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AcquaintanceSearchMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6144;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var nickname:String = "";
      
      override public function getMessageId() : uint
      {
         return 6144;
      }
      
      public function initAcquaintanceSearchMessage(param1:String = "") : AcquaintanceSearchMessage
      {
         this.nickname = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.nickname = "";
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
         this.serializeAs_AcquaintanceSearchMessage(param1);
      }
      
      public function serializeAs_AcquaintanceSearchMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.nickname);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AcquaintanceSearchMessage(param1);
      }
      
      public function deserializeAs_AcquaintanceSearchMessage(param1:ICustomDataInput) : void
      {
         this.nickname = param1.readUTF();
      }
   }
}
