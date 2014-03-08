package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PrismFightDefenderAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightDefenderAddMessage() {
         this.defender = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      public static const protocolId:uint = 5895;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var fightId:Number = 0;
      
      public var defender:CharacterMinimalPlusLookInformations;
      
      override public function getMessageId() : uint {
         return 5895;
      }
      
      public function initPrismFightDefenderAddMessage(subAreaId:uint=0, fightId:Number=0, defender:CharacterMinimalPlusLookInformations=null) : PrismFightDefenderAddMessage {
         this.subAreaId = subAreaId;
         this.fightId = fightId;
         this.defender = defender;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.fightId = 0;
         this.defender = new CharacterMinimalPlusLookInformations();
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
         this.serializeAs_PrismFightDefenderAddMessage(output);
      }
      
      public function serializeAs_PrismFightDefenderAddMessage(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            output.writeDouble(this.fightId);
            output.writeShort(this.defender.getTypeId());
            this.defender.serialize(output);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightDefenderAddMessage(input);
      }
      
      public function deserializeAs_PrismFightDefenderAddMessage(input:IDataInput) : void {
         this.subAreaId = input.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightDefenderAddMessage.subAreaId.");
         }
         else
         {
            this.fightId = input.readDouble();
            _id3 = input.readUnsignedShort();
            this.defender = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id3);
            this.defender.deserialize(input);
            return;
         }
      }
   }
}
