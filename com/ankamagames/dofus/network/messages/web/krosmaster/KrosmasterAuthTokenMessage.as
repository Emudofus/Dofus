package com.ankamagames.dofus.network.messages.web.krosmaster
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class KrosmasterAuthTokenMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KrosmasterAuthTokenMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6351;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var token:String = "";
      
      override public function getMessageId() : uint
      {
         return 6351;
      }
      
      public function initKrosmasterAuthTokenMessage(param1:String = "") : KrosmasterAuthTokenMessage
      {
         this.token = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.token = "";
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
         this.serializeAs_KrosmasterAuthTokenMessage(param1);
      }
      
      public function serializeAs_KrosmasterAuthTokenMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.token);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_KrosmasterAuthTokenMessage(param1);
      }
      
      public function deserializeAs_KrosmasterAuthTokenMessage(param1:ICustomDataInput) : void
      {
         this.token = param1.readUTF();
      }
   }
}
