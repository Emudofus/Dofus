package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightSpectatePlayerRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightSpectatePlayerRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6474;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var playerId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6474;
      }
      
      public function initGameFightSpectatePlayerRequestMessage(param1:int = 0) : GameFightSpectatePlayerRequestMessage
      {
         this.playerId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerId = 0;
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
         this.serializeAs_GameFightSpectatePlayerRequestMessage(param1);
      }
      
      public function serializeAs_GameFightSpectatePlayerRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.playerId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightSpectatePlayerRequestMessage(param1);
      }
      
      public function deserializeAs_GameFightSpectatePlayerRequestMessage(param1:ICustomDataInput) : void
      {
         this.playerId = param1.readInt();
      }
   }
}
