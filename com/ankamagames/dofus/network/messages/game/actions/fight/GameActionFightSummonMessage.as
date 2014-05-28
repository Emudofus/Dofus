package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameActionFightSummonMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightSummonMessage() {
         this.summon = new GameFightFighterInformations();
         super();
      }
      
      public static const protocolId:uint = 5825;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var summon:GameFightFighterInformations;
      
      override public function getMessageId() : uint {
         return 5825;
      }
      
      public function initGameActionFightSummonMessage(actionId:uint = 0, sourceId:int = 0, summon:GameFightFighterInformations = null) : GameActionFightSummonMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.summon = summon;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.summon = new GameFightFighterInformations();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionFightSummonMessage(output);
      }
      
      public function serializeAs_GameActionFightSummonMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.summon.getTypeId());
         this.summon.serialize(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightSummonMessage(input);
      }
      
      public function deserializeAs_GameActionFightSummonMessage(input:IDataInput) : void {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.summon = ProtocolTypeManager.getInstance(GameFightFighterInformations,_id1);
         this.summon.deserialize(input);
      }
   }
}
