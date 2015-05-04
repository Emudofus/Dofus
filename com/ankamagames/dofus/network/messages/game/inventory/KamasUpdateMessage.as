package com.ankamagames.dofus.network.messages.game.inventory
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class KamasUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KamasUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5537;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var kamasTotal:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5537;
      }
      
      public function initKamasUpdateMessage(param1:int = 0) : KamasUpdateMessage
      {
         this.kamasTotal = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kamasTotal = 0;
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
         this.serializeAs_KamasUpdateMessage(param1);
      }
      
      public function serializeAs_KamasUpdateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeVarInt(this.kamasTotal);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_KamasUpdateMessage(param1);
      }
      
      public function deserializeAs_KamasUpdateMessage(param1:ICustomDataInput) : void
      {
         this.kamasTotal = param1.readVarInt();
      }
   }
}
