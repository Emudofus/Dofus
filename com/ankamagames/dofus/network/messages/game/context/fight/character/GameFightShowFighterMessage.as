package com.ankamagames.dofus.network.messages.game.context.fight.character
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameFightShowFighterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightShowFighterMessage() {
         this.informations = new GameFightFighterInformations();
         super();
      }
      
      public static const protocolId:uint = 5864;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var informations:GameFightFighterInformations;
      
      override public function getMessageId() : uint {
         return 5864;
      }
      
      public function initGameFightShowFighterMessage(param1:GameFightFighterInformations=null) : GameFightShowFighterMessage {
         this.informations = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.informations = new GameFightFighterInformations();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightShowFighterMessage(param1);
      }
      
      public function serializeAs_GameFightShowFighterMessage(param1:IDataOutput) : void {
         param1.writeShort(this.informations.getTypeId());
         this.informations.serialize(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightShowFighterMessage(param1);
      }
      
      public function deserializeAs_GameFightShowFighterMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameFightFighterInformations,_loc2_);
         this.informations.deserialize(param1);
      }
   }
}
