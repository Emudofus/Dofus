package com.ankamagames.dofus.network.messages.game.context.fight.character
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameFightRefreshFighterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightRefreshFighterMessage()
      {
         this.informations = new GameContextActorInformations();
         super();
      }
      
      public static const protocolId:uint = 6309;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var informations:GameContextActorInformations;
      
      override public function getMessageId() : uint
      {
         return 6309;
      }
      
      public function initGameFightRefreshFighterMessage(param1:GameContextActorInformations = null) : GameFightRefreshFighterMessage
      {
         this.informations = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.informations = new GameContextActorInformations();
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
         this.serializeAs_GameFightRefreshFighterMessage(param1);
      }
      
      public function serializeAs_GameFightRefreshFighterMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.informations.getTypeId());
         this.informations.serialize(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightRefreshFighterMessage(param1);
      }
      
      public function deserializeAs_GameFightRefreshFighterMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameContextActorInformations,_loc2_);
         this.informations.deserialize(param1);
      }
   }
}
