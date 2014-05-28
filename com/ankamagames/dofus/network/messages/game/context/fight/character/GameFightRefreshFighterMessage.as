package com.ankamagames.dofus.network.messages.game.context.fight.character
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameFightRefreshFighterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightRefreshFighterMessage() {
         this.informations = new GameContextActorInformations();
         super();
      }
      
      public static const protocolId:uint = 6309;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var informations:GameContextActorInformations;
      
      override public function getMessageId() : uint {
         return 6309;
      }
      
      public function initGameFightRefreshFighterMessage(informations:GameContextActorInformations = null) : GameFightRefreshFighterMessage {
         this.informations = informations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.informations = new GameContextActorInformations();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightRefreshFighterMessage(output);
      }
      
      public function serializeAs_GameFightRefreshFighterMessage(output:IDataOutput) : void {
         output.writeShort(this.informations.getTypeId());
         this.informations.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightRefreshFighterMessage(input);
      }
      
      public function deserializeAs_GameFightRefreshFighterMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameContextActorInformations,_id1);
         this.informations.deserialize(input);
      }
   }
}
