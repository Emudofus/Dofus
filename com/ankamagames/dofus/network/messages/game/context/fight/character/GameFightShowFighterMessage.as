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
      
      public function initGameFightShowFighterMessage(informations:GameFightFighterInformations = null) : GameFightShowFighterMessage {
         this.informations = informations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.informations = new GameFightFighterInformations();
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
         this.serializeAs_GameFightShowFighterMessage(output);
      }
      
      public function serializeAs_GameFightShowFighterMessage(output:IDataOutput) : void {
         output.writeShort(this.informations.getTypeId());
         this.informations.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightShowFighterMessage(input);
      }
      
      public function deserializeAs_GameFightShowFighterMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameFightFighterInformations,_id1);
         this.informations.deserialize(input);
      }
   }
}
